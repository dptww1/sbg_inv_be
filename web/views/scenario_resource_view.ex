defmodule SbgInv.ScenarioResourceView do
  use SbgInv.Web, :view

  def render("resources.json", %{scenario_resource: resources}) do
    %{
      source:           render_many(resources.source,           __MODULE__, "resource.json"),
      video_replay:     render_many(resources.video_replay,     __MODULE__, "resource.json"),
      web_replay:       render_many(resources.web_replay,       __MODULE__, "resource.json"),
      terrain_building: render_many(resources.terrain_building, __MODULE__, "resource.json"),
      podcast:          render_many(resources.podcast,          __MODULE__, "resource.json")
    }
  end

  def render("resource.json", %{scenario_resource: resource}) do
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
end
