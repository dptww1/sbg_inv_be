defmodule SbgInv.ScenarioView do
  use SbgInv.Web, :view

  def render("index.json", %{scenarios: scenarios}) do
    %{data: render_many(scenarios, __MODULE__, "scenario.json")}
  end

  def render("show.json", %{scenario: scenario}) do
    %{data: render_one(scenario, SbgInv.ScenarioView, "scenario.json")}
  end

  def render("scenario.json", %{scenario: scenario}) do
    %{id: scenario.id,
      name: scenario.name,
      blurb: scenario.blurb,
      date_age: scenario.date_age,
      date_year: scenario.date_year,
      is_canonical: scenario.is_canonical,
      size: scenario.size,
      scenario_resources: render_one(massage_resources(scenario.scenario_resources), __MODULE__, "scenario_resources.json"),
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

  def render("scenario_faction.json", %{scenario_faction: faction}) do
    %{
      faction: faction.faction,
      suggested_points: faction.suggested_points,
      actual_points: faction.actual_points,
      sort_order: faction.sort_order
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
