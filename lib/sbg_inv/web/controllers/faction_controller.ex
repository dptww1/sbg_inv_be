defmodule SbgInv.Web.FactionController do
  use SbgInv.Web, :controller

  import Ecto.Query

  alias SbgInv.Web.{Figure, FactionFigure, RoleFigure}

  def show(conn, %{"id" => id}) do
    if id === "-1" do
      _show(conn, -1)
    else
      _show(conn, Enum.find(Faction.__valid_values__(), fn(x) -> x == String.to_integer(id) end))
    end
  end

  defp _show(conn, nil) do
    put_status(conn, :not_found)
  end
  defp _show(conn, -1) do
    query = from f in Figure, where: fragment("f0.id not in (SELECT figure_id FROM faction_figures)"), select: f
    list = Enum.map(Repo.all(query), fn(f) -> %FactionFigure{ figure: f } end)
    render(conn, "show.json", figures: list)
  end
  defp _show(conn, faction_id) do
    query = from ff in FactionFigure,
            where: ff.faction_id == ^faction_id,
            preload: [:figure]

    list = Repo.all(query)

    render(conn, "show.json", figures: list)
  end
end
