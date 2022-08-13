defmodule SbgInv.Web.ScenarioController do

  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.{Authentication, Scenario}

  plug :scrub_params, "scenario" when action in [:create, :update]

  def index(conn, _params) do
    user_id = Authentication.user_id(conn)

    scenarios =
      Scenario.query_all
      |> Scenario.with_resources
      |> Scenario.with_factions
      |> Scenario.with_user(user_id)
      |> Repo.all

    render(conn, "index.json", scenarios: scenarios)
  end


  def create(conn, %{"scenario" => scenario_params}) do
    with_admin_user conn do
      changeset = Scenario.changeset(%Scenario{}, scenario_params)

      case Repo.insert(changeset) do
        {:ok, scenario} ->
          scenario = load_scenario(conn, scenario.id)
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.scenario_path(conn, :show, scenario))
          |> render("show.json", scenario: scenario, user_id: 1, rating_breakdown: [])

        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> put_view(SbgInv.Web.ChangesetView)
          |> render("error.json", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    if conn.halted do
      conn

    else
      scenario = load_scenario(conn, id)

      rating_breakdown =
        Repo.all(Scenario.ratings_breakdown_query(id))
        |> Enum.reduce([0, 0, 0, 0, 0], fn(x, acc) ->
             List.replace_at(acc, hd(x) - 1, Enum.at(x, 1))
           end)

      _show_render(conn, scenario, rating_breakdown)
    end
  end

  defp _show_render(conn, nil, _) do
    put_status(conn, :not_found)
  end
  defp _show_render(conn, scenario, rating_breakdown) do
    render(conn, "show.json", %{scenario: scenario, rating_breakdown: rating_breakdown})
  end

  def update(conn, %{"id" => id, "scenario" => scenario_params}) do
    with_admin_user conn do
      scenario =
        Scenario.query_by_id(id)
        |> Scenario.with_resources
        |> Scenario.with_user(Authentication.user_id(conn))
        |> Scenario.with_figures(Authentication.user_id(conn))
        |> Repo.one

      changeset = Scenario.changeset(scenario, scenario_params)

      case Repo.update(changeset) do
        {:ok, scenario} ->
          scenario = load_scenario(conn, scenario.id)
          render(conn, "show.json", scenario: scenario, rating_breakdown: [])

        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> put_view(SbgInv.Web.ChangesetView)
          |> render("error.json", changeset: changeset)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    with_admin_user conn do
      # Here we use delete! (with a bang) because we expect
      # it to always work (and if it does not, it will raise).
      Scenario.query_by_id(id)
      |> Repo.one
      |> Repo.delete!

      send_resp(conn, :no_content, "")
    end
  end

  defp load_scenario(conn, id) do
    user_id = Authentication.user_id(conn)

    Scenario.query_by_id(id)
    |> Scenario.with_resources
    |> Scenario.with_user(user_id)
    |> Scenario.with_figures(user_id)
    |> Repo.one
  end
end
