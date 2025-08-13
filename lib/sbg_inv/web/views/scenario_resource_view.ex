defmodule SbgInv.Web.ScenarioResourceView do

  use SbgInv.Web, :view

  def render("index.json", %{resources: resources}) do
    %{data: render_many(resources, __MODULE__, "resource_with_scenario.json")}
  end

  def render("resources.json", %{scenario_resource: resources}) do
    %{
      source:           render_many(Enum.sort(resources.source,           &(&1.sort_order < &2.sort_order)), __MODULE__, "resource.json"),
      video_replay:     render_many(Enum.sort(resources.video_replay,     &(&1.sort_order < &2.sort_order)), __MODULE__, "resource.json"),
      web_replay:       render_many(Enum.sort(resources.web_replay,       &(&1.sort_order < &2.sort_order)), __MODULE__, "resource.json"),
      terrain_building: render_many(Enum.sort(resources.terrain_building, &(&1.sort_order < &2.sort_order)), __MODULE__, "resource.json"),
      podcast:          render_many(Enum.sort(resources.podcast,          &(&1.sort_order < &2.sort_order)), __MODULE__, "resource.json"),
      magazine_replay:  render_many(Enum.sort(resources.magazine_replay,  &(&1.sort_order < &2.sort_order)), __MODULE__, "resource.json")
    }
  end

  def render("resource.json", %{scenario_resource: resource}) do
    %{
      id: resource.id,
      scenario_id: resource.scenario_id,
      resource_type: resource.resource_type,
      book: (if is_nil(resource.book), do: nil, else: resource.book.key),
      issue: resource.issue,
      title: resource.title,
      url:  resource.url,
      page: resource.page,
      sort_order: resource.sort_order,
      date: String.slice(NaiveDateTime.to_string(resource.updated_at), 0..9)
    }
  end

  def render("resource_with_scenario.json", %{scenario_resource: resource}) do
    Map.put(render("resource.json", scenario_resource: resource),
            :scenario_name,
            resource.scenario.name)
  end
end
