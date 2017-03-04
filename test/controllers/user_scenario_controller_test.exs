# test/controllers/user_scenario_controller_test.exs
defmodule SbgInv.Web.UserScenarioControllerTest do
  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{Scenario, UserScenario}

  @valid_attrs %{rating: 3, owned: 2, painted: 1}
  @valid_scenario_attrs %{blurb: "A", date_age: 1, date_year: 2, date_month: 3, date_day: 4, name: "B", size: 2,
                          map_width: 7, map_height: 8, location: :the_shire}

  test "creates and renders resource when data is valid", %{conn: conn} do
    scenario = Repo.insert! struct(Scenario, @valid_scenario_attrs)
    user = TestHelper.create_user
    conn = TestHelper.create_session(conn, user)
    conn = post conn, user_scenario_path(conn, :create), user_scenario: Map.merge(@valid_attrs, %{scenario_id: scenario.id, user_id: user.id})
    assert !conn.halted  # halt would indicate authorization failure
    resp = json_response(conn, 200)
    assert resp == %{"rating" => 3, "owned" => 2, "painted" => 1, "avg_rating" => 3.0, "num_votes" => 1}
    assert Repo.get_by(UserScenario, %{scenario_id: scenario.id, user_id: conn.assigns.current_user.id})
  end

  test "posting a rating updates the scenario vote count and average rating", %{conn: conn} do
    user1 = TestHelper.create_user
    user2 = TestHelper.create_user "guy2", "guy2@example.com"
    user3 = TestHelper.create_user "guy3", "guy3@example.com"
    scenario = Repo.insert! %Scenario{rating: 1.0, num_votes: 2, name: "a", blurb: "a", date_age: 1, date_year: 0, date_month: 0, date_day: 0, size: 0,
                                      map_width: 7, map_height: 12, location: :the_shire}
    Repo.insert! %UserScenario{user_id: user1.id, scenario_id: scenario.id, rating: 1}
    Repo.insert! %UserScenario{user_id: user2.id, scenario_id: scenario.id, rating: 1}
    conn = TestHelper.create_session(conn, user3)
    conn = post conn, user_scenario_path(conn, :create), user_scenario: %{scenario_id: scenario.id, user_id: user3.id, rating: 4}
    assert json_response(conn, 200) == %{"rating" => 4, "avg_rating" => 2.0, "num_votes" => 3, "owned" => 0, "painted" => 0}
  end
end
