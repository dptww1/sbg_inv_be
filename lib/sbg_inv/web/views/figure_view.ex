defmodule SbgInv.Web.FigureView do

  use SbgInv.Web, :view

  def render("figure.json", %{figure: figure}) do
    %{data: %{
         "id" => figure.id,
         "name" => figure.name,
         "factions" => Enum.map(figure.faction_figure, &(&1.faction_id)) |> Enum.sort(&(&1 <= &2)),
         "scenarios" => sorted_scenarios(figure.role),
         "owned" => if(length(figure.user_figure) > 0, do: hd(figure.user_figure).owned, else: 0),
         "painted" => if(length(figure.user_figure) > 0, do: hd(figure.user_figure).painted, else: 0)
         }
    }
  end

  defp sorted_scenarios(role_list) do
    Enum.sort_by(role_list, fn(role) -> role.scenario_faction.scenario.name end)
    |> Enum.map(fn(role) ->
                  %{
                    "scenario_id" => role.scenario_faction.scenario.id,
                    "name" => role.scenario_faction.scenario.name,
                    "amount" => role.amount
                  }
                end)
  end
end
