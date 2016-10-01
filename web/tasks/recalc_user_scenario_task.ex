defmodule SbgInv.RecalcUserScenarioTask do

  alias SbgInv.{Repo, ScenarioFaction, UserFigure, UserScenario}

  import Ecto.Query

  require Logger

  def do_task(user_id) do
    Logger.info("#### START ####")

    user_scenario_query = from us in UserScenario, where: us.user_id == ^user_id, order_by: :id
    user_figure_query = from uf in UserFigure, where: uf.user_id == ^user_id

    existing_map = Map.new(Repo.all(user_scenario_query), fn x -> { x.scenario_id, x } end)

    query = ScenarioFaction
            |> preload([roles: [figures: [user_figure: ^user_figure_query]]])

    factions = Repo.all(query)

    new_map = Enum.reduce factions, %{}, fn(sf, stats) ->
      Map.put stats, sf.scenario_id, recalc_faction(
        Map.get(stats, sf.scenario_id) || default_user_scenario(user_id, sf.scenario_id), sf
      )
    end

    for new_user_scenario <- Map.values(new_map) do
      existing_user_scenario = Map.get existing_map, new_user_scenario.scenario_id
      new_is_non_empty = new_user_scenario.owned > 0 || new_user_scenario.painted > 0

      case {existing_user_scenario, new_is_non_empty} do
        {nil, true} ->
          Logger.info("#{new_user_scenario.scenario_id}: NEW")  # TODO die
          changeset = SbgInv.UserScenario.changeset(%SbgInv.UserScenario{}, Map.from_struct new_user_scenario)  # TODO Map.from_struct is goofy
          #IO.inspect changeset
          case Repo.insert changeset do
            {:ok, _}            -> Logger.info "Added scenario #{new_user_scenario.scenario_id} for user #{user_id}"
            {:error, changeset} -> Logger.error "Couldn't add scenario #{new_user_scenario.scenario_id} for user #{user_id}: #{Enum.join changeset.errors, "\n"}"
          end
#          Repo.insert(new_user_scenario)

        {nil, false} ->
          true   # nothing to do here

        _ ->
          if existing_user_scenario.owned == new_user_scenario.owned && existing_user_scenario.painted == new_user_scenario.painted do
            true  # nothing to do here  # IO.puts("#{new_user_scenario.scenario_id}: IGNORABLE (no change)")
          else
            changeset = SbgInv.UserScenario.changeset(existing_user_scenario,
                                                      %{owned: new_user_scenario.owned, painted: new_user_scenario.painted})
            case Repo.update changeset do
              {:ok, _}            -> Logger.info "Updated scenario #{existing_user_scenario.scenario_id} for user #{user_id}"
              {:error, changeset} -> Logger.error "!!! ERROR !!! #{Enum.join changeset.errors, "\n"}"
            end
          end
      end
    end

    Logger.info("####  END  ####")
  end

  defp recalc_faction(user_scenario, scenario_faction) do
    Enum.reduce scenario_faction.roles, user_scenario, fn(role, stats) ->
      ruf = SbgInv.Role.role_user_figures(role)
      %{stats | owned:   stats.owned   + ruf.total_owned,
                painted: stats.painted + ruf.total_painted}
    end
  end

  defp default_user_scenario(user_id, scenario_id) do
    %SbgInv.UserScenario{
      user_id: user_id,
      scenario_id: scenario_id,
      rating: 0,
      owned: 0,
      painted: 0
    }
  end
end