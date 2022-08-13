defmodule SbgInv.Web.UserHistoryController do

  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.{Authentication, UserFigureHistory, UserFigureHistoryView}

  def index(conn, params) do
    with_auth_user conn do
      from = Map.get(params, "from", "2000-01-01")
      to   = Map.get(params, "to",   "3000-01-01")

      items = UserFigureHistory.query_by_date_range(from, to, Authentication.user_id(conn))
              |> Repo.all

      conn
      |> put_view(UserFigureHistoryView)
      |> render("history_list.json", history_items: items)
    end
  end

  def update(conn, params) do
    with_auth_user conn do
      hist =
        UserFigureHistory.query_by_id(params["id"])
        |> Repo.one

      if (conn.assigns.current_user.is_admin || conn.assigns.current_user.id == hist.user_id) do

        changeset = UserFigureHistory.changeset(hist, params["history"])
        case Repo.insert_or_update(changeset) do
          {:ok, _hist}         -> send_resp(conn, :no_content, "")
          {:error, _changeset} -> send_resp(conn, :unprocessable_entity, "")
        end

      else
        send_resp(conn, :unauthorized, "")
      end
    end
  end

  def delete(conn, params) do
    with_auth_user conn do
      hist =
        UserFigureHistory.query_by_id(params["id"])
        |> Repo.one

      if (conn.assigns.current_user.is_admin || conn.assigns.current_user.id == hist.user_id) do
        Repo.delete! hist
        send_resp conn, :no_content, ""

      else
        send_resp(conn, :unauthorized, "")
      end
    end
  end
end
