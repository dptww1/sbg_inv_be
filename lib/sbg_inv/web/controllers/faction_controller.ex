defmodule SbgInv.Web.FactionController do
  use SbgInv.Web, :controller

  import Ecto.Query

  alias SbgInv.Web.{FactionFigure}

  def show(conn, %{"id" => id}) do
    _show(conn, Enum.find(Faction.__valid_values__(), fn(x) -> x == String.to_integer(id) end))
  end

  defp _show(conn, nil) do
    put_status(conn, :not_found)
  end
  defp _show(conn, faction_id) do
    query = from ff in FactionFigure,
            where: ff.faction_id == ^faction_id,
            preload: [:figure]

    list = Repo.all(query)
    render(conn, "show.json", figures: list)
  end
end
