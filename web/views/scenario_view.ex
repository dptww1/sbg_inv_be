defmodule SbgInv.ScenarioView do
  use SbgInv.Web, :view

  def render("index.json", %{scenarios: scenarios}) do
    %{data: render_many(scenarios, SbgInv.ScenarioView, "scenario.json")}
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
      size: scenario.size}
  end
end
