defmodule SbgInv.Web.ScenarioController do

  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.{Authentication, BookUtils, Scenario}

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
      _create_or_update(conn, %Scenario{}, scenario_params)
    end
  end

  def show(conn, %{"id" => id}) do
    if conn.halted do
      conn

    else
      scenario = _load_scenario(conn, id)

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

      _create_or_update(conn, scenario, scenario_params)
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

  defp _create_or_update(conn, scenario, params) do
    params = Map.put(params, "scenario_resources", _normalize_resources(Map.get(params, "scenario_resources")))

    changeset = Scenario.changeset(scenario, params)

    case Repo.insert_or_update(changeset) do
      {:ok, scenario} ->
        scenario = _load_scenario(conn, scenario.id)
        render(conn, "show.json", scenario: scenario, rating_breakdown: [])

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(SbgInv.Web.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end

  defp _load_scenario(conn, id) do
    user_id = Authentication.user_id(conn)

    Scenario.query_by_id(id)
    |> Scenario.with_resources
    |> Scenario.with_user(user_id)
    |> Scenario.with_figures(user_id)
    |> Repo.one
  end

  # scenario_view.ex converts the simple list of resources into a map of typed lists.
  # In retrospect, this should have been done in the front end.  But we make things
  # easier here for front end editing by accepting the view's organization of the
  # resources within the "scenario_resources" parameter.
  defp _normalize_resources(map) when is_map(map) do
    Enum.reduce(["magazine_replay", "podcast", "source", "terrain_building", "video_replay", "web_replay", "cheatsheet"],
                [],
                fn x, acc -> acc ++ BookUtils.add_book_refs(Map.get(map, x)) end)
  end
  defp _normalize_resources(_), do: []
end
