defmodule SbgInv.Web.FigureView do

  use SbgInv.Web, :view

  def render("figure.json", %{figure: figure}) do
    %{data: %{
         "id" => figure.id,
         "name" => figure.name,
         "plural_name" => figure.plural_name,
         "factions" => Enum.map(figure.faction_figure, &(&1.faction_id)) |> Enum.sort(&(&1 <= &2)),
         "scenarios" => sorted_scenarios(figure.role),
         "owned" => if(length(figure.user_figure) > 0, do: hd(figure.user_figure).owned, else: 0),
         "painted" => if(length(figure.user_figure) > 0, do: hd(figure.user_figure).painted, else: 0),
         "history" => sorted_history(figure.user_figure_history)
         }
    }
  end

  defp sorted_scenarios(role_list) do
    Enum.sort_by(role_list, fn(role) -> normalized_name(role.scenario_faction.scenario.name) end)
    |> Enum.map(fn(role) ->
                  %{
                    "scenario_id" => role.scenario_faction.scenario.id,
                    "name" => role.scenario_faction.scenario.name,
                    "amount" => role.amount
                  }
                end)
  end

  defp sorted_history(history_list) do
    Enum.sort_by(history_list, fn(h) -> h.op_date end)
    |> Enum.reverse
    |> Enum.map(fn(h) -> %{
        "op" => h.op,
        "amount" => h.amount,
        "new_owned" => h.new_owned,
        "new_painted" => h.new_painted,
        "date" => h.op_date,
        "notes" => if(h.notes, do: h.notes, else: "")
    }
    end)
  end

  defp normalized_name(str) do
    Regex.replace(~r/É/, Regex.replace(~r/^(The|A) /, str, ""), "E")
  end
end
