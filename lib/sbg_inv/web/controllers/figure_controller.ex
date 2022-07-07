defmodule SbgInv.Web.FigureController do

  use SbgInv.Web, :controller

  import Ecto.Query

  alias SbgInv.Web.{Authentication, Figure, UserFigure, UserFigureHistory}

  def create(conn, %{"figure" => params}) do
    conn = Authentication.admin_required(conn)

    if (conn.halted) do
      send_resp(conn, :unauthorized, "")

    else
      update_or_create(conn, Repo.preload(%Figure{}, :faction_figure), params)
    end
  end

  def update(conn, %{"id" => id, "figure" => params}) do
    conn = Authentication.admin_required(conn)

    if (conn.halted) do
      send_resp(conn, :unauthorized, "")

    else
      figure = Repo.get!(Figure, id)
               |> Repo.preload([:faction_figure])

      update_or_create(conn, figure, params)
    end
  end

  defp update_or_create(conn, figure, params) do
    ffs = Enum.map(Map.get(params, "factions", []), fn f -> %{:faction_id => f} end)
    changeset = Figure.changeset(figure, Map.put(params, "faction_figure", ffs))

    case Repo.insert_or_update(changeset) do
      {:ok, figure} ->
        figure = load_figure(conn, figure.id)
        render(conn, "figure.json", figure: figure)

      {:error, _changeset} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end

  def show(conn, %{"id" => id}) do
    conn = Authentication.optionally(conn)
    figure = load_figure(conn, id)
    _show(conn, figure)
  end

  defp _show(conn, nil) do
    put_status(conn, :not_found)
  end
  defp _show(conn, figure) do
    render(conn, "figure.json", %{figure: figure})
  end

  defp load_figure(conn, id) do
    user_id = if(Map.has_key?(conn.assigns, :current_user), do: conn.assigns.current_user.id, else: -1)

    user_figure_query = from uf in UserFigure,
                        where: uf.user_id == ^user_id
                        # and uf.figure_id == ^id # TODO NEEDED?

    user_figure_history_query = from ufh in UserFigureHistory,
                                where: ufh.user_id == ^user_id and ufh.figure_id == ^id,
                                order_by: [asc: ufh.op_date, desc: ufh.updated_at]

    Repo.get(Figure, id)
    |> Repo.preload(:faction_figure)
    |> Repo.preload([role: [scenario_faction: [scenario: :scenario_resources]]])
    |> Repo.preload([user_figure: user_figure_query])
    |> Repo.preload([user_figure_history: user_figure_history_query])
    |> Repo.preload(:characters)
  end
end
