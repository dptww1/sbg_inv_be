defmodule SbgInv.Web.FactionControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{FactionFigure, Figure, Role, RoleFigure, Scenario, ScenarioFaction, UserFigure}

  defp insert_figure(faction_id, name, plural_name, type, unique \\ false, slug \\ nil) do
    fig = Repo.insert! %Figure{name: name, plural_name: plural_name, type: type, unique: unique, slug: slug}
    if faction_id > 0 do
      Repo.insert! %FactionFigure{faction_id: faction_id, figure_id: fig.id}
    end
    fig
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "shows army lists / factions when user is not logged in", %{conn: conn} do
    conn = get conn, Routes.faction_path(conn, :index)
    assert json_response(conn, 200)["data"]["factions"] |> Enum.slice(0, 4) == [
             %{ "id" => 46, "name" => "Arathorn's Stand", "abbrev" => "arathorn",     "alignment" => 0, "legacy" => false, "keywords" => "menOfTheNorth" },
             %{ "id" => 51, "name" => "Army of Carn Dûm", "abbrev" => "carn_dum",     "alignment" => 1, "legacy" => false, "keywords" => "angmar" },
             %{ "id" => 59, "name" => "Army of Edoras",   "abbrev" => "army_edoras",  "alignment" => 0, "legacy" => false, "keywords" => "rohan" },
             %{ "id" => 72, "name" => "Army of Gothmog",  "abbrev" => "army_gothmog", "alignment" => 1, "legacy" => false, "keywords" => "mordorAndAllies" }
           ]
  end

  test "shows army list with figure counts for logged in user", %{conn: conn} do
    user = TestHelper.create_user()
    user2 = TestHelper.create_user("og", "other_guy@example.com")
    conn = TestHelper.create_session(conn, user)

    fig1 = insert_figure(34, "fig1", nil, :warrior)
    fig2 = insert_figure(34, "fig2", nil, :hero)
    fig3 = insert_figure(32, "fig3", nil, :warrior)
    fig4 = insert_figure(27, "fig4", nil, :monster)

    Repo.insert! %UserFigure{user_id: user.id, figure_id: fig1.id, owned: 4, painted: 2}
    Repo.insert! %UserFigure{user_id: user.id, figure_id: fig2.id, owned: 3, painted: 3}
    Repo.insert! %UserFigure{user_id: user.id, figure_id: fig3.id, owned: 2, painted: 1}
    Repo.insert! %UserFigure{user_id: user.id, figure_id: fig4.id, owned: 1, painted: 0}
    Repo.insert! %UserFigure{user_id: user2.id, figure_id: fig4.id, owned: 4, painted: 2}

    conn = get conn, Routes.faction_path(conn, :index)

    assert json_response(conn, 200)["data"] == %{
      "rohan" => %{"owned" => 7, "painted" => 5},
      "rivendell" => %{"owned" => 2, "painted" => 1},
      "mordor" => %{"owned" => 1, "painted" => 0},
      "Totals" => %{"owned" => 10, "painted" => 6}
    }
  end

  test "unknown faction id returns error", %{conn: conn} do
    conn = get conn, Routes.faction_path(conn, :show, -2)
    assert conn.status == 404
  end

  test "shows army list details with user's collection info when user is logged in", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn)

    fid = TestHelper.std_scenario_figure_id(const_data, 0)

    Repo.insert! %FactionFigure{faction_id: 34, figure_id: fid}

    conn = get conn, Routes.faction_path(conn, :show, 34)
    assert json_response(conn, 200)["data"] == %{
      "sources" => [
        %{ "book" => "alotr2", "issue" => nil, "page" => 90, "url" => nil }
      ],
      "heroes" => [
        %{
          "id" => fid,
          "name" => "ABC",
          "plural_name" => "ABCs",
          "type" => "hero",
          "unique" => true,
          "needed" => 9,
          "owned" => 4,
          "painted" => 2,
          "slug" => "/azogs-legion/abc",
          "num_painting_guides" => 1,
          "num_analyses" => 1
        }
      ],
      "monsters" => [],
      "siegers" => [],
      "warriors" => []
    }
  end

  test "shows faction list when user is not logged in", %{conn: conn} do
    scenario = Repo.insert! %Scenario{name: "A", blurb: "B", date_age: 3, date_year: 1, date_month: 1, date_day: 1, size: 5,
                                      map_width: 7, map_height: 9, location: :eriador}

    faction1 = Repo.insert! %ScenarioFaction{scenario_id: scenario.id, suggested_points: 0, actual_points: 0, sort_order: 1}
    _faction2 = Repo.insert! %ScenarioFaction{scenario_id: scenario.id, suggested_points: 0, actual_points: 0, sort_order: 2}

    role1 = Repo.insert! %Role{scenario_faction_id: faction1.id, amount: 1, sort_order: 1, name: "ABC"}
    role2 = Repo.insert! %Role{scenario_faction_id: faction1.id, amount: 4, sort_order: 2, name: "DEF"}

    _1 = insert_figure(42, "??", "??s", :hero)  # verify only selected faction figures show up
    f2 = insert_figure(67, "h2", "h2s", :hero)
    f3 = insert_figure(67, "h1", "h1s", :hero, true, "h1s_slug")
    f4 = insert_figure(67, "w3", "w3s", :warrior)
    f5 = insert_figure(67, "w1", "w1s", :warrior)
    f6 = insert_figure(67, "m3", "m3s", :monster)
    f7 = insert_figure(67, "m1", "m1s", :monster, true)
    f8 = insert_figure(67, "s3", "s3s", :sieger)

    Repo.insert! %RoleFigure{role_id: role1.id, figure_id: f2.id}
    Repo.insert! %RoleFigure{role_id: role2.id, figure_id: f4.id}

    conn = get conn, Routes.faction_path(conn, :show, 67)
    assert json_response(conn, 200)["data"] == %{
      "sources" => [
        %{ "book" => "alotr2", "issue" => nil, "page" => 122, "url" => nil }
      ],
      "heroes" => [
          %{"name" => "h1", "plural_name" => "h1s", "type" => "hero", "unique" => true,  "id" => f3.id, "needed" => 0, "owned" => 0, "painted" => 0, "slug" => "h1s_slug", "num_painting_guides" => 0, "num_analyses" => 0},
          %{"name" => "h2", "plural_name" => "h2s", "type" => "hero", "unique" => false, "id" => f2.id, "needed" => 1, "owned" => 0, "painted" => 0, "slug" => nil, "num_painting_guides" => 0, "num_analyses" => 0},
      ],
      "warriors" => [
          %{"name" => "w1", "plural_name" => "w1s", "type" => "warrior", "unique" => false, "id" => f5.id, "needed" => 0, "owned" => 0, "painted" => 0, "slug" => nil, "num_painting_guides" => 0, "num_analyses" => 0},
          %{"name" => "w3", "plural_name" => "w3s", "type" => "warrior", "unique" => false, "id" => f4.id, "needed" => 4, "owned" => 0, "painted" => 0, "slug" => nil, "num_painting_guides" => 0, "num_analyses" => 0},
      ],
      "monsters" => [
          %{"name" => "m1", "plural_name" => "m1s", "type" => "monster", "unique" => true,  "id" => f7.id, "needed" => 0, "owned" => 0, "painted" => 0, "slug" => nil, "num_painting_guides" => 0, "num_analyses" => 0},
          %{"name" => "m3", "plural_name" => "m3s", "type" => "monster", "unique" => false, "id" => f6.id, "needed" => 0, "owned" => 0, "painted" => 0, "slug" => nil, "num_painting_guides" => 0, "num_analyses" => 0},
      ],
      "siegers" => [
          %{"name" => "s3", "plural_name" => "s3s", "type" => "sieger", "unique" => false, "id" => f8.id, "needed" => 0, "owned" => 0, "painted" => 0, "slug" => nil, "num_painting_guides" => 0, "num_analyses" => 0},
      ]
    }
  end

  test "shows unaffiliated figures with user info for special value -1", %{conn: conn} do
    f1 = insert_figure(0, "??", "??s", :hero)  # verify only non faction figures show up
    _2 = insert_figure(3, "h2", "h2s", :hero)
    f3 = insert_figure(0, "h1", "h1s", :hero, true, "h1slug")
    _4 = insert_figure(4, "w3", "w3s", :warrior)
    f5 = insert_figure(0, "w1", "w1s", :warrior)
    _6 = insert_figure(4, "m3", "m3s", :monster)
    f7 = insert_figure(0, "m1", "m1s", :monster, true)
    _8 = insert_figure(4, "s3", "s3s", :sieger)

    user1 = TestHelper.create_user("user1", "user1@example.com")
    user2 = TestHelper.create_user("user2", "user2@example.com")

    conn = TestHelper.create_session(conn, user1)

    Repo.insert! %UserFigure{figure_id: f1.id, user_id: user1.id, owned: 8, painted: 4}
    Repo.insert! %UserFigure{figure_id: f7.id, user_id: user2.id, owned: 3, painted: 1}

    conn = get conn, Routes.faction_path(conn, :show, "-1")
    assert json_response(conn, 200)["data"] == %{
      "heroes"   => [
        %{"name" => "??", "plural_name" => "??s", "type" => "hero",    "unique" => false, "id" => f1.id, "needed" => 0, "owned" => 8, "painted" => 4, "slug" => nil, "num_painting_guides" => 0, "num_analyses" => 0 },
        %{"name" => "h1", "plural_name" => "h1s", "type" => "hero",    "unique" => true,  "id" => f3.id, "needed" => 0, "owned" => 0, "painted" => 0, "slug" => "h1slug", "num_painting_guides" => 0, "num_analyses" => 0}
      ],
      "warriors" => [
        %{"name" => "w1", "plural_name" => "w1s", "type" => "warrior", "unique" => false, "id" => f5.id, "needed" => 0, "owned" => 0, "painted" => 0, "slug" => nil, "num_painting_guides" => 0, "num_analyses" => 0}
      ],
      "monsters" => [
        %{"name" => "m1", "plural_name" => "m1s", "type" => "monster", "unique" => true,  "id" => f7.id, "needed" => 0, "owned" => 0, "painted" => 0, "slug" => nil, "num_painting_guides" => 0, "num_analyses" => 0}
      ],
      "siegers"  => [ ]
    }
  end
end
