defmodule SbgInv.Web.UserFigureController do
  use SbgInv.Web, :controller

  alias SbgInv.Web.{Authentication, UserFigure}

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

      changeset = UserFigure.changeset(user_figure_rec, user_figure_params)

      case Repo.insert_or_update(changeset) do
        {:ok, _} ->
          send_resp(conn, :no_content, "")

        {:error, _} ->
          send_resp(conn, :unprocessable_entity, "")
      end
    end
  end
end
