defmodule SbgInv.Web.FigureControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{FactionFigure, Figure, UserFigureHistory}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "unknown figure id returns error", %{conn: conn} do
    conn = get conn, figure_path(conn, :show, -1)
    assert conn.status == 404
  end

  test "shows figure info when user is not logged in", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn)

    conn = TestHelper.clear_sessions(conn)

    fid = TestHelper.std_scenario_figure_id(const_data, 0)
    figure = Repo.get!(Figure, fid)

    Repo.insert! %FactionFigure{figure: figure, faction_id: 7}
    Repo.insert! %FactionFigure{figure: figure, faction_id: 4}

    conn = get conn, figure_path(conn, :show, fid)
    assert json_response(conn, 200)["data"] == %{
      "id" => fid,
      "type" => "hero",
      "unique" => true,
      "name" => "ABC",
      "plural_name" => "ABCs",
      "factions" => [ "azogs_legion", "desolator_north" ],
      "scenarios" => [
        %{
          "scenario_id" => const_data["id"],
          "name" => "A",
          "amount" => 9
        }
      ],
      "owned" => 0,
      "painted" => 0,
      "history" => []
    }
  end

  test "shows owned figure info for logged in user", %{conn: conn} do
    %{conn: conn, const_data: const_data, user: user} = TestHelper.set_up_std_scenario(conn)

    fid = TestHelper.std_scenario_figure_id(const_data, 0)

    figure = Repo.get!(Figure, fid)

    Repo.insert! %FactionFigure{figure: figure, faction_id: 7}
    Repo.insert! %FactionFigure{figure: figure, faction_id: 4}

    Repo.insert! %UserFigureHistory{user_id: user.id, figure_id: figure.id, amount: 2, op: 1, new_owned: 3, new_painted: 3,
                                    op_date: ~D[2017-08-10]}
    Repo.insert! %UserFigureHistory{user_id: user.id, figure_id: figure.id, amount: 3, op: 1, new_owned: 4, new_painted: 4,
                                    op_date: ~D[2017-08-02], notes: "ABCD"}

    conn = get conn, figure_path(conn, :show, fid)
    assert json_response(conn, 200)["data"] == %{
      "id" => fid,
      "type" => "hero",
      "unique" => true,
      "name" => "ABC",
      "plural_name" => "ABCs",
      "factions" => [ "azogs_legion", "desolator_north" ],
      "scenarios" => [
        %{
          "scenario_id" => const_data["id"],
          "name" => "A",
          "amount" => 9
        }
      ],
      "owned" => 4,
      "painted" => 2,
      "history" => [
        %{ "op" => "sell_unpainted", "amount" => 2, "new_owned" => 3, "new_painted" => 3, "date" => "2017-08-10", "notes" => "" },
        %{ "op" => "sell_unpainted", "amount" => 3, "new_owned" => 4, "new_painted" => 4, "date" => "2017-08-02", "notes" => "ABCD" }
      ]
    }
  end
end
