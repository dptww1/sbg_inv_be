defmodule SbgInv.ScenarioResourceControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{Scenario, User}

  @valid_attrs %{url: "http://nowhere", title: "ABC", resource_type: 2}  # sort_order is auto-supplied by back end
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "can't create scenario resource anonymously", %{conn: conn} do
    conn = post conn, scenario_scenario_resource_path(conn, :create, 1), resource: @valid_attrs
    assert conn.status == 401
  end

  test "can't create scenario resource if non-admin", %{conn: conn} do
    conn = TestHelper.create_logged_in_user(conn)
    conn = post conn, scenario_scenario_resource_path(conn, :create, 1), resource: @valid_attrs
    assert conn.status == 401
  end

  test "can create scenario resource if admin and valid data", %{conn: conn} do
    scenario = Repo.insert! %Scenario{
      name: "a", blurb: "b", date_age: 3, date_year: 1, date_month: 2, date_day: 3,
      size: 1, map_width: 24, map_height: 24, location: :mirkwood}
    user = Repo.insert! %User{name: "abc", email: "def@example.com", is_admin: true}
    conn = TestHelper.create_session(conn, user)
    conn = post conn, scenario_scenario_resource_path(conn, :create, scenario.id), resource: @valid_attrs
    assert conn.status == 204
  end

  test "can't create scenario resource if admin and invalid data", %{conn: conn} do
    user = Repo.insert! %User{name: "abc", email: "def@example.com", is_admin: true}
    conn = TestHelper.create_session(conn, user)
    conn = post conn, scenario_scenario_resource_path(conn, :create, 1), resource: @invalid_attrs
    assert conn.status == 422
  end
end
