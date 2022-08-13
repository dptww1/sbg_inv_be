defmodule SbgInv.Web.ScenarioFactionController do

  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.{Scenario, ScenarioFaction}

  def update(conn, %{"id" => id, "scenario_faction" => params}) do
    with_admin_user conn do
      changeset =
        ScenarioFaction.query_by_id(id)
        |> ScenarioFaction.with_figures
        |> Repo.one
        |> ScenarioFaction.changeset(params)

      case Repo.update(changeset) do
        {:ok, _} ->
          scenario_faction =
            ScenarioFaction.query_by_id(id)
            |> ScenarioFaction.with_figures
            |> Repo.one

          update_scenario_size(scenario_faction.scenario_id)
          render(conn, "faction_detail.json", %{scenario_faction: scenario_faction})

        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> put_view(SbgInv.Web.ChangesetView)
          |> render("error.json", changeset: changeset)
      end
    end
  end

  defp update_scenario_size(scenario_id) do
    scenario =
      Scenario.query_by_id(scenario_id)
      |> Scenario.with_roles
      |> Repo.one

    new_size =
      scenario.scenario_factions
      |> Enum.flat_map(&(&1.roles))
      |> Enum.reduce(0, &(&1.amount + &2))

    Repo.update(Scenario.changeset(scenario, %{size: new_size}))
  end
end
