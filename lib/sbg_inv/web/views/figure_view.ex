defmodule SbgInv.Web.FigureView do

  use SbgInv.Web, :view

  alias SbgInv.Web.ScenarioResourceView

  def render("figure.json", params_map) do
    figure = params_map.figure

    # Can't use Map.get/3 here because the :figure_stats key exists in the map (even though nil for new figures)
    stats = Map.get(params_map, :figure_stats) || %{total_owned: 0, total_painted: 0}

    %{data: %{
         "id" => figure.id,
         "name" => figure.name,
         "unique" => figure.unique,
         "type" => figure.type,
         "plural_name" => figure.plural_name,
         "slug" => figure.slug,
         "factions" => Enum.map(figure.faction_figure, &(&1.army_list.abbrev)) |> Enum.sort(&(&1 <= &2)),
         "scenarios" => sorted_scenarios(figure.role),
         "owned" => user_figure_attr(figure.user_figure, :owned),
         "painted" => user_figure_attr(figure.user_figure, :painted),
         "history" => sorted_history(figure.user_figure_history),
         "rules" => rules(figure.characters),
         "resources" => resources(figure.characters),
         "total_owned" => stats.total_owned,
         "total_painted" => stats.total_painted
      }
    }
  end

  defp user_figure_attr([], _), do: 0
  defp user_figure_attr([ first_elt | _rest ], attr_name), do: Map.get(first_elt, attr_name)

  defp rules(nil), do: []
  defp rules(ary) do
    Enum.flat_map(ary, fn char -> char.rules end)
    |> render_many(SbgInv.Web.CharacterRuleView, "rule.json", as: :rule)
  end

  defp resources(nil), do: []
  defp resources(ary) do
    Enum.flat_map(ary, fn char -> char.resources end)
    |> render_many(SbgInv.Web.CharacterResourceView, "resource.json", as: :resource)
  end

  defp sorted_scenarios(role_list) do
    role_list
    |> Enum.sort_by(fn(role) -> normalized_name(role.scenario_faction.scenario.name) end)
    |> Enum.map(fn(role) ->
                  %{
                    "scenario_id" => role.scenario_faction.scenario.id,
                    "name" => role.scenario_faction.scenario.name,
                    "amount" => role.amount,
                    "source" => render_one(Enum.find(role.scenario_faction.scenario.scenario_resources, &(&1.resource_type == :source)),
                                           ScenarioResourceView,
                                           "resource.json")
                  }
                end)
  end

  defp sorted_history(history_list) do
    history_list  # history is sorted by db
    |> Enum.reverse
    |> Enum.map(fn(h) -> %{
        "id" => h.id,
        "figure_id" => h.figure_id,
        "op" => h.op,
        "amount" => h.amount,
        "new_owned" => h.new_owned,
        "new_painted" => h.new_painted,
        "op_date" => h.op_date,
        "notes" => if(h.notes, do: h.notes, else: "")
    }
    end)
  end

  defp normalized_name(str) do
    Regex.replace(~r/É/, Regex.replace(~r/^(The|A) /, str, ""), "E")
  end
end
