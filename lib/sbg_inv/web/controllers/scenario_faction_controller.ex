defmodule SbgInv.Web.ScenarioFactionController do

  use SbgInv.Web, :controller

  import Ecto.Query

  alias SbgInv.Web.{Authentication, Role, Scenario, ScenarioFaction}

  def update(conn, %{"id" => id, "scenario_faction" => params}) do
    conn = Authentication.admin_required(conn)

    if (conn.halted) do
      send_resp(conn, :unauthorized, "")

    else
      scenario_faction = Repo.get!(ScenarioFaction, id)
                         |> Repo.preload([roles: :figures])
      changeset = ScenarioFaction.changeset(scenario_faction, params)

      case Repo.update(changeset) do
        {:ok, role} ->
          scenario_faction = Repo.get(ScenarioFaction, id)
                             |> Repo.preload([roles: :figures])
          render(conn, "faction_detail.json", %{scenario_faction: scenario_faction})

        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> put_view(SbgInv.Web.ChangesetView)
          |> render("error.json", changeset: changeset)
      end
    end
  end
end
