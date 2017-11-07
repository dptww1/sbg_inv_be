defmodule SbgInv.Web.FactionController do

  use SbgInv.Web, :controller

  import Ecto.Query

  alias SbgInv.Web.{Authentication,Figure}

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
    query = from f in Figure,
            left_join: role in assoc(f, :role),
            left_join: user_figure in assoc(f, :user_figure),
            group_by: [f.id, user_figure.owned, user_figure.painted, user_figure.figure_id, user_figure.user_id],
            where: fragment("f0.id not in (SELECT figure_id FROM faction_figures)"),
            where: user_figure.user_id == ^user_id(conn) or is_nil(user_figure.user_id),
            select: %{
              id: f.id,
              name: f.name,
              plural_name: f.plural_name,
              type: f.type,
              unique: f.unique,
              max_needed: max(role.amount),
              owned: user_figure.owned,
              painted: user_figure.painted,
              user_id: user_figure.user_id
            }

    list = Repo.all(query)

    render(conn, "show.json", figures: list)
  end
  defp _show(conn, faction_id) do
    conn = Authentication.optionally(conn)

    ff_query = from f in Figure,
               join: ff in assoc(f, :faction_figure),
               left_join: r in assoc(f, :role),
               left_join: uf in assoc(f, :user_figure),
               group_by: [f.id, uf.owned, uf.painted, uf.user_id],
               where: ff.faction_id == ^faction_id and (uf.user_id == ^user_id(conn) or is_nil(uf.user_id)),
               #preload: [user_figure: ^user_query],
               select: %{
                  id: f.id,
                  name: f.name,
                  plural_name: f.plural_name,
                  type: f.type,
                  unique: f.unique,
                  max_needed: max(r.amount),
                  owned: uf.owned,
                  painted: uf.painted,
                  user_id: uf.user_id
               }

    list = Repo.all(ff_query)

    render(conn, "show.json", figures: list)
  end

  defp user_id(conn) do
    if(Map.has_key?(conn.assigns, :current_user), do: conn.assigns.current_user.id, else: -1)
  end
end
