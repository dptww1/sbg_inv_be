defmodule SbgInv.Web.FactionController do

  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.{Authentication, FactionFigure}

  def index(conn, _params) do
    # Ordinarily `index` operations wouldn't require an authenticated user.
    # But without a user, the only thing that can be shown is the list of
    # faction names, so the FE saves a network call and uses its own
    # data structures to show that.
    with_auth_user conn do
      totals =
        Authentication.user_id(conn)
        |> FactionFigure.query_user_figure_totals
        |> Repo.one

      list =
        (Authentication.user_id(conn)
         |> FactionFigure.query_collection_figures_by_faction
         |> Repo.all)
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
    list =
      Authentication.user_id(conn)
      |> FactionFigure.query_figures_with_no_faction
      |> Repo.all

    render(conn, "show.json", figures: list)
  end
  defp _show(conn, faction_id) do
    list =
      Authentication.user_id(conn)
      |> FactionFigure.query_figures_by_faction_id(faction_id)
      |> Repo.all

    render(conn, "show.json", figures: list)
  end
end
