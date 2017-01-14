defmodule SbgInv.FigureControllerTest do
  use SbgInv.ConnCase

  alias SbgInv.{FactionFigure, Figure, TestHelper}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "unknown figure id returns error", %{conn: conn} do
    conn = get conn, figure_path(conn, :show, -1)
    assert conn.status == 404
  end

  test "shows figure info when user is not logged in", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn)

    fid = const_data["scenario_factions"]
          |> Enum.fetch!(0)
          |> Map.get("roles")
          |> Enum.fetch!(0)
          |> Map.get("figures")
          |> Enum.fetch!(0)
          |> Map.get("figure_id")

    #fid = hd(hd(hd(const_data["scenario_factions"])["roles"])["figures"])["figure_id"]
    figure = Repo.get!(Figure, fid)

    Repo.insert! %FactionFigure{figure: figure, faction_id: 7}
    Repo.insert! %FactionFigure{figure: figure, faction_id: 4}

    conn = get conn, figure_path(conn, :show, fid)
    assert json_response(conn, 200)["data"] == %{
      "id" => fid,
      "name" => "ABC",
      "factions" => [ "azogs_legion", "dol_guldur" ],
      "scenarios" => [
        %{
          "scenario_id" => const_data["id"],
          "name" => "A",
          "amount" => 9
        }
      ]
    }
  end
end
