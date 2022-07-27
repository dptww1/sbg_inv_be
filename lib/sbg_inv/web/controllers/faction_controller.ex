defmodule SbgInv.Web.FactionController do

  use SbgInv.Web, :controller

  import Ecto.Query

  alias SbgInv.Web.{Authentication, FactionFigure, Figure, UserFigure}

  def index(conn, _params) do
    conn = Authentication.required(conn)
    if (conn.halted) do
      conn

    else
      query = from ff in FactionFigure,
              left_join: uf in UserFigure, on: uf.figure_id == ff.figure_id,
              group_by: [ff.faction_id, uf.user_id],
              having: uf.user_id == ^conn.assigns.current_user.id,
              order_by: ff.faction_id,
              select: %{
                id: ff.faction_id,
                owned: sum(uf.owned),
                painted: sum(uf.painted)
              }

      totals_query = from uf in UserFigure,
               group_by: uf.user_id,
               having: uf.user_id == ^conn.assigns.current_user.id,
               select: %{
                 owned: sum(uf.owned),
                 painted: sum(uf.painted)
               }

      totals = Repo.one(totals_query)

      list = Repo.all(query)
             ++ [%{
                    id: -1,
                    name: "Totals",
                    plural_name: "Totals",
                    type: 0,
                    unique: true,
                    needed: 0,
                    owned: totals.owned,
                    painted: totals.painted
                  }]

      render(conn, "index.json", factions: list)
    end
  end

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
    list = Repo.all(from figure in faction_query(Authentication.user_id(conn)),
                    where: fragment("f0.id not in (SELECT figure_id FROM faction_figures)"))

    render(conn, "show.json", figures: list)
  end
  defp _show(conn, faction_id) do
    list = Repo.all(from figure in faction_query(Authentication.user_id(conn)),
                    join: ff in assoc(figure, :faction_figure), on: (ff.faction_id == ^faction_id))

    render(conn, "show.json", figures: list)
  end

  defp faction_query(user_id) do
    from f in Figure,
    left_join: role in assoc(f, :role),
    left_join: uf in assoc(f, :user_figure), on: (uf.user_id == ^user_id),
    group_by: [f.id, uf.owned, uf.painted, uf.user_id],
    select: %{
      id: f.id,
      name: f.name,
      plural_name: f.plural_name,
      slug: f.slug,
      type: f.type,
      unique: f.unique,
      max_needed: max(role.amount),
      owned: uf.owned,
      painted: uf.painted,
      user_id: uf.user_id
    }
  end
end
