defmodule SbgInv.ScenarioControllerTest do
  use SbgInv.ConnCase

  alias SbgInv.{Scenario, TestHelper}

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
      "scenario_resources" => %{
        "source" => [],
        "web_replay" => [],
        "video_replay" => [],
        "terrain_building" => [],
        "podcast" => []
       },
      "scenario_factions" => [],
      "user_scenario" => %{ "rating" => 0, "owned" => 0, "painted" => 0, "rating" => 0, "avg_rating" => 0, "num_votes" => 0 }
  }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, scenario_path(conn, :show, -1)
    end
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

    assert json_response(conn, 200)["data"] == [ required_values ]
  end

  test "scenario detail query correctly limits itself to the current user's scenario data", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn, :user2)
    conn = get conn, scenario_path(conn, :show, Map.get(const_data, "id"))
    assert json_response(conn, 200)["data"] == const_data
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
end
