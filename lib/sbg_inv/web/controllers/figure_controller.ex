defmodule SbgInv.Web.FigureController do

  use SbgInv.Web, :controller

  import Ecto.Query

  alias SbgInv.Web.{Authentication, Figure, UserFigure, UserFigureHistory}

  def show(conn, %{"id" => id}) do
    conn = Authentication.optionally(conn)
    figure = Repo.get(Figure, id)
    _show(conn, figure)
  end

  defp _show(conn, nil) do
    put_status(conn, :not_found)
  end
  defp _show(conn, figure) do
    user_id = if(Map.has_key?(conn.assigns, :current_user), do: conn.assigns.current_user.id, else: -1)

    user_figure_query = from uf in UserFigure,
                        where: uf.user_id == ^user_id
                        # and uf.figure_id == ^figure.id # TODO NEEDED?

    user_figure_history_query = from ufh in UserFigureHistory,
                                where: ufh.user_id == ^user_id and ufh.figure_id == ^figure.id,
                                order_by: [asc: ufh.op_date, desc: ufh.updated_at]

    figure = figure
             |> Repo.preload(:faction_figure)
             |> Repo.preload([role: [scenario_faction: :scenario]])
             |> Repo.preload([user_figure: user_figure_query])
             |> Repo.preload([user_figure_history: user_figure_history_query])

    render(conn, "figure.json", %{figure: figure})
  end
end
