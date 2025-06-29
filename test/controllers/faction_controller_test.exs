defmodule SbgInv.Web.FactionControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{ArmyList, ArmyListSource, Book, FactionFigure, Figure, Role, RoleFigure, Scenario, ScenarioFaction, UserFigure}

  @valid_attrs %{
     "name" => "New Army List",
     "abbrev" => "nal",
     "alignment" => 1,
     "legacy" => false,
     "keywords" => "a c b",
     "sources" => [
       %{
         "book" => "sots",
         "page" => 13
       }
     ]
   }

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
             %{ "id" => 0,  "name" => "Angmar",           "abbrev" => "n_angmar",    "alignment" => 1, "legacy" => true,  "keywords" => "" },
             %{ "id" => 46, "name" => "Arathorn's Stand", "abbrev" => "arathorn",    "alignment" => 0, "legacy" => false, "keywords" => "menOfTheNorth" },
             %{ "id" => 51, "name" => "Army of Carn Dûm", "abbrev" => "carn_dum",    "alignment" => 1, "legacy" => false, "keywords" => "angmar" },
             %{ "id" => 59, "name" => "Army of Edoras",   "abbrev" => "army_edoras", "alignment" => 0, "legacy" => false, "keywords" => "rohan" }
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
        %{ "book" => "ah2", "issue" => nil, "page" => 90, "url" => nil }
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
        %{ "book" => "ah2", "issue" => nil, "page" => 122, "url" => nil }
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
    # verify only figures with legacy-only (or no) faction_figures entry show
    # first #: 9 => legacy (Dunharrow), 3 => non-legacy (Azog's Hunters)
    f1 = insert_figure(9, "??", "??s", :hero)
    _2 = insert_figure(3, "h2", "h2s", :hero)
    f3 = insert_figure(9, "h1", "h1s", :hero, true, "h1slug")
    _4 = insert_figure(3, "w3", "w3s", :warrior)
    f5 = insert_figure(9, "w1", "w1s", :warrior)
    _6 = insert_figure(3, "m3", "m3s", :monster)
    f7 = insert_figure(9, "m1", "m1s", :monster, true)
    _8 = insert_figure(3, "s3", "s3s", :sieger)

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

  test "Admin user can create army list", %{conn: conn} do
    conn = TestHelper.create_logged_in_user(conn, "admin", "admin@test.com", true)
    f1 = insert_figure(-1, "ABC", "ABCs", :hero)
    _2 = insert_figure(-1, "DEF", "DEFs", :warrior)
    f3 = insert_figure(-1, "GHI", "GHIs", :monster)

    conn = post conn, Routes.faction_path(conn, :create),
                army_list: Map.merge(@valid_attrs, %{
                             "faction_figures" => [
                               %{ "figure_id" => f1.id },
                               %{ "figure_id" => f3.id }
                             ]
                           })

    check_army_list = Repo.get_by!(ArmyList, abbrev: @valid_attrs["abbrev"])

    assert json_response(conn, 200)["data"] == %{
             "id"        => check_army_list.id,
             "name"      => @valid_attrs["name"],
             "abbrev"    => @valid_attrs["abbrev"],
             "alignment" => @valid_attrs["alignment"],
             "legacy"    => @valid_attrs["legacy"],
             "keywords"  => @valid_attrs["keywords"],
             "sources"   => [
               %{
                 "book"  => "sots",
                 "page"  => 13,
                 "issue" => nil,
                 "url"   => nil
               }
             ],
             "figures" => %{
               "heroes"   => [ %{ "id" => f1.id, "name" => "ABC", "plural_name" => "ABCs", "needed" => 0, "slug" => nil, "type" => "hero", "unique" => false } ],
               "warriors" => [],
               "monsters" => [ %{ "id" => f3.id, "name" => "GHI", "plural_name" => "GHIs", "needed" => 0, "slug" => nil, "type" => "monster", "unique" => false } ],
               "siegers"  => []
             }
           }
  end

  test "Non-admin user cannot create army list", %{conn: conn} do
    conn = conn
    |> TestHelper.create_logged_in_user("nonadmin", "regularjoe@test.com")
    |> post(Routes.faction_path(conn, :create), army_list: @valid_attrs)

    assert conn.status == 401
  end

  test "Anonymous user cannot create army list", %{conn: conn} do
    conn = post conn, Routes.faction_path(conn, :create), army_list: @valid_attrs
    assert conn.status == 401
  end

  test "Admin user can update army list", %{conn: conn} do
    conn = TestHelper.create_logged_in_user(conn, "admin", "admin@test.com", true)
    army_list = Repo.insert!(%ArmyList{name: "ABC", abbrev: "A", alignment: 0, legacy: true, keywords: "a b c"})
    book = Repo.get!(Book, 2)
    source = Repo.insert!(%ArmyListSource{army_list_id: army_list.id, page: 37, book: book})

    f1 = insert_figure(-1, "ABC", "ABCs", :hero)
    f2 = insert_figure(-1, "DEF", "DEFs", :warrior)
    f3 = insert_figure(-1, "GHI", "GHIs", :monster)

    Repo.insert!(%FactionFigure{faction_id: army_list.id, figure_id: f1.id})
    Repo.insert!(%FactionFigure{faction_id: army_list.id, figure_id: f3.id})

    conn = put conn, Routes.faction_path(conn, :update, army_list.id),
               army_list:
                 Map.merge(@valid_attrs,
                           %{
                             alignment: 0,
                             sources: [ source ],
                             faction_figures: [
                               %{faction_id: army_list.id, figure_id: f2.id},
                               %{faction_id: army_list.id, figure_id: f3.id}
                             ]
                           })

    assert json_response(conn, 200)["data"] == %{
             "id" => army_list.id,
             "name" => "New Army List",
             "abbrev" => "nal",
             "alignment" => 1,
             "legacy" => false,
             "keywords" => "a c b",
             "sources" => [
               %{"book" => "sots", "issue" => nil, "page" => 13, "url" => nil }
             ],
             "figures" => %{
               "heroes" => [],
               "warriors" => [ %{ "id" => f2.id, "name" => "DEF", "plural_name" => "DEFs", "slug" => nil, "type" => "warrior", "unique" => false, "needed" => 0} ],
               "monsters" => [ %{ "id" => f3.id, "name" => "GHI", "plural_name" => "GHIs", "slug" => nil, "type" => "monster", "unique" => false, "needed" => 0} ],
               "siegers" => []
             }
    }
  end

  test "Non-admin user cannot update army list", %{conn: conn} do
    conn = conn
    |> TestHelper.create_logged_in_user("nonadmin", "regularjoe@test.com")
    |> post(Routes.faction_path(conn, :create), army_list: @valid_attrs)

    assert conn.status == 401
  end

  test "Anonymous user cannot update army list", %{conn: conn} do
    conn = post conn, Routes.faction_path(conn, :create), army_list: @valid_attrs
    assert conn.status == 401
  end
end
