defmodule SbgInv.ScenarioResourceControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{Scenario, ScenarioResource, User}

  @valid_attrs %{url: "http://nowhere", title: "ABC", resource_type: 2}  # sort_order is auto-supplied by back end
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  defp create_test_resources do
    s1 = Repo.insert!(%Scenario{name: "P"})
    s2 = Repo.insert!(%Scenario{name: "Q"})
    Repo.insert(%ScenarioResource{scenario_id: s1.id, resource_type: 1, title: "STU", url: "example7.com", updated_at: ~N[2019-10-26 00:00:00]})
    Repo.insert(%ScenarioResource{scenario_id: s2.id, resource_type: 4, title: "PQR", url: "example6.com", updated_at: ~N[2019-10-25 00:00:00]})
    Repo.insert(%ScenarioResource{scenario_id: s1.id, resource_type: 1, title: "MNO", url: "example5.com", updated_at: ~N[2019-10-24 00:00:00]})
    Repo.insert(%ScenarioResource{scenario_id: s1.id, resource_type: 2, title: "JKL", url: "example4.com", updated_at: ~N[2019-10-23 00:00:00]})
    Repo.insert(%ScenarioResource{scenario_id: s2.id, resource_type: 0, title: "GHI", url: "example3.com", updated_at: ~N[2019-10-22 00:00:00]})
    Repo.insert(%ScenarioResource{scenario_id: s1.id, resource_type: 1, title: "DEF", url: "example2.com", updated_at: ~N[2019-10-21 00:00:00]})
    Repo.insert(%ScenarioResource{scenario_id: s1.id, resource_type: 0, title: "ABC", url: "example1.com", updated_at: ~N[2019-10-20 00:00:00]})
    %{s1: s1.id, s2: s2.id}
  end

  test "can get default list of recent non-source resources", %{conn: conn} do
    %{s1: s1_id, s2: s2_id} = create_test_resources()
    conn = get conn, Routes.scenario_scenario_resource_path(conn, :index, -1) # scenario_id required by path but is unused
    assert json_response(conn, 200)["data"]
           |> Enum.map(fn x -> Map.drop(x, ["id", "book", "issue", "notes", "page", "sort_order"]) end)
           == [
             %{"url" => "example7.com", "title" => "STU", "resource_type" => "video_replay", "date" => "2019-10-26", "scenario_id" => s1_id, "scenario_name" => "P"},
             %{"url" => "example6.com", "title" => "PQR", "resource_type" => "podcast",      "date" => "2019-10-25", "scenario_id" => s2_id, "scenario_name" => "Q"},
             %{"url" => "example5.com", "title" => "MNO", "resource_type" => "video_replay", "date" => "2019-10-24", "scenario_id" => s1_id, "scenario_name" => "P"},
             %{"url" => "example4.com", "title" => "JKL", "resource_type" => "web_replay",   "date" => "2019-10-23", "scenario_id" => s1_id, "scenario_name" => "P"},
             %{"url" => "example2.com", "title" => "DEF", "resource_type" => "video_replay", "date" => "2019-10-21", "scenario_id" => s1_id, "scenario_name" => "P"}
           ]
  end

  test "can limit list of non-source resources", %{conn: conn} do
    %{s1: s1_id, s2: _} = create_test_resources()
    conn = get conn, Routes.scenario_scenario_resource_path(conn, :index, -1, %{"from" => "2019-10-23", "to" => "2019-10-24", "n" => 2})
    assert json_response(conn, 200)["data"]
           |> Enum.map(fn x -> Map.drop(x, ["id", "book", "issue", "notes", "page", "sort_order"]) end)
           == [
             %{"url" => "example5.com", "title" => "MNO", "resource_type" => "video_replay", "date" => "2019-10-24", "scenario_id" => s1_id, "scenario_name" => "P"},
             %{"url" => "example4.com", "title" => "JKL", "resource_type" => "web_replay",   "date" => "2019-10-23", "scenario_id" => s1_id, "scenario_name" => "P"},
           ]
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

  test "updating scenario resource preserves sort order", %{conn: conn} do
    user = Repo.insert! %User{name: "abc", email: "def@example.com", is_admin: true}
    scenario = TestHelper.create_scenario()
    resource = Repo.insert! %ScenarioResource{scenario_id: scenario.id, sort_order: 3, resource_type: 1}
    conn = TestHelper.create_session(conn, user)
    conn = put conn, Routes.scenario_scenario_resource_path(conn, :update, scenario.id, resource.id),
               resource: %{scenario_id: scenario.id, id: resource.id, resource_type: 2, sort_order: 5, url: "http://www.foo.com"}
    assert conn.status == 204
    updated_resource = Repo.get! ScenarioResource, resource.id
    assert updated_resource.resource_type == :web_replay
    assert updated_resource.url == "http://www.foo.com"
    assert updated_resource.sort_order == 5
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
