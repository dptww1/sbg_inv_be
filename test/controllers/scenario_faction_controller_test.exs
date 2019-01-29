defmodule SbgInv.RoleControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{Figure, User}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "cannot update resource as anonymous user", %{conn: conn} do
    conn = put conn, Routes.scenario_faction_path(conn, :update, 123), scenario_faction: %{}
    assert conn.status == 401
  end

  test "cannot update resource as non-admin user", %{conn: conn} do
    user = Repo.insert! %User{name: "abc", email: "xyz@example.com"}
    conn = TestHelper.create_session(conn, user)
    conn = put conn, Routes.scenario_faction_path(conn, :update, 123), scenario_faction: %{}
    assert conn.status == 401
  end

  test "can update resource as admin user", %{conn: conn} do
    %{conn: conn, user: user, const_data: data} = TestHelper.set_up_std_scenario(conn, :user2)

    user
    |> Ecto.Changeset.change(%{:is_admin => true})
    |> Repo.update!

    fig1_id = Repo.get_by(Figure, name: "ABC").id
    fig2_id = Repo.get_by(Figure, name: "DEF").id

    conn = put conn,
               Routes.scenario_faction_path(conn, :update, hd(data["scenario_factions"])["id"]),
               scenario_faction: %{
                 faction: :fangorn,
                 suggested_points: 10,
                 actual_points: 2,
                 sort_order: 2,
                 roles: [
                   %{
                     id: TestHelper.std_scenario_role_id(data, 0, 0),
                     amount: 1,
                     sort_order: 1,
                     name: "alpha",
                     figures: [ %{figure_id: fig1_id}, %{figure_id: fig2_id} ]
                   },
                   %{
                     id: TestHelper.std_scenario_role_id(data, 0, 1),
                     amount: 3,
                     sort_order: 2,
                     name: "beta",
                     figures: [ %{figure_id: fig1_id }]
                   }
                 ]
               }

    assert json_response(conn, 200) == %{
      "id" => hd(data["scenario_factions"])["id"],
      "faction" => "fangorn",
      "suggested_points" => 10,
      "actual_points" => 2,
      "sort_order" => 2,
      "roles" => [
        %{ "id" => TestHelper.std_scenario_role_id(data, 0, 0),
           "amount" => 1, "sort_order" => 1, "name" => "alpha", "figures" => [
             %{"figure_id" => fig1_id, "name" => "ABC"},
             %{"figure_id" => fig2_id, "name" => "DEF"}
           ] },
        %{ "id" => TestHelper.std_scenario_role_id(data, 0, 1),
           "amount" => 3, "sort_order" => 2, "name" => "beta", "figures" => [
             %{"figure_id" => fig1_id, "name" => "ABCs"}
           ] }
      ]
    }
  end
end
