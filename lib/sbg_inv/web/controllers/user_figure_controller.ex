defmodule SbgInv.Web.UserFigureController do
  use SbgInv.Web, :controller

  alias SbgInv.Web.{Authentication, RecalcUserScenarioTask, UserFigure, UserFigureHistory}

  def create(conn, %{"user_figure" => user_figure_params}) do
    conn = Authentication.required(conn)

    if conn.halted do
      send_resp(conn, :unauthorized, "")

    else
      user_id = conn.assigns.current_user.id
      figure_id = Map.get(user_figure_params, "id")

      user_figure_rec =
        case Repo.get_by(UserFigure, user_id: user_id, figure_id: figure_id) do
          nil -> %UserFigure{user_id: user_id, figure_id: figure_id}
          user_figure -> user_figure
        end

      changeset = UserFigure.changeset(user_figure_rec, %{
                                        "owned" => Map.get(user_figure_params, "new_owned"),
                                        "painted" => Map.get(user_figure_params, "new_painted")
                                       })

      case Repo.insert_or_update(changeset) do
        {:ok, _} ->
          add_history(user_id, figure_id, user_figure_rec, user_figure_params)
          RecalcUserScenarioTask.do_task(user_id)
          send_resp(conn, :no_content, "")

        {:error, _} ->
          send_resp(conn, :unprocessable_entity, "")
      end
    end
  end

  defp add_history(user_id, figure_id, user_figure_rec, user_figure_params) do
    %{owned: old_owned, painted: old_painted} = user_figure_rec
    %{"new_owned" => new_owned, "new_painted" => new_painted} = user_figure_params
    op = calc_history_op(new_owned - (old_owned || 0), new_painted - (old_painted || 0))

    changeset = UserFigureHistory.changeset(%UserFigureHistory{user_id: user_id, figure_id: figure_id, op: op}, user_figure_params)

    Repo.insert!(changeset)
  end

  defp calc_history_op(owned_diff, painted_diff) when owned_diff > 0 and painted_diff === 0, do: :buy_unpainted
  defp calc_history_op(owned_diff, painted_diff) when owned_diff < 0 and painted_diff === 0, do: :sell_unpainted
  defp calc_history_op(owned_diff, painted_diff) when owned_diff > 0 and painted_diff > 0,   do: :buy_painted
  defp calc_history_op(owned_diff, painted_diff) when owned_diff < 0 and painted_diff < 0,   do: :sell_painted
  defp calc_history_op(owned_diff, _)            when owned_diff == 0,                       do: :paint
end
