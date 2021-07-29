defmodule SbgInv.Web.StatsController do

  use SbgInv.Web, :controller

  import Ecto.Query

  alias SbgInv.Web.{Figure, User, UserFigure}

  def index(conn, _params) do
    most_collected_character =
      from(q in most_collected_query(),
        or_having: q.type == :hero and q.unique == true)

    most_collected_hero =
      from(q in most_collected_query(),
        or_having: q.type == :hero and not q.unique)

    most_collected_warrior =
      from(q in most_collected_query(),
        or_having: q.type == :warrior)

    most_collected_monster =
      from(q in most_collected_query(),
        or_having: q.type == :monster)

    most_painted_character =
      from(q in most_painted_query(),
        or_having: q.type == :hero and q.unique == true)

    most_painted_hero =
      from(q in most_painted_query(),
        or_having: q.type == :hero and not q.unique)

    most_painted_warrior =
      from(q in most_painted_query(),
        or_having: q.type == :warrior)

    most_painted_monster =
      from(q in most_painted_query(),
        or_having: q.type == :monster)

    render(conn, "index.json", stats: %{
      users: %{
        total: Repo.aggregate(User, :count)
      },
      models: %{
        totalOwned: Repo.aggregate(UserFigure, :sum, :owned),
        totalPainted: Repo.aggregate(UserFigure, :sum, :painted),
        mostCollected: %{
          character: Repo.all(most_collected_character),
          hero: Repo.all(most_collected_hero),
          warrior: Repo.all(most_collected_warrior),
          monster: Repo.all(most_collected_monster)
        },
        mostPainted: %{
          character: Repo.all(most_painted_character),
          hero: Repo.all(most_painted_hero),
          warrior: Repo.all(most_painted_warrior),
          monster: Repo.all(most_painted_monster)
        }
      }
    })
  end

  defp most_painted_query do
    from(f in Figure,
      join: uf in assoc(f, :user_figure),
      select: %{
        id: uf.figure_id,
        name: f.name,
        slug: f.slug,
        total: sum(uf.painted)
      },
      group_by: [uf.figure_id, f.name, f.slug, f.type, f.unique],
      order_by: [desc: sum(uf.painted)],
      limit: 5)
  end

  defp most_collected_query do
    from(f in Figure,
      join: uf in assoc(f, :user_figure),
      select: %{
        id: uf.figure_id,
        name: f.name,
        slug: f.slug,
        total: sum(uf.owned)
      },
      group_by: [uf.figure_id, f.name, f.slug, f.type, f.unique],
      order_by: [desc: sum(uf.owned)],
      limit: 5)
  end
end
