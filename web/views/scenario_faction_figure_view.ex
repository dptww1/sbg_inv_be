defmodule SbgInv.ScenarioFactionFigureView do
  use SbgInv.Web, :view

  def render("scenario_faction_figure.json", %{scenario_faction_figure: figure}) do
    IO.inspect "#####"
    IO.inspect figure
    IO.inspect "#####"

    user_figure = if(((length figure.figure.user_figure) > 0), do: hd(figure.figure.user_figure), else: %SbgInv.UserFigure{ owned: 0, painted: 0})

    %{
      id: figure.id,
      amount: figure.amount,
      name: if(figure.amount > 1, do: figure.figure.plural_name, else: figure.figure.name),
      num_painted: user_figure.painted,
      num_owned: user_figure.owned
    }
  end
end
