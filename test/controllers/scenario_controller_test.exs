defmodule SbgInv.ScenarioControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{Scenario, ScenarioResource, UserScenario}

  @valid_attrs %{blurb: "some content", date_age: 42, date_year: 42, date_month: 7, date_day: 15, name: "some content", size: 42,
                 map_width: 48, map_height: 48, location: :the_shire}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index (no authorization)", %{conn: conn} do
    conn = get conn, scenario_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    scenario = Repo.insert! %Scenario{}
    conn = get conn, scenario_path(conn, :show, scenario)
    assert json_response(conn, 200)["data"] == %{
      "id" => scenario.id,
      "name" => scenario.name,
      "blurb" => scenario.blurb,
      "date_age" => scenario.date_age,
      "date_day" => scenario.date_age,
      "date_month" => scenario.date_month,
      "date_year" => scenario.date_year,
      "size" => scenario.size,
      "map_width" => scenario.map_width,
      "map_height" => scenario.map_height,
      "location" => scenario.location,
      "rating" => 0,
      "num_votes" => 0,
      "rating_breakdown" => [0, 0, 0, 0, 0],
      "scenario_resources" => %{
        "magazine_replay" => [],
        "source" => [],
        "web_replay" => [],
        "video_replay" => [],
        "terrain_building" => [],
        "podcast" => []
       },
      "scenario_factions" => [],
      "user_scenario" => %{ "rating" => 0, "owned" => 0, "painted" => 0, "avg_rating" => 0, "num_votes" => 0 }
  }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    conn = get conn, scenario_path(conn, :show, -1)
    assert conn.status == 404
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, scenario_path(conn, :create), scenario: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Scenario, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, scenario_path(conn, :create), scenario: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    scenario = Repo.insert! %Scenario{}
    conn = put conn, scenario_path(conn, :update, scenario), scenario: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Scenario, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    scenario = Repo.insert! %Scenario{}
    conn = put conn, scenario_path(conn, :update, scenario), scenario: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    scenario = Repo.insert! %Scenario{}
    conn = delete conn, scenario_path(conn, :delete, scenario)
    assert response(conn, 204)
    refute Repo.get(Scenario, scenario.id)
  end

  test "scenario list query correctly limits itself to the current user's scenario data", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn, :user2)
    conn = get conn, scenario_path(conn, :index)

    required_values = %{ const_data | "scenario_factions" => [
                         Map.take(hd(Map.get(const_data, "scenario_factions")),
                                  ~w[sort_order actual_points suggested_points faction])
                       ]}

    assert json_response(conn, 200)["data"] == [ Map.drop(required_values, ["rating_breakdown"]) ]
  end

  test "scenario detail query correctly limits itself to the current user's scenario data", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn, :user2)
    conn = get conn, scenario_path(conn, :show, Map.get(const_data, "id"))
    assert json_response(conn, 200)["data"] == const_data
  end

  test "scenario detail includes figure possibilities", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn, :user2)

    second_figure = TestHelper.add_figure("new", "news")
    role_id = TestHelper.std_scenario_role_id(const_data, 0, 0)
    TestHelper.add_role_figure(second_figure.id, role_id)

    conn = get conn, scenario_path(conn, :show, Map.get(const_data, "id"))

    assert hd(hd(json_response(conn, 200)["data"]["scenario_factions"])["roles"]) == %{
      "id" => role_id,
      "amount" => 9,
      "name" => "ABC",
      "num_owned" => 2,
      "num_painted" => 2,
      "figures" => [
        %{"figure_id" => TestHelper.std_scenario_figure_id(const_data), "name" => "ABCs", "owned" => 2, "painted" => 2},
        %{"figure_id" => second_figure.id, "name" => "new", "owned" => 0, "painted" => 0}
      ]
    }
  end

  test "index with bad cookie fails", %{conn: conn} do
    conn = conn
           |> put_req_header("authorization", "Token token=\"123bcd\"")
           |> get(scenario_path(conn, :index))
    assert json_response(conn, 401)["errors"] != %{}
  end

  test "show with bad cookie fails", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn, :user2)
    resp = conn
           |> put_req_header("authorization", "Token token=\"123bcd\"")
           |> get(scenario_path(conn, :show, Map.get(const_data, "id")))
    assert json_response(resp, 401)["errors"] != %{}
  end

  test "rating breakdowns are correctly returned", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn, :user2)
    user1 = TestHelper.create_user("user1", "user1@example.com")
    user2 = TestHelper.create_user("user2", "user2@example.com")
    user3 = TestHelper.create_user("user3", "user3@example.com")
    user4 = TestHelper.create_user("user4", "user4@example.com")
    user5 = TestHelper.create_user("user5", "user5@example.com")
    Repo.insert! %UserScenario{user_id: user1.id, scenario_id: const_data["id"], rating: 5}
    Repo.insert! %UserScenario{user_id: user2.id, scenario_id: const_data["id"], rating: 4}
    Repo.insert! %UserScenario{user_id: user3.id, scenario_id: const_data["id"], rating: 3}
    Repo.insert! %UserScenario{user_id: user4.id, scenario_id: const_data["id"], rating: 2}
    Repo.insert! %UserScenario{user_id: user5.id, scenario_id: const_data["id"], rating: 1}

    conn = get conn, scenario_path(conn, :show, const_data["id"])
    assert json_response(conn, 200)["data"]["rating_breakdown"] == [1, 1, 1, 1, 1]
  end

  test "scenario source with no issue number is returned correctly", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn)
    Repo.insert! %ScenarioResource{scenario_id: const_data["id"], resource_type: :source, book: :fp, title: "Free Peoples", sort_order: 1}

    conn = get conn, scenario_path(conn, :show, const_data["id"])

    assert hd(json_response(conn, 200)["data"]["scenario_resources"]["source"])["issue"] == nil
  end

  test "scenario source with issue number is returned correctly", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn)
    Repo.insert! %ScenarioResource{scenario_id: const_data["id"], resource_type: :source, book: :fp, issue: 321, title: "Free Peoples", sort_order: 1}

    conn = get conn, scenario_path(conn, :show, const_data["id"])

    assert hd(json_response(conn, 200)["data"]["scenario_resources"]["source"])["issue"] == 321
  end
end
