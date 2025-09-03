defmodule SbgInv.ScenarioControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{Book, Scenario, ScenarioResource, User, UserScenario}

  @valid_attrs %{blurb: "some content", date_age: 42, date_year: 42, date_month: 7, date_day: 15, name: "some name", size: 42,
                 map_width: 48, map_height: 48, location: :the_shire,
                 scenario_factions: [
                   %{faction: :shire, suggested_points: 100, actual_points: 0, sort_order: 1},
                   %{faction: :moria, suggested_points:  70, actual_points: 0, sort_order: 2}
                 ],
                 scenario_resources: %{
                   "source" => [ %{resource_type: 0, book: "harad", page: 17, sort_order: 1} ],
                   "web_replay" => [ %{resource_type: 2, url: "http://www.example.com", title: "Replay", sort_order: 2} ]
                 }}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index (no authorization)", %{conn: conn} do
    conn = get conn, Routes.scenario_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    scenario = Repo.insert! %Scenario{}
    conn = get conn, Routes.scenario_path(conn, :show, scenario.id)
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
        "podcast" => [],
        "cheatsheet" => []
       },
      "scenario_factions" => [],
      "user_scenario" => %{ "rating" => 0, "owned" => 0, "painted" => 0, "avg_rating" => 0, "num_votes" => 0 }
  }
  end

  test "does not show resource and instead errors when authorization token is invalid", %{conn: conn} do
    conn = put_req_header(conn, "authorization", "Token token=\"xyz\"")
    conn = get conn, Routes.scenario_path(conn, :show, -1)
    assert conn.status == 401
  end

  test "does not show resource and instead errors when id is nonexistent", %{conn: conn} do
    conn = get conn, Routes.scenario_path(conn, :show, -1)
    assert conn.status == 404
  end

  test "creates and renders resource when data is valid and user is admin", %{conn: conn} do
    user = Repo.insert! %User{name: "abc", email: "xyz@example.com", is_admin: true}
    conn = TestHelper.create_session(conn, user)
    conn = post conn, Routes.scenario_path(conn, :create), scenario: @valid_attrs

    check = Repo.one!(Scenario)
    |> Repo.preload(:scenario_factions)
    |> Repo.preload(:scenario_resources)

    now = NaiveDateTime.utc_now |> Calendar.strftime("%Y-%m-%d")

    assert json_response(conn, 200)["data"] == %{
      "id" => check.id,
      "blurb" => "some content",
      "date_age" => 42,
      "date_day" => 15,
      "date_month" => 7,
      "date_year" => 42,
      "location" => "the_shire",
      "map_height" => 48,
      "map_width" => 48,
      "name" => "some name",
      "num_votes" => 0,
      "rating" => 0,
      "rating_breakdown" => [],
      "scenario_factions" => [
        %{"sort_order" => 1, "suggested_points" => 100, "actual_points" => 0,
          "roles" => [], "id" => hd(check.scenario_factions).id},
        %{"sort_order" => 2, "suggested_points" => 70, "actual_points" => 0,
          "roles" => [], "id" => hd(tl(check.scenario_factions)).id}
      ],
      "scenario_resources" => %{
        "magazine_replay" => [],
        "podcast" => [],
        "source" => [
          %{"resource_type" => "source", "book" => "harad", "page" => 17, "issue" => nil, "sort_order" => 1, "date" => now,
            "id" => Enum.find(check.scenario_resources, fn elt -> elt.resource_type == :source end).id,
            "scenario_id" => check.id, "title" => nil, "url" => nil}
        ],
        "terrain_building" => [],
        "video_replay" => [],
        "web_replay" => [
          %{"resource_type" => "web_replay", "book" => nil, "page" => nil, "issue" => nil, "sort_order" => 2, "date" => now,
            "id" => Enum.find(check.scenario_resources, fn elt -> elt.resource_type == :web_replay end).id,
          "scenario_id" => check.id, "title" => "Replay", "url" => "http://www.example.com"},
        ],
        "cheatsheet" => []
      },
      "size" => 42,
      "user_scenario" => %{
        "avg_rating" => 0,
        "num_votes" => 0,
        "owned" => 0,
        "painted" => 0,
        "rating" => 0
      }
    }
  end

  test "does not create resource when data is valid if user is anonymous", %{conn: conn} do
    conn = post conn, Routes.scenario_path(conn, :create), scenario: @valid_attrs
    assert conn.status == 401
  end

  test "does not create resource when data is valid if user is not admin", %{conn: conn} do
    user = Repo.insert! %User{name: "abc", email: "xyz@example.com"}
    conn = TestHelper.create_session(conn, user)
    conn = post conn, Routes.scenario_path(conn, :create), scenario: @valid_attrs
    assert conn.status == 401
  end

  test "does not create resource when data is invalid even for admin", %{conn: conn} do
    user = Repo.insert! %User{name: "abc", email: "xyz@example.com", is_admin: true}
    conn = TestHelper.create_session(conn, user)
    conn = post conn, Routes.scenario_path(conn, :create), scenario: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid and user is admin", %{conn: conn} do
    %{conn: conn, user: user, const_data: const_data} = TestHelper.set_up_std_scenario(conn, :user2)

    TestHelper.promote_user_to_admin(user)

    # Create the source; it will be removed since it's not in the update data that we're about to send
    TestHelper.create_scenario_source(const_data["id"])

    conn = put conn,
               Routes.scenario_path(conn, :update, const_data["id"]),
               scenario: put_in(@valid_attrs, [ :scenario_factions ], [
                                  %{faction: :fangorn, suggested_points: 2, actual_points: 1, sort_order: 1, id: hd(const_data["scenario_factions"])["id"]}
                         ])
                         |> put_in([ :scenario_resources ], %{
                              web_replay: [ %{resource_type: :web_replay, url: "http://www.example.com", title: "FOO", sort_order: 2} ]
                         })

    check = Repo.one!(Scenario)
    |> Repo.preload(:scenario_factions)
    |> Repo.preload(:scenario_resources)

    now = NaiveDateTime.utc_now |> Calendar.strftime("%Y-%m-%d")

    assert json_response(conn, 200)["data"] == %{
      "id" => check.id,
      "blurb" => "some content",
      "date_age" => 42,
      "date_day" => 15,
      "date_month" => 7,
      "date_year" => 42,
      "location" => "the_shire",
      "map_height" => 48,
      "map_width" => 48,
      "name" => "some name",
      "num_votes" => 0,
      "rating" => 0,
      "rating_breakdown" => [],
      "scenario_factions" => [
        %{"sort_order" => 1, "suggested_points" => 2, "actual_points" => 1, "id" => hd(check.scenario_factions).id,
          "roles" => [
            %{"amount" => 9, "name" => "ABC", "num_owned" => 2, "num_painted" => 2, "sort_order" => 1, "id" => TestHelper.std_scenario_role_id(const_data, 0, 0),
            "figures" => [
                %{"name" => "ABCs", "owned" => 2, "painted" => 2, "figure_id" => TestHelper.std_scenario_figure_id(const_data, 0, 0)}
              ]},
            %{"amount" => 7, "name" => "DEF", "num_owned" => 1, "num_painted" => 0, "sort_order" => 2, "id" => TestHelper.std_scenario_role_id(const_data, 0, 1),
              "figures" => [
                %{"name" => "DEF", "owned" => 1, "painted" => 0, "figure_id" => TestHelper.std_scenario_figure_id(const_data, 1, 0)}
              ]},
          ]},
      ],
      "scenario_resources" => %{
        "magazine_replay" => [],
        "podcast" => [],
        "source" => [],
        "terrain_building" => [],
        "video_replay" => [],
        "web_replay" => [
          %{"resource_type" => "web_replay", "book" => nil, "issue" => nil, "page" => nil, "sort_order" => 2, "title" => "FOO", "url" => "http://www.example.com",
            "scenario_id" => check.id, "id" => hd(check.scenario_resources).id, "date" => now}
        ],
        "cheatsheet" => []
      },
      "size" => 42,
      "user_scenario" => %{
        "avg_rating" => 0,
        "num_votes" => 0,
        "owned" => 7,
        "painted" => 5,
        "rating" => 0
      }
    }
  end

  test "does not update chosen resource when user is anonymous", %{conn: conn} do
    scenario = Repo.insert! %Scenario{}
    conn = put conn, Routes.scenario_path(conn, :update, scenario), scenario: @valid_attrs
    assert conn.status == 401
  end

  test "does not update chosen resource when user is not admin", %{conn: conn} do
    user = Repo.insert! %User{name: "abc", email: "xyz@example.com"}
    conn = TestHelper.create_session(conn, user)
    scenario = Repo.insert! %Scenario{}
    conn = put conn, Routes.scenario_path(conn, :update, scenario), scenario: @valid_attrs
    assert conn.status == 401
  end

  test "does not update chosen resource when data is invalid even for admin", %{conn: conn} do
    user = Repo.insert! %User{name: "abc", email: "xyz@example.com", is_admin: true}
    conn = TestHelper.create_session(conn, user)
    scenario = Repo.insert! %Scenario{}
    conn = put conn, Routes.scenario_path(conn, :update, scenario), scenario: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource when user is admin", %{conn: conn} do
    scenario = Repo.insert! %Scenario{}
    user = Repo.insert! %User{name: "abc", email: "xyz@example.com", is_admin: true}
    conn = TestHelper.create_session(conn, user)
    conn = delete conn, Routes.scenario_path(conn, :delete, scenario)
    assert response(conn, 204)
    refute Repo.get(Scenario, scenario.id)
  end

  test "does not delete chosen resource when user is anonymous", %{conn: conn} do
    scenario = Repo.insert! %Scenario{}
    conn = delete conn, Routes.scenario_path(conn, :delete, scenario)
    assert conn.status == 401
  end

  test "does not delete chosen resource when user is not admin", %{conn: conn} do
    scenario = Repo.insert! %Scenario{}
    user = Repo.insert! %User{name: "abc", email: "xyz@example.com"}
    conn = TestHelper.create_session(conn, user)
    conn = delete conn, Routes.scenario_path(conn, :delete, scenario)
    assert conn.status == 401
  end

  test "scenario list query correctly limits itself to the current user's scenario data", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn, :user2)
    conn = get conn, Routes.scenario_path(conn, :index)

    required_values = %{ const_data | "scenario_factions" => [
                         Map.drop(hd(Map.get(const_data, "scenario_factions")), ["roles"])
                       ]}

    assert json_response(conn, 200)["data"] == [ Map.drop(required_values, ["rating_breakdown", "character_ids"]) ]
  end

  test "scenario detail query correctly limits itself to the current user's scenario data", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn, :user2)
    conn = get conn, Routes.scenario_path(conn, :show, Map.get(const_data, "id"))
    assert json_response(conn, 200)["data"] == Map.delete(const_data, "character_ids")
  end

  test "scenario detail includes figure possibilities", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn, :user2)

    second_figure = TestHelper.add_figure("new", "news")
    role_id = TestHelper.std_scenario_role_id(const_data, 0, 0)
    TestHelper.add_role_figure(second_figure.id, role_id)

    conn = get conn, Routes.scenario_path(conn, :show, Map.get(const_data, "id"))

    assert hd(hd(json_response(conn, 200)["data"]["scenario_factions"])["roles"]) == %{
      "id" => role_id,
      "amount" => 9,
      "name" => "ABC",
      "num_owned" => 2,
      "num_painted" => 2,
      "sort_order" => 1,
      "figures" => [
        %{"figure_id" => TestHelper.std_scenario_figure_id(const_data), "name" => "ABCs", "owned" => 2, "painted" => 2},
        %{"figure_id" => second_figure.id, "name" => "new", "owned" => 0, "painted" => 0}
      ]
    }
  end

  test "index with bad cookie fails", %{conn: conn} do
    conn = conn
           |> put_req_header("authorization", "Token token=\"123bcd\"")
           |> get(Routes.scenario_path(conn, :index))
    assert conn.status == 401
  end

  test "show with bad cookie fails", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn, :user2)
    conn = conn
           |> put_req_header("authorization", "Token token=\"123bcd\"")
           |> get(Routes.scenario_path(conn, :show, const_data["id"]))
    assert conn.status == 401
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

    conn = get conn, Routes.scenario_path(conn, :show, const_data["id"])
    assert json_response(conn, 200)["data"]["rating_breakdown"] == [1, 1, 1, 1, 1]
  end

  test "scenario source with no issue number is returned correctly", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn)

    fp = Repo.get_by!(Book, key: "fp")
    Repo.insert! %ScenarioResource{scenario_id: const_data["id"], resource_type: :source, book: fp, title: "Free Peoples", sort_order: 1}

    conn = get conn, Routes.scenario_path(conn, :show, const_data["id"])

    assert hd(json_response(conn, 200)["data"]["scenario_resources"]["source"])["issue"] == nil
  end

  test "scenario source with issue number is returned correctly", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn)

    fp = Repo.get_by!(Book, key: "fp")
    Repo.insert! %ScenarioResource{scenario_id: const_data["id"], resource_type: :source, book: fp, issue: "321", title: "Free Peoples", sort_order: 1}

    conn = get conn, Routes.scenario_path(conn, :show, const_data["id"])

    assert hd(json_response(conn, 200)["data"]["scenario_resources"]["source"])["issue"] == "321"
  end
end
