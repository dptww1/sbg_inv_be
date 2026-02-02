defmodule SbgInv.Web.UserScenarioController do


  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.{Authentication, Scenario, UserScenario}

  def create(conn, %{"user_scenario" => params}) do
    with_auth_user conn do
      scenario_id = Map.get(params, "scenario_id")
      user_id = Authentication.user_id(conn)

      scenario =
        Scenario.query_by_id(scenario_id)
        |> Scenario.with_user(user_id)
        |> Repo.one

      if scenario == nil do
        send_resp(conn, :unprocessable_entity, "bad scenario ID!")

      else
        result =
          get_or_create_user_scenario(scenario, user_id)
          |> UserScenario.changeset(params)
          |> Repo.insert_or_update

        case result do
          {:ok, user_scenario} ->
            scenario = update_scenario_rating(conn, scenario)
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
  end

  defp get_or_create_user_scenario(nil, _), do: nil
  defp get_or_create_user_scenario(scenario, user_id) do
    if length(scenario.user_scenarios) > 0 do
      hd(scenario.user_scenarios)
    else
      %UserScenario{user_id: user_id, scenario_id: scenario.id}
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
