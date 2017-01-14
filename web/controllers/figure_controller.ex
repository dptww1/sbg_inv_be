defmodule SbgInv.FigureController do
  use SbgInv.Web, :controller

  import Ecto.Query

  alias SbgInv.{FactionFigure, Figure, Role}

  def show(conn, %{"id" => id}) do
    figure = Repo.get(Figure, id)
    _show(conn, figure)
  end

  defp _show(conn, nil) do
    put_status(conn, :not_found)
  end
  defp _show(conn, figure) do
    figure = figure
             |> Repo.preload(:faction_figure)
             |> Repo.preload([role: [scenario_faction: :scenario]])

    render(conn, "figure.json", %{figure: figure})
  end
end
