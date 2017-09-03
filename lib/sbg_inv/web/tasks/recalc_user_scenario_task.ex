defmodule SbgInv.Web.RecalcUserScenarioTask do
  @moduledoc """
  Recalculates all the UserScenario "painted" and "owned" roll-up fields for a given user.
  """

  alias SbgInv.Repo
  alias SbgInv.Web.{Role, Scenario, UserFigure, UserScenario}

  import Ecto.Query

  require Logger

  #========================================================================
  def do_task(user_id) do
    Logger.info("#### START ####")

    # Get a map of all UserScenario records for the user, keyed by scenario_id
    existing_map = create_existing_map(user_id)

    # Get all Scenarios, their Factions, their Figures, and their UserFigures for the user
    scenarios = get_all_scenarios_with_user_figures(user_id)

    Enum.each(scenarios, fn(scenario) ->
      existing_user_scenario = Map.get(existing_map, scenario.id)

      do_scenario(user_id, existing_user_scenario, scenario)
    end)

    Logger.info("####  END  ####")
  end

  #========================================================================
  defp do_scenario(user_id, existing_user_scenario, scenario) do
    calculated_user_scenario = Enum.reduce(scenario.scenario_factions,
                                           default_user_scenario(user_id, scenario.id),
                                           fn(faction, user_scenario_acc) -> do_faction(faction, user_scenario_acc) end)

    save_scenario(existing_user_scenario, calculated_user_scenario)
  end

  #========================================================================
  defp save_scenario(nil, scenario) do
    changeset = UserScenario.changeset(%UserScenario{}, scenario)
    save_scenario(changeset)
  end

  #========================================================================
  defp save_scenario(existing_user_scenario, calculated_user_scenario) do
    if user_scenario_changed(existing_user_scenario, calculated_user_scenario) do
      changeset = UserScenario.changeset(existing_user_scenario, calculated_user_scenario)
      save_scenario(changeset)
    end
  end

  #========================================================================
  defp save_scenario(changeset) do
    case Repo.insert_or_update(changeset) do
      {:ok, _}            -> Logger.info "Saved scenario #{changeset.data.scenario_id} for user #{changeset.data.user_id}"
      {:error, changeset} -> Logger.error "!!! ERROR user #{changeset.data.user_id} scenario #{changeset.data.scenario_id} !!! #{Enum.join changeset.errors, "\n"}"
    end
  end

  #========================================================================
  defp do_faction(faction, user_scenario_acc) do
    Enum.reduce(faction.roles, user_scenario_acc, fn(role, user_scenario_acc) -> do_role(role, user_scenario_acc) end)
  end

  #========================================================================
  defp do_role(role, user_scenario_acc) do
    capped_user_figures = Role.role_user_figures(role)
    %{user_scenario_acc | owned:   user_scenario_acc.owned   + capped_user_figures.total_owned,
                          painted: user_scenario_acc.painted + capped_user_figures.total_painted}
  end

  #========================================================================
  defp default_user_scenario(user_id, scenario_id) do
    %{
      user_id: user_id,
      scenario_id: scenario_id,
      rating: 0,
      owned: 0,
      painted: 0
    }
  end

  #========================================================================
  defp user_scenario_changed(nil, _) do
    true
  end

  #========================================================================
  defp user_scenario_changed(existing, calculated) do
    existing.owned != calculated.owned || existing.painted != calculated.painted
  end

  #========================================================================
  defp get_all_scenarios_with_user_figures(user_id) do
    uf_query = from uf in UserFigure, where: uf.user_id == ^user_id

    query = Scenario |> preload([scenario_factions: [roles: [figures: [user_figure: ^uf_query]]]])

    Repo.all(query)
  end

  #========================================================================
  defp create_existing_map(user_id) do
    us_query = from us in UserScenario, where: us.user_id == ^user_id, order_by: :id
    Map.new(Repo.all(us_query), fn x -> { x.scenario_id, x } end)
  end
end
