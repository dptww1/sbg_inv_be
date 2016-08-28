defmodule SbgInv.ScenarioResourceView do
  use SbgInv.Web, :view

  def render("resources.json", %{scenario_resource: resources}) do
    %{
      source:           render_many(Enum.sort(resources.source,           &(&1.sort_order < &2.sort_order)), __MODULE__, "resource.json"),
      video_replay:     render_many(Enum.sort(resources.video_replay,     &(&1.sort_order < &2.sort_order)), __MODULE__, "resource.json"),
      web_replay:       render_many(Enum.sort(resources.web_replay,       &(&1.sort_order < &2.sort_order)), __MODULE__, "resource.json"),
      terrain_building: render_many(Enum.sort(resources.terrain_building, &(&1.sort_order < &2.sort_order)), __MODULE__, "resource.json"),
      podcast:          render_many(Enum.sort(resources.podcast,          &(&1.sort_order < &2.sort_order)), __MODULE__, "resource.json")
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
