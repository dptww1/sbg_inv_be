defmodule SbgInv.ScenarioView do
  use SbgInv.Web, :view

  def render("index.json", %{scenarios: scenarios}) do
    %{data: render_many(scenarios, __MODULE__, "scenario_overview.json")}
  end

  def render("scenario_overview.json", %{scenario: scenario}) do
    Map.merge base_scenario(scenario), %{
      scenario_factions: Enum.map(scenario.scenario_factions, fn f -> base_faction(f) end)
    }
  end

  def render("show.json", %{scenario: scenario}) do
    %{data: render_one(scenario, __MODULE__, "scenario.json")}
  end

  defp base_scenario(scenario) do
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
      scenario_resources: render_one(massage_resources(scenario.scenario_resources), __MODULE__, "scenario_resources.json"),
    }
  end

  def render("scenario.json", %{scenario: scenario}) do
    Map.merge base_scenario(scenario), %{
      scenario_factions: render_many(scenario.scenario_factions, __MODULE__, "scenario_faction.json", as: :scenario_faction)
    }
  end

  def render("scenario_resources.json", %{scenario: scenario_resources}) do
    %{
      source:           render_many(scenario_resources.source,           __MODULE__, "scenario_resource.json"),
      video_replay:     render_many(scenario_resources.video_replay,     __MODULE__, "scenario_resource.json"),
      web_replay:       render_many(scenario_resources.web_replay,       __MODULE__, "scenario_resource.json"),
      terrain_building: render_many(scenario_resources.terrain_building, __MODULE__, "scenario_resource.json"),
      podcast:          render_many(scenario_resources.podcast,          __MODULE__, "scenario_resource.json")
    }
  end

  def render("scenario_resource.json", %{scenario: resource}) do
    %{
      resource_type: resource.resource_type,
      book: resource.book,
      title: resource.title,
      url:  resource.url,
      page: resource.page,
      notes: resource.notes,
      sort_order: resource.sort_order
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

  def render("scenario_faction.json", %{scenario_faction: scenario_faction}) do
    Map.merge base_faction(scenario_faction), %{
      figures: render_many(scenario_faction.scenario_faction_figures, __MODULE__ , "scenario_faction_figure.json")
    }
  end

  def render("scenario_faction_figure.json", %{scenario: scenario_faction_figure}) do
    %{
      id: scenario_faction_figure.id,
      amount: scenario_faction_figure.amount,
      name: if(scenario_faction_figure.amount > 1, do: scenario_faction_figure.figure.plural_name, else: scenario_faction_figure.figure.name)
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
