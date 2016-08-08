defmodule SbgInv.ScenarioFactionView do
  use SbgInv.Web, :view

  def render("faction_overview.json", %{scenario_faction: faction}) do
    base_faction(faction)
  end

  def render("faction_detail.json", %{scenario_faction: faction}) do
    Map.merge base_faction(faction), %{
      figures: render_many(faction.scenario_faction_figures, SbgInv.ScenarioFactionFigureView, "scenario_faction_figure.json")
    }
  end

  defp base_faction(faction) do
    %{
      faction: faction.faction,
      suggested_points: faction.suggested_points,
      actual_points: faction.actual_points,
      sort_order: faction.sort_order,
    }
  end
end
