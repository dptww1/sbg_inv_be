defmodule SbgInv.Web.FactionControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.Web.{FactionFigure,Figure}

  defp insert_figure(faction_id, name, plural_name, type, unique \\ false) do
    fig = Repo.insert! %Figure{name: name, plural_name: plural_name, type: type, unique: unique}
    if faction_id > 0 do
      Repo.insert! %FactionFigure{faction_id: faction_id, figure_id: fig.id}
    end
    fig
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "unknown faction id returns error", %{conn: conn} do
    conn = get conn, faction_path(conn, :show, -2)
    assert conn.status == 404
  end

  test "shows faction list when user is not logged in", %{conn: conn} do
    _1 = insert_figure(3, "??", "??s", :hero)  # verify only selected faction figures show up
    f2 = insert_figure(4, "h2", "h2s", :hero)
    f3 = insert_figure(4, "h1", "h1s", :hero, true)
    f4 = insert_figure(4, "w3", "w3s", :warrior)
    f5 = insert_figure(4, "w1", "w1s", :warrior)
    f6 = insert_figure(4, "m3", "m3s", :monster)
    f7 = insert_figure(4, "m1", "m1s", :monster, true)
    f8 = insert_figure(4, "s3", "s3s", :sieger)

    conn = get conn, faction_path(conn, :show, 4) # Azog's Legion
    assert json_response(conn, 200)["data"] == %{
      "heroes" => [
          %{"name" => "h1", "plural_name" => "h1s", "type" => "hero", "unique" => true,  "id" => f3.id},
          %{"name" => "h2", "plural_name" => "h2s", "type" => "hero", "unique" => false, "id" => f2.id}
      ],
      "warriors" => [
          %{"name" => "w1", "plural_name" => "w1s", "type" => "warrior", "unique" => false, "id" => f5.id},
          %{"name" => "w3", "plural_name" => "w3s", "type" => "warrior", "unique" => false, "id" => f4.id},
      ],
      "monsters" => [
          %{"name" => "m1", "plural_name" => "m1s", "type" => "monster", "unique" => true,  "id" => f7.id},
          %{"name" => "m3", "plural_name" => "m3s", "type" => "monster", "unique" => false, "id" => f6.id},
      ],
      "siegers" => [
          %{"name" => "s3", "plural_name" => "s3s", "type" => "sieger", "unique" => false, "id" => f8.id}
      ]
    }
  end

  test "shows unaffiliated figures for special value -1", %{conn: conn} do
    f1 = insert_figure(0, "??", "??s", :hero)  # verify only non faction figures show up
    _2 = insert_figure(3, "h2", "h2s", :hero)
    f3 = insert_figure(0, "h1", "h1s", :hero, true)
    _4 = insert_figure(4, "w3", "w3s", :warrior)
    f5 = insert_figure(0, "w1", "w1s", :warrior)
    _6 = insert_figure(4, "m3", "m3s", :monster)
    f7 = insert_figure(0, "m1", "m1s", :monster, true)
    _8 = insert_figure(4, "s3", "s3s", :sieger)

    conn = get conn, faction_path(conn, :show, -1)
    assert json_response(conn, 200)["data"] == %{
      "heroes"   => [ %{"name" => "??", "plural_name" => "??s", "type" => "hero",    "unique" => false, "id" => f1.id},
                      %{"name" => "h1", "plural_name" => "h1s", "type" => "hero",    "unique" => true,  "id" => f3.id} ],
      "warriors" => [ %{"name" => "w1", "plural_name" => "w1s", "type" => "warrior", "unique" => false, "id" => f5.id} ],
      "monsters" => [ %{"name" => "m1", "plural_name" => "m1s", "type" => "monster", "unique" => true,  "id" => f7.id} ],
      "siegers"  => [ ]
    }
  end
end
