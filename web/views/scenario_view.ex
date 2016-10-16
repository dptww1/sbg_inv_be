defmodule SbgInv.ScenarioView do
  use SbgInv.Web, :view

  def render("index.json", %{scenarios: scenarios}) do
    %{data: render_many(scenarios, __MODULE__, "scenario_overview.json")}
  end

  def render("scenario_overview.json", %{scenario: scenario}) do
    Map.merge base_scenario(scenario), %{
      scenario_factions: render_many(Enum.sort(scenario.scenario_factions, &(&1.sort_order < &2.sort_order)), SbgInv.ScenarioFactionView, "faction_overview.json")
    }
  end

  def render("show.json", %{scenario: scenario}) do
    %{data: render_one(scenario, __MODULE__, "scenario.json")}
  end

  def render("scenario.json", %{scenario: scenario}) do
    Map.merge base_scenario(scenario), %{
      scenario_factions: render_many(Enum.sort(scenario.scenario_factions, &(&1.sort_order < &2.sort_order)), SbgInv.ScenarioFactionView, "faction_detail.json")
    }
  end

  defp base_scenario(scenario) do
    user_scenario = if(((length scenario.user_scenarios) > 0), do: hd(scenario.user_scenarios), else: %SbgInv.UserScenario{scenario: scenario})

    %{
      id: scenario.id,
      name: scenario.name,
      blurb: scenario.blurb,
      date_age: scenario.date_age,
      date_month: scenario.date_month,
      date_day: scenario.date_day,
      date_year: scenario.date_year,
      is_canonical: scenario.is_canonical,
      size: scenario.size,
      id: scenario.id,
      rating: if(scenario.rating, do: scenario.rating, else: 0),
      num_votes: if(scenario.num_votes, do: scenario.num_votes, else: 0),
      scenario_resources: render_one(massage_resources(scenario.scenario_resources), SbgInv.ScenarioResourceView, "resources.json"),
      user_scenario: render_one(%{user_scenario | scenario: scenario}, SbgInv.UserScenarioView, "user_scenario.json")
    }
  end

  defp massage_resources(scenario_resources) do
    %{
      source: Enum.filter(scenario_resources, &(&1.resource_type == :source)),
      video_replay: Enum.filter(scenario_resources, fn r -> r.resource_type == :video_replay end),
      web_replay: Enum.filter(scenario_resources, fn r -> r.resource_type == :web_replay end),
      terrain_building: Enum.filter(scenario_resources, fn r -> r.resource_type == :terrain_building end),
      podcast: Enum.filter(scenario_resources, fn r -> r.resource_type == :podcast end),
    }
  end
end
