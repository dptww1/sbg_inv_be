defmodule SbgInv.Web.StatsController do

  use SbgInv.Web, :controller

  alias SbgInv.Web.{Stats, User, UserFigure}

  def index(conn, _params) do
    render(conn, "index.json", stats: %{
      users: %{
        total: Repo.aggregate(User, :count)
      },
      models: %{
        totalOwned: Repo.aggregate(UserFigure, :sum, :owned),
        totalPainted: Repo.aggregate(UserFigure, :sum, :painted),
        mostCollected: %{
          character: Repo.all(Stats.query_most_collected_character),
          hero: Repo.all(Stats.query_most_collected_hero),
          warrior: Repo.all(Stats.query_most_collected_warrior),
          monster: Repo.all(Stats.query_most_collected_monster)
        },
        mostPainted: %{
          character: Repo.all(Stats.query_most_painted_character),
          hero: Repo.all(Stats.query_most_painted_hero),
          warrior: Repo.all(Stats.query_most_painted_warrior),
          monster: Repo.all(Stats.query_most_painted_monster)
        },
        recentlyPainted: Repo.all(Stats.query_recently_painted_figures)
      }
    })
  end
end
