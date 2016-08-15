defmodule SbgInv.RecalcController do
  use SbgInv.Web, :controller

  require Logger

  def index(conn, _params) do
    Task.start_link(fn -> recalc_user_scenarios_task(1) end)   # TODO get user id from conn

    text conn, "Starting recalc task at " <>
      Calendar.NaiveDateTime.Format.asctime(Calendar.NaiveDateTime.from_erl!(:calendar.local_time()))
  end

  # TODO: Break the below out into separate module
  # TODO: sensitive to user id (and change to PUT or POST, not GET)
  # TODO: could optimize away UserScenario record when user gets rid of models (so owned: 0)
  # TODO: new data as Struct is goofy, because the logic wants it to be a Map anyway (see Map.from_struct)

  def recalc_user_scenarios_task(user_id) do
    IO.puts("#### START ####")

    us_query = from us in SbgInv.UserScenario, where: us.user_id == ^user_id, order_by: :id
    existing_map = Map.new(Repo.all(us_query), fn x -> { x.scenario_id, x } end)

    scenario_factions = Repo.all from sf in SbgInv.ScenarioFaction,
#           join: sff in assoc(sf, :scenario_faction_figures),
#           join: f in assoc(sff, :figure),
#           left_join: uf in assoc(f, :user_figure),
#           where: sf.scenario_id == 16,                                         # TODO: limit user id
           preload: [scenario_faction_figures: [figure: [:user_figure]]]

    new_map = Enum.reduce scenario_factions, %{}, fn(sf, stats) ->
      Map.put stats, sf.scenario_id, recalc_faction(
        Map.get(stats, sf.scenario_id) || default_user_scenario(user_id, sf.scenario_id), sf)
    end

    for new_user_scenario <- Map.values(new_map) do
      existing_user_scenario = Map.get existing_map, new_user_scenario.scenario_id
      new_is_non_empty = new_user_scenario.owned > 0 || new_user_scenario.painted > 0

      case {existing_user_scenario, new_is_non_empty} do
        {nil, true} ->
          IO.puts("#{new_user_scenario.scenario_id}: NEW")  # TODO die
          changeset = SbgInv.UserScenario.changeset(%SbgInv.UserScenario{}, Map.from_struct new_user_scenario)  # Map.from_struct is goofy
          IO.inspect changeset
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
#            IO.puts("#{new_user_scenario.scenario_id}: UPDATED")
#            IO.inspect new_user_scenario
#            IO.inspect existing_user_scenario
            changeset = SbgInv.UserScenario.changeset(existing_user_scenario,
                                                      %{owned: new_user_scenario.owned, painted: new_user_scenario.painted})
            case Repo.update changeset do
              {:ok, _}            -> Logger.info "Updated scenario #{existing_user_scenario.scenario_id} for user #{user_id}"
              {:error, changeset} -> Logger.error "!!! ERROR !!! #{Enum.join changeset.errors, "\n"}"
            end
          end
      end
    end


    IO.puts("####  END  ####")
  end

  def recalc_faction(user_scenario, scenario_faction) do
    user_scenario = Enum.reduce scenario_faction.scenario_faction_figures, user_scenario, fn(sff, stats) ->
      user_figure = if(length(sff.figure.user_figure) > 0, do: hd(sff.figure.user_figure), else: default_user_figure)
#      IO.puts " ??? scid: #{scenario_faction.scenario_id} stats/owned: #{stats.owned} uf/owned: #{user_figure.owned} lim: #{sff.amount}"
#      new_stats =
      Map.put(stats, :owned,   stats.owned   + min(user_figure.owned,   sff.amount))
          |> Map.put(:painted, stats.painted + min(user_figure.painted, sff.amount))
#      IO.puts " !!! ns/owned: #{new_stats.owned}"
#      new_stats
    end
    user_scenario
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

  defp default_user_figure() do
    %SbgInv.UserFigure{
      owned: 0,
      painted: 0
    }
  end
end
