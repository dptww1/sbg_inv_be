defmodule SbgInv.Web.FactionController do
  use SbgInv.Web, :controller

  import Ecto.Query

  alias SbgInv.Web.{Figure, FactionFigure}

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
            group_by: f.id,
            where: fragment("f0.id not in (SELECT figure_id FROM faction_figures)"),
            select: %{
              id: f.id,
              name: f.name,
              plural_name: f.plural_name,
              type: f.type,
              unique: f.unique,
              max_needed: max(role.amount)
            }

    list = Repo.all(query)

    render(conn, "show.json", figures: list)
  end
  defp _show(conn, faction_id) do
    query = from ff in FactionFigure,
            join: figure in assoc(ff, :figure),
            left_join: role in assoc(figure, :role),
            group_by: [ff.figure_id, figure.name, figure.plural_name, figure.type, figure.unique],
            where: ff.faction_id == ^faction_id,
            select: %{
              id: ff.figure_id,
              name: figure.name,
              plural_name: figure.plural_name,
              type: figure.type,
              unique: figure.unique,
              max_needed: max(role.amount)
            }

    list = Repo.all(query)

    render(conn, "show.json", figures: list)
  end
end
