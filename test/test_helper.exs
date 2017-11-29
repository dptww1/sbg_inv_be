ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(SbgInv.Repo, :manual)

defmodule SbgInv.TestHelper do

  use SbgInv.Web.ConnCase

  alias SbgInv.Web.{Figure, Role, RoleFigure, Scenario, ScenarioFaction, Session, User, UserScenario, UserFigure}

  def pinspect(conn, obj) do
    IO.puts "---"
    IO.inspect obj
    IO.puts "---"
    conn
  end

  def faction_as_int(faction) do
    case Faction.dump(faction) do
      {:ok, int} -> int
      {:error, _} -> raise "No such faction #{faction}"
    end
  end

  def clear_sessions(conn) do
    Repo.delete_all(Session)
    conn |> delete_req_header("authorization")
  end

  def create_user(name \\ "anonymous", email \\ "anonymous@example.com") do
    Repo.insert! %User{name: name, email: email}
  end

  def create_logged_in_user(conn, name \\ "anonymous", email \\ "anonymous@example.com") do
    create_session(conn, create_user(name, email))
  end

  def create_session(conn, user) do
    session = Repo.insert! %Session{token: "123", user_id: user.id}
    put_req_header conn, "authorization", "Token token=\"#{session.token}\""
  end

  # const_data: from set_up_std_scenario()'s return value
  # faction_idx: 0,1
  # role_idx: 0..n
  def std_scenario_role_id(const_data, faction_idx, role_idx) do
    const_data["scenario_factions"]
    |> Enum.fetch!(faction_idx)
    |> Map.get("roles")
    |> Enum.fetch!(role_idx)
    |> Map.get("id")
  end

  # const_data: from set_up_std_scenario()'s return value
  # idx: 0,1
  def std_scenario_figure_id(const_data, idx \\ 0) do
    const_data["scenario_factions"]
    |> Enum.fetch!(0)
    |> Map.get("roles")
    |> Enum.fetch!(0)
    |> Map.get("figures")
    |> Enum.fetch!(idx)
    |> Map.get("figure_id")
  end

  def add_figure(name, plural_name, type \\ :warrior, unique \\ false) do
    Repo.insert! %Figure{name: name, plural_name: plural_name, type: type, unique: unique}
  end

  def add_role_figure(figure_id, role_id) do
    Repo.insert! %RoleFigure{figure_id: figure_id, role_id: role_id}
  end

  def create_scenario() do
    Repo.insert! %Scenario{name: "A", blurb: "B", date_age: 3, date_year: 1, date_month: 1, date_day: 1, size: 0,
      map_width: 7, map_height: 15, location: :the_shire}
  end

  # user: :user1 or :user2
  def set_up_std_scenario(conn, user \\ :user1) do
    user1 = create_user("no one", "abc@def.com")
    user2 = create_user("nobody", "def@ghi.com")
    conn = create_session(conn, if(user == :user1, do: user1, else: user2))

    scenario = create_scenario()
    Repo.insert!(%UserScenario{user_id: user1.id, scenario_id: scenario.id, painted: 6, owned: 8})
    Repo.insert!(%UserScenario{user_id: user2.id, scenario_id: scenario.id, painted: 5, owned: 7})

    faction = Repo.insert! %ScenarioFaction{faction: :rohan, scenario_id: scenario.id, suggested_points: 0, actual_points: 0, sort_order: 1}

    role1 = Repo.insert! %Role{scenario_faction_id: faction.id, amount: 9, sort_order: 1, name: "ABC"}
    role2 = Repo.insert! %Role{scenario_faction_id: faction.id, amount: 7, sort_order: 2, name: "DEF"}

    figure1 = Repo.insert! %Figure{name: "ABC", plural_name: "ABCs", type: :hero, unique: true}
    figure2 = Repo.insert! %Figure{name: "DEF", plural_name: "DEFs", type: :warrior, unique: false}

    Repo.insert! %RoleFigure{role_id: role1.id, figure_id: figure1.id}
    Repo.insert! %RoleFigure{role_id: role2.id, figure_id: figure2.id}

    Repo.insert! %UserFigure{user_id: user1.id, figure_id: figure1.id, owned: 4, painted: 2}
    Repo.insert! %UserFigure{user_id: user1.id, figure_id: figure2.id, owned: 3, painted: 1}
    Repo.insert! %UserFigure{user_id: user2.id, figure_id: figure1.id, owned: 2, painted: 2}
    Repo.insert! %UserFigure{user_id: user2.id, figure_id: figure2.id, owned: 1, painted: 0}

    %{
      conn: conn,
      user: if(user == :user1, do: user1, else: user2),
      const_data: %{
        "id" => scenario.id,
        "name" => "A",
        "blurb" => "B",
        "date_age" => 3,
        "date_year" => 1,
        "date_month" => 1,
        "date_day" => 1,
        "size" => 0,
        "map_width" => 7,
        "map_height" => 15,
        "location" => "the_shire",
        "rating" => 0,
        "num_votes" => 0,
        "rating_breakdown" => [0, 0, 0, 0, 0],
        "scenario_factions" => [
          %{
            "actual_points" => 0,
            "suggested_points" => 0,
            "faction" => "rohan",
            "sort_order" => 1,
            "roles" => [
              %{"id" => role1.id, "name" => "ABC", "amount" => 9, "num_owned" => 2, "num_painted" => 2, "figures" => [
               if user == :user1 do
                 %{"figure_id" => figure1.id, "name" => "ABCs", "owned" => 4, "painted" => 2}
               else
                 %{"figure_id" => figure1.id, "name" => "ABCs", "owned" => 2, "painted" => 2}
               end
               ]},
              %{"id" => role2.id, "name" => "DEF", "amount" => 7, "num_owned" => 1, "num_painted" => 0, "figures" => [
               if user == :user1 do
                 %{"figure_id" => figure2.id, "name" => "DEF", "owned" => 3, "painted" => 1}
               else
                 %{"figure_id" => figure2.id, "name" => "DEF", "owned" => 1, "painted" => 0}
               end
               ]},
            ]
          }
        ],
        "scenario_resources" => %{
          "magazine_replay" => [],
          "podcast" => [],
          "source" => [],
          "terrain_building" => [],
          "video_replay" => [],
          "web_replay" => []
        },
        "user_scenario" =>
          if user == :user1 do
            %{"owned" => 8, "painted" => 6, "rating" => 0, "avg_rating" => 0, "num_votes" => 0}
          else
            %{"owned" => 7, "painted" => 5, "rating" => 0, "avg_rating" => 0, "num_votes" => 0}
          end
      }
    }
  end
end
