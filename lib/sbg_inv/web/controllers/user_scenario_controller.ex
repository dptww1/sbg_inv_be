defmodule SbgInv.Web.UserScenarioController do

  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.{Authentication, Scenario, UserScenario}

  def create(conn, %{"user_scenario" => user_scenario_params}) do
    with_auth_user conn do
      result =
        case Repo.get_by(UserScenario, user_id: Authentication.user_id(conn), scenario_id: Map.get(user_scenario_params, "scenario_id")) do
          nil -> %UserScenario{user_id: Authentication.user_id(conn), scenario_id: Map.get(user_scenario_params, "scenario_id")}
          user_scenario -> user_scenario
        end
      |> UserScenario.changeset(user_scenario_params)
      |> Repo.insert_or_update

      case result do
        {:ok, user_scenario} ->
          user_scenario = Repo.preload(user_scenario, [:scenario])
          scenario = update_scenario_rating(conn, user_scenario.scenario)
          conn
          |> render("user_scenario.json", user_scenario: %{user_scenario | scenario: scenario})

        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> put_view(SbgInv.Web.ChangesetView)
          |> render("error.json", changeset: changeset)
      end
    end
  end

  defp update_scenario_rating(_conn, scenario) do
    [num_votes, rating] = Repo.one(
      from p in UserScenario,
      where: p.scenario_id == ^scenario.id,
      where: p.rating > 0,
      select: [count("*"), fragment("?::float", avg(p.rating))])
    changeset = Scenario.base_changeset(scenario, %{rating: rating, num_votes: num_votes})
    case Repo.update(changeset) do
      {:ok, scenario} ->
        scenario
      {:error, _changeset} ->
        %Scenario{}
    end
  end
end
