defmodule SbgInv.UserScenarioController do
  use SbgInv.Web, :controller

  alias SbgInv.{Authentication, Scenario, UserScenario}

  def create(conn, %{"user_scenario" => user_scenario_params}) do
    conn = Authentication.required(conn)

    if conn.halted do
      conn

    else
      changeset = UserScenario.changeset(%UserScenario{user_id: conn.assigns.current_user.id}, user_scenario_params)

      case Repo.insert(changeset) do
        {:ok, user_scenario} ->
          user_scenario = Repo.preload(user_scenario, [:scenario])
          scenario = update_scenario_rating(conn, user_scenario.scenario)
          conn
          |> put_status(:created)
          |> render("user_scenario.json", user_scenario: %{user_scenario | scenario: scenario})
        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(SbgInv.ChangesetView, "error.json", changeset: changeset)
      end
    end
  end

  def update(conn, %{"id" => id, "user_scenario" => user_scenario_params}) do
    conn = Authentication.required(conn)

    if conn.halted do
      conn

    else
      user_scenario = Repo.get!(UserScenario, id) |> Repo.preload(:scenario)
      changeset = UserScenario.changeset(user_scenario, user_scenario_params)
      case Repo.update(changeset) do
        {:ok, user_scenario} ->
          scenario = update_scenario_rating(conn, user_scenario.scenario)
          render(conn, "user_scenario.json", user_scenario: %{user_scenario | scenario: scenario})
        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(SbgInv.ChangesetView, "error.json", changeset: changeset)
      end
    end
  end

  defp update_scenario_rating(conn, scenario) do
    [num_votes, rating] = Repo.one(from p in UserScenario, select: [count("*"), fragment("?::float", avg(p.rating))])
    changeset = Scenario.base_changeset(%Scenario{}, Map.merge(Map.delete(scenario, :__struct__), %{rating: rating, num_votes: num_votes}))
    case Repo.insert(changeset) do
      {:ok, scenario} ->
        scenario
      {:error, changeset} ->
        %Scenario{}
    end
  end
end
