defmodule SbgInv.Web.UserHistoryController do

  use SbgInv.Web, :controller

  import Ecto.Query

  alias SbgInv.Web.{Authentication, FigureView, UserFigureHistory, UserFigureHistoryView}

  def index(conn, params) do
    conn = Authentication.required(conn)

    if (conn.halted) do
      send_resp(conn, :unauthorized, "")

    else
      from = Map.get(params, "from", "2000-01-01")
      to   = Map.get(params, "to",   "3000-01-01")

      query = UserFigureHistory
              |> preload([:figure])
              |> where([n], n.op_date >= ^from)
              |> where([n], n.op_date <= ^to)
              |> where([n], n.user_id == ^conn.assigns.current_user.id)
              |> order_by([asc: :op_date])

      conn
      |> put_view(UserFigureHistoryView)
      |> render("history_list.json", history_items: Repo.all(query))
    end
  end

  def update(conn, params) do
    conn = Authentication.required(conn)

    if (conn.halted) do
      send_resp(conn, :unauthorized, "")

    else
      hist = Repo.get! UserFigureHistory, params["id"]

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
    conn = Authentication.required(conn)

    if (conn.halted) do
      send_resp(conn, :unauthorized, "")

    else
      hist = Repo.get! UserFigureHistory, params["id"]

      if (conn.assigns.current_user.is_admin || conn.assigns.current_user.id == hist.user_id) do
        Repo.delete! hist
        send_resp conn, :no_content, ""

      else
        send_resp(conn, :unauthorized, "")
      end
    end
  end
end
