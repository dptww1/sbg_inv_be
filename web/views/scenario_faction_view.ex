defmodule SbgInv.ScenarioFactionView do
  use SbgInv.Web, :view

  def render("faction_overview.json", %{scenario_faction: faction}) do
    base_faction(faction)
  end

  def render("faction_detail.json", %{scenario_faction: faction, user_id: user_id}) do
    Map.merge base_faction(faction), %{
      roles: render_many(faction.roles, SbgInv.RoleView, "role.json", %{user_id: user_id})
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
