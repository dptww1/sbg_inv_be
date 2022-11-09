defmodule SbgInv.Web.FigureController do

  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.{Authentication, Figure}

  def create(conn, %{"figure" => params}) do
    with_admin_user conn do
      update_or_create(conn, %Figure{}, params)
    end
  end

  def update(conn, %{"id" => id, "figure" => params}) do
    with_admin_user conn do
      figure = Figure.query_by_id(id)
               |> Figure.with_factions
               |> Repo.one!

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
    user_id = Authentication.user_id(conn)

    Figure.query_by_id(id)
    |> Figure.with_factions
    |> Figure.with_scenarios
    |> Figure.with_user(user_id)
    |> Figure.with_user_history(user_id)
    |> Figure.with_characters_and_resources
    |> Repo.one
  end
end
