defmodule SbgInv.ScenarioFactionFigureView do
  use SbgInv.Web, :view

  def render("scenario_faction_figure.json", %{scenario_faction_figure: figure}) do
    %{
      id: figure.id,
      amount: figure.amount,
      name: if(figure.amount > 1, do: figure.figure.plural_name, else: figure.figure.name)
    }
  end
end
