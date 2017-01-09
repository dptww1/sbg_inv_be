defmodule SbgInv.FactionControllerTest do
  use SbgInv.ConnCase

  alias SbgInv.{FactionFigure,Figure}

  defp insert_figure(faction_id, name, plural_name, type, unique \\ false) do
    fig = Repo.insert! %Figure{name: name, plural_name: plural_name, type: type, unique: unique}
    Repo.insert! %FactionFigure{faction_id: faction_id, figure: fig}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "unknown faction id returns error", %{conn: conn} do
    conn = get conn, faction_path(conn, :show, -1)
    assert conn.status == 404
  end

  test "shows faction list when user is not logged in", %{conn: conn} do
    insert_figure(3, "??", "??s", :hero)  # verify only selected faction figures show up
    insert_figure(4, "h2", "h2s", :hero)
    insert_figure(4, "h1", "h1s", :hero, true)
    insert_figure(4, "w3", "w3s", :warrior)
    insert_figure(4, "w1", "w1s", :warrior)
    insert_figure(4, "m3", "m3s", :monster)
    insert_figure(4, "m1", "m1s", :monster, true)
    insert_figure(4, "s3", "s3s", :sieger)

    conn = get conn, faction_path(conn, :show, 4) # Azog's Legion
    assert json_response(conn, 200)["data"] == %{
      "heroes" => [
          %{"name" => "h1", "plural_name" => "h1s", "type" => "hero", "unique" => true},
          %{"name" => "h2", "plural_name" => "h2s", "type" => "hero", "unique" => false}
      ],
      "warriors" => [
          %{"name" => "w1", "plural_name" => "w1s", "type" => "warrior", "unique" => false},
          %{"name" => "w3", "plural_name" => "w3s", "type" => "warrior", "unique" => false},
      ],
      "monsters" => [
          %{"name" => "m1", "plural_name" => "m1s", "type" => "monster", "unique" => true},
          %{"name" => "m3", "plural_name" => "m3s", "type" => "monster", "unique" => false},
      ],
      "siegers" => [
          %{"name" => "s3", "plural_name" => "s3s", "type" => "sieger", "unique" => false}
      ]
    }
  end
end
