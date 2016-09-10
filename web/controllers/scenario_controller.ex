defmodule SbgInv.ScenarioController do
  use SbgInv.Web, :controller

  alias SbgInv.Scenario

  plug :scrub_params, "scenario" when action in [:create, :update]

  def index(conn, _params) do
    import Ecto.Query

    query = from s in Scenario,
            order_by: [asc: :date_year, asc: :date_month, asc: :date_day],
            select: s

    scenarios = Repo.all(query)
                |> Repo.preload([:scenario_resources, :scenario_factions, :user_scenarios])

    render(conn, "index.json", scenarios: scenarios)
  end

  def create(conn, %{"scenario" => scenario_params}) do
    changeset = Scenario.changeset(%Scenario{}, scenario_params)

    case Repo.insert(changeset) do
      {:ok, scenario} ->
        scenario = Repo.preload(scenario, [:scenario_resources, :scenario_factions, :user_scenarios])
        conn
        |> put_status(:created)
        |> put_resp_header("location", scenario_path(conn, :show, scenario))
        |> render("show.json", scenario: scenario, user_id: 1)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SbgInv.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    scenario = Repo.get!(Scenario, id)
               |> Repo.preload([:scenario_resources, :user_scenarios])
               |> Repo.preload(scenario_factions: [roles: [figures: :user_figure]])
    render(conn, "show.json", %{scenario: scenario, user_id: 1})
  end

  def update(conn, %{"id" => id, "scenario" => scenario_params}) do
    scenario = Repo.get!(Scenario, id)
               |> Repo.preload([:scenario_resources, :scenario_factions, :user_scenarios])
    changeset = Scenario.changeset(scenario, scenario_params)

    case Repo.update(changeset) do
      {:ok, scenario} ->
        render(conn, "show.json", scenario: scenario, user_id: 1)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SbgInv.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    scenario = Repo.get!(Scenario, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(scenario)

    send_resp(conn, :no_content, "")
  end
end
