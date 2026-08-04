defmodule SbgInv.Web.UserHistoryController do

  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.{Authentication, UserFigure, UserFigureHistory, UserFigureHistoryView}

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

      user = conn.assigns.current_user

      if ((user.is_admin || user.id == hist.user_id)
         && is_most_recent(user.id, hist)) do

        undo_figure_history(user.id, hist.figure_id, hist.op, hist.amount)

        Repo.delete! hist

        send_resp conn, :no_content, ""

      else
        send_resp(conn, :unauthorized, "")
      end
    end
  end

  defp is_most_recent(user_id, hist) do
    check_hist =
      UserFigureHistory.query_latest_for_figure_id(user_id, hist.figure_id)
      |> Repo.one

    check_hist.id == hist.id
  end

  defp undo_figure_history(user_id, figure_id, op, amt) do
    user_figure = UserFigure.query_by_id_for_user(figure_id, user_id)
    |> Repo.one
    |> undo_op(op, amt)

    if user_figure do
      Repo.update(user_figure)
    end
  end

  # The nil case should only be relevant for the test cases, but let's handle Just In Case
  defp undo_op(nil, _, _), do: nil
  defp undo_op(user_figure, :buy_unpainted, amt) do
    UserFigure.changeset(user_figure, %{owned: Enum.max([0, user_figure.owned - amt])})
  end
  defp undo_op(user_figure, :sell_unpainted, amt) do
    UserFigure.changeset(user_figure, %{owned: user_figure.owned + amt})
  end
  defp undo_op(user_figure, :buy_painted, amt) do
    UserFigure.changeset(user_figure,
                         %{
                           owned: Enum.max([0, user_figure.owned - amt]),
                           painted: user_figure.painted - amt
                         })
  end
  defp undo_op(user_figure, :sell_painted, amt) do
    UserFigure.changeset(user_figure,
                         %{
                           owned: user_figure.owned + amt,
                           painted: user_figure.painted + amt
                         })
  end
  defp undo_op(user_figure, :paint, amt) do
    UserFigure.changeset(user_figure, %{painted: Enum.max([0, user_figure.painted - amt])})
  end
end
