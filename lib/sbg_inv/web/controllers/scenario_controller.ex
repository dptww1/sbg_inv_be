defmodule SbgInv.Web.ScenarioController do

  use SbgInv.Web, :controller

  import Ecto.Query

  alias SbgInv.Web.{Authentication, Scenario, UserFigure, UserScenario}

  plug :scrub_params, "scenario" when action in [:create, :update]

  def index(conn, _params) do
    conn = Authentication.optionally(conn)
    _index(conn, conn.status)  # TODO: simplify
  end

  defp _index(conn, 401) do
    render(conn, "error.json", %{})
  end
  defp _index(conn, _) do
    user_id = if(Map.has_key?(conn.assigns, :current_user), do: conn.assigns.current_user.id, else: -1)

    user_query = from us in UserScenario, where: us.user_id == ^user_id

    query = Scenario
            |> preload(:scenario_resources)
            |> preload(:scenario_factions)
            |> preload([user_scenarios: ^user_query])
            |> order_by([asc: :date_age, asc: :date_year, asc: :date_month, asc: :date_day])

    scenarios = Repo.all(query)

    render(conn, "index.json", scenarios: scenarios)
  end


  def create(conn, %{"scenario" => scenario_params}) do
    conn = Authentication.admin_required(conn)

    if (conn.halted) do
      send_resp(conn, :unauthorized, "")

    else
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
    conn = Authentication.optionally(conn)
    _show(conn, id, conn.status)
  end

  defp _show(conn, _id, 401) do
    render(conn, "error.json", %{})
  end
  defp _show(conn, id, _) do
    scenario = load_scenario(conn, id)

    rating_breakdown_query = from us in UserScenario,
                                  group_by: us.rating,
                                  where: us.scenario_id == ^id,
                                  having: us.rating != 0,
                                  select: [us.rating, count(us.rating)]

    rating_breakdown = Repo.all(rating_breakdown_query)
                       |> Enum.filter(fn(x) -> hd(x) != nil end)
                       |> Enum.reduce([0, 0, 0, 0, 0], fn(x, acc) -> List.replace_at(acc, hd(x) - 1, hd(tl(x))) end)

    _show_render(conn, scenario, rating_breakdown)
  end

  defp _show_render(conn, nil, _) do
    put_status(conn, :not_found)
  end
  defp _show_render(conn, scenario, rating_breakdown) do
    render(conn, "show.json", %{scenario: scenario, rating_breakdown: rating_breakdown})
  end

  def update(conn, %{"id" => id, "scenario" => scenario_params}) do
    conn = Authentication.admin_required(conn)

    if (conn.halted) do
      send_resp(conn, :unauthorized, "")

    else
      scenario = Repo.get!(Scenario, id)
                 |> Repo.preload([:scenario_resources, :scenario_factions, :user_scenarios])
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
    conn = Authentication.admin_required(conn)

    if (conn.halted) do
      send_resp(conn, :unauthorized, "")
    else
      scenario = Repo.get!(Scenario, id)

      # Here we use delete! (with a bang) because we expect
      # it to always work (and if it does not, it will raise).
      Repo.delete!(scenario)

      send_resp(conn, :no_content, "")
    end
  end

  defp load_scenario(conn, id) do
    user_id = if(Map.has_key?(conn.assigns, :current_user), do: conn.assigns.current_user.id, else: -1)

    user_scenario_query = from us in UserScenario, where: us.user_id == ^user_id
    user_figure_query = from uf in UserFigure, where: uf.user_id == ^user_id

    query = Scenario
            |> preload(:scenario_resources)
            |> preload([user_scenarios: ^user_scenario_query])
            |> preload(scenario_factions: [roles: [figures: [user_figure: ^user_figure_query]]])

    Repo.get(query, id)
  end
end
