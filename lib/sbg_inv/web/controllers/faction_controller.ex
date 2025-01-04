defmodule SbgInv.Web.FactionController do

  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.{ArmyList, Authentication, FactionFigure}

  def index(conn, _params) do
    # Ordinarily `index` operations wouldn't require an authenticated user.
    # But without a user, the only thing that can be shown is the list of
    # faction names, so the FE saves a network call and uses its own
    # data structures to show that.  # TODO: make the network call to remove hardwiring in FE
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

  def show(conn, %{"id" => "-1"}), do: _show(conn, -1)
  def show(conn, %{"id" => id}) do
    army_list = ArmyList.query_by_id(id)
    |> ArmyList.with_sources()
    |> Repo.one

    _show(conn, army_list)
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
  defp _show(conn, army_list) do
    list =
      Authentication.user_id(conn)
      |> FactionFigure.query_figures_by_faction_id(army_list.id)
      |> Repo.all

    render(conn, "show.json", figures: list, army_list: army_list)
  end
end
