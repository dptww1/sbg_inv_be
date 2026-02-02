defmodule SbgInv.Web.FactionController do

  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.{ArmyList, Authentication, BookUtils, FactionFigure}

  action_fallback SbgInv.Web.FallbackController

  def create(conn, %{"army_list" => params}) do
    with_admin_user conn do
      _create_or_update(conn, %ArmyList{}, params)
    end
  end

  def index(conn, _params) do
    _index(conn, Map.get(conn.assigns, :current_user))
  end

  def show(conn, %{"id" => "-1"}), do: _show(conn, -1)
  def show(conn, %{"id" => id}) do
    army_list = ArmyList.query_by_id(id)
    |> ArmyList.with_sources()
    |> Repo.one

    _show(conn, army_list)
  end

  def update(conn, %{"id" => id, "army_list" => params}) do
    with_admin_user conn do
      army_list = load(id)
      _create_or_update(conn, army_list, params)
    end
  end

  defp _create_or_update(conn, army_list, params) do
    params = params
    |> Map.put("sources", BookUtils.add_book_refs(params["sources"]))

    changeset = ArmyList.changeset(army_list, params)

    with {:ok, army_list} <- Repo.insert_or_update(changeset) do
      render(conn, "show-army-list.json", army_list: load(army_list.id))
    end
  end

  defp _index(conn, nil) do
    render(conn, "bare_index.json", factions: ArmyList.query_all() |> Repo.all)
  end
  defp _index(conn, _user) do
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

  defp _show(conn, nil) do
    send_resp(conn, :not_found, "Bad faction ID!")
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

  defp load(id) do
    ArmyList.query_by_id(id)
    |> ArmyList.with_sources
    |> ArmyList.with_figures()
    |> Repo.one!
  end
end
