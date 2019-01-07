defmodule SbgInv.ScenarioResourceControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{ScenarioResource, User}

  @valid_attrs %{url: "http://nowhere", title: "ABC", resource_type: 2}  # sort_order is auto-supplied by back end
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "can't create scenario resource anonymously", %{conn: conn} do
    conn = post conn, Routes.scenario_scenario_resource_path(conn, :create, 1), resource: @valid_attrs
    assert conn.status == 401
  end

  test "can't create scenario resource if non-admin", %{conn: conn} do
    conn = TestHelper.create_logged_in_user(conn)
    conn = post conn, Routes.scenario_scenario_resource_path(conn, :create, 1), resource: @valid_attrs
    assert conn.status == 401
  end

  test "can create scenario resource if admin and valid data", %{conn: conn} do
    scenario = TestHelper.create_scenario()
    user = Repo.insert! %User{name: "abc", email: "def@example.com", is_admin: true}
    conn = TestHelper.create_session(conn, user)
    conn = post conn, Routes.scenario_scenario_resource_path(conn, :create, scenario.id), resource: @valid_attrs
    assert conn.status == 204
  end

  test "can't create scenario resource if admin and invalid data", %{conn: conn} do
    user = Repo.insert! %User{name: "abc", email: "def@example.com", is_admin: true}
    conn = TestHelper.create_session(conn, user)
    conn = post conn, Routes.scenario_scenario_resource_path(conn, :create, 1), resource: @invalid_attrs
    assert conn.status == 422
  end

  test "can't update scenario resource anonymously", %{conn: conn} do
    conn = put conn, Routes.scenario_scenario_resource_path(conn, :update, 1, 3), resource: @valid_attrs
    assert conn.status == 401
  end

  test "can't update scenario resource if non-admin", %{conn: conn} do
    conn = TestHelper.create_logged_in_user(conn)
    conn = put conn, Routes.scenario_scenario_resource_path(conn, :update, 1, 3), resource: @valid_attrs
    assert conn.status == 401
  end

  test "can update scenario resource if admin and valid data", %{conn: conn} do
    user = Repo.insert! %User{name: "abc", email: "def@example.com", is_admin: true}
    scenario = TestHelper.create_scenario()
    resource = Repo.insert! %ScenarioResource{scenario_id: scenario.id, sort_order: 1, resource_type: 1}
    conn = TestHelper.create_session(conn, user)
    conn = put conn, Routes.scenario_scenario_resource_path(conn, :update, scenario.id, resource.id),
               resource: %{scenario_id: scenario.id, id: resource.id, resource_type: 2, url: "http://www.foo.com"}
    assert conn.status == 204
    updated_resource = Repo.get! ScenarioResource, resource.id
    assert updated_resource.resource_type == :web_replay
    assert updated_resource.url == "http://www.foo.com"
  end

  test "can't update scenario resource if admin and invalid data", %{conn: conn} do
    user = Repo.insert! %User{name: "abc", email: "def@example.com", is_admin: true}
    scenario = TestHelper.create_scenario()
    resource = Repo.insert! %ScenarioResource{scenario_id: scenario.id, sort_order: 1, resource_type: 1}
    conn = TestHelper.create_session(conn, user)
    conn = put conn, Routes.scenario_scenario_resource_path(conn, :update, scenario.id, resource.id),
               resource: %{scenario_id: scenario.id, id: resource.id, resource_type: nil}
    assert conn.status == 422
  end
end
