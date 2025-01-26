defmodule SbgInv.Web.ScenarioFactionView do

  use SbgInv.Web, :view

  def render("faction_overview.json", %{scenario_faction: faction}) do
    base_faction(faction)
  end

  def render("faction_detail.json", %{scenario_faction: faction}) do
    Map.put base_faction(faction),
            :roles,
            render_many(Enum.sort(faction.roles, &(&1.sort_order < &2.sort_order)),
                        SbgInv.Web.RoleView,
                        "role.json")
  end

  def render("faction_detail_for_user.json", %{scenario_faction: faction}) do
    Map.put base_faction(faction),
            :roles,
            render_many(Enum.sort(faction.roles, &(&1.sort_order < &2.sort_order)),
                        SbgInv.Web.RoleView,
                        "role_for_user.json")
  end

  defp base_faction(faction) do
    %{
      id: faction.id,
      suggested_points: faction.suggested_points,
      actual_points: faction.actual_points,
      sort_order: faction.sort_order,
    }
  end
end
