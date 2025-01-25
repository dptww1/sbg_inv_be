defmodule SbgInv.Web.FigureControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{FactionFigure, Figure, User, UserFigureHistory}

  @valid_attrs %{
    name: "The Name",
    plural_name: "The Plural Name",
    type: 1,
    unique: false,
    slug: "/rohan/the-name",
    factions: ["rohan", "shire"],
    same_as: ""
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "unknown figure id returns error", %{conn: conn} do
    conn = get conn, Routes.figure_path(conn, :show, -1)
    assert conn.status == 404
  end

  test "shows figure info when user is not logged in", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn)
    src = TestHelper.create_scenario_source(const_data["id"])

    conn = TestHelper.clear_sessions(conn)

    fid = TestHelper.std_scenario_figure_id(const_data, 0)
    figure = Repo.get!(Figure, fid)

    Repo.insert! %FactionFigure{figure: figure, faction_id: 7}
    Repo.insert! %FactionFigure{figure: figure, faction_id: 4}

    conn = get conn, Routes.figure_path(conn, :show, fid)
    assert json_response(conn, 200)["data"] == %{
      "id" => fid,
      "type" => "hero",
      "unique" => true,
      "name" => "ABC",
      "plural_name" => "ABCs",
      "factions" => [ "azogs_legion", "desolator_north" ],
      "slug" => "/azogs-legion/abc",
      "scenarios" => [
        %{
          "scenario_id" => const_data["id"],
          "name" => "A",
          "amount" => 9,
          "source" => %{
            "book" => "gaw",
            "id" => src.id,
            "scenario_id" => const_data["id"],
            "issue" => nil,
            "notes" => nil,
            "page" => 12,
            "resource_type" => "source",
            "sort_order" => 1,
            "title" => nil,
            "url" => nil,
            "date" => "2019-10-12"
          }
        }
      ],
      "owned" => 0,
      "painted" => 0,
      "history" => [],
      "rules" => [
        %{ "name_override" => nil, "book" => "tba", "page" => 34, "issue" => "3", "obsolete" => true, "sort_order" => 2, "url" => nil}
      ],
      "resources" => [
        %{"title" => "SBG #3", "type" => "painting_guide", "book" => "sbg", "issue" => "3", "page" => 37, "url" => nil},
        %{"title" => "YouTube", "type" => "analysis", "book" => nil, "issue" => nil, "page" => nil, "url" => "http://www.example.com"}
      ]
    }
  end

  test "shows owned figure info for logged in user", %{conn: conn} do
    %{conn: conn, const_data: const_data, user: user} = TestHelper.set_up_std_scenario(conn)
    src = TestHelper.create_scenario_source(const_data["id"])

    fid = TestHelper.std_scenario_figure_id(const_data, 0)

    figure = Repo.get!(Figure, fid)

    Repo.insert! %FactionFigure{figure: figure, faction_id: 7}
    Repo.insert! %FactionFigure{figure: figure, faction_id: 4}

    h1 = Repo.insert! %UserFigureHistory{user_id: user.id, figure_id: figure.id, amount: 2, op: 1,
                                         new_owned: 3, new_painted: 3,
                                         op_date: ~D[2017-08-10]}
    h2 = Repo.insert! %UserFigureHistory{user_id: user.id, figure_id: figure.id, amount: 3, op: 1,
                                         new_owned: 4, new_painted: 4,
                                         op_date: ~D[2017-08-02], notes: "ABCD"}

    conn = get conn, Routes.figure_path(conn, :show, fid)
    assert json_response(conn, 200)["data"] == %{
      "id" => fid,
      "type" => "hero",
      "unique" => true,
      "slug" => "/azogs-legion/abc",
      "name" => "ABC",
      "plural_name" => "ABCs",
      "factions" => [ "azogs_legion", "desolator_north" ],
      "scenarios" => [
        %{
          "scenario_id" => const_data["id"],
          "name" => "A",
          "amount" => 9,
          "source" => %{
            "book" => "gaw",
            "id" => src.id,
            "scenario_id" => const_data["id"],
            "issue" => nil,
            "notes" => nil,
            "page" => 12,
            "resource_type" => "source",
            "sort_order" => 1,
            "title" => nil,
            "url" => nil,
            "date" => "2019-10-12"
          }
        }
      ],
      "owned" => 4,
      "painted" => 2,
      "rules" => [
        %{ "book" => "tba", "page" => 34, "issue" => "3", "obsolete" => true, "sort_order" => 2, "name_override" => nil, "url" => nil},
      ],
      "history" => [
        %{"op" => "sell_unpainted", "amount" => 2, "new_owned" => 3, "new_painted" => 3, "op_date" => "2017-08-10", "notes" => "", "id" => h1.id, "figure_id" => figure.id},
        %{"op" => "sell_unpainted", "amount" => 3, "new_owned" => 4, "new_painted" => 4, "op_date" => "2017-08-02", "notes" => "ABCD", "id" => h2.id, "figure_id" => figure.id}
      ],
      "resources" => [
        %{"title" => "SBG #3", "type" => "painting_guide", "book" => "sbg", "issue" => "3", "page" => 37, "url" => nil},
        %{"title" => "YouTube", "type" => "analysis", "book" => nil, "issue" => nil, "page" => nil, "url" => "http://www.example.com"}
      ]
    }
  end

  test "can create figure if logged in as admin user and provides valid data", %{conn: conn} do
    user = Repo.insert! %User{name: "abc", email: "xyz@example.com", is_admin: true}
    conn = TestHelper.create_session(conn, user)
    conn = post conn, Routes.figure_path(conn, :create), figure: @valid_attrs

    check = Repo.one!(Figure) |> Repo.preload([:faction_figure])

    assert json_response(conn, 200)["data"] == %{
             "id" => check.id,
             "name" => "The Name",
             "plural_name" => "The Plural Name",
             "type" => "warrior",
             "unique" => false,
             "slug" => "/rohan/the-name",
             "history" => [],
             "owned" => 0,
             "painted" => 0,
             "scenarios" => [],
             "factions" => ["rohan", "shire"],
             "rules" => [],
             "resources" => []
           }
  end

  test "can create figure as 'copy' of existing figure", %{conn: conn} do
    %{conn: conn, user: user, const_data: const_data} = TestHelper.set_up_std_scenario(conn)
    TestHelper.promote_user_to_admin(user)

    other_fig_id = TestHelper.std_scenario_figure_id(const_data)
    TestHelper.add_faction_figure(other_fig_id, 34)

    conn = post conn, Routes.figure_path(conn, :create), figure: %{name: "X2", plural_name: "X3", same_as: other_fig_id}

    check = Repo.all(Figure)
            |> Enum.find(nil, &(&1.name == "X2"))

    assert json_response(conn, 200)["data"] == %{
             "id" => check.id,
             "name" => "X2",
             "plural_name" => "X3",
             "type" => "hero", # copied from src
             "unique" => true, # copied from src
             "slug" => nil,
             "history" => [],
             "owned" => 0,
             "painted" => 0,
             "scenarios" => [ # copied fromsrc
               %{
                 "scenario_id" => const_data["id"],
                 "name" => "A",
                 "amount" => 9,
                 "source" => nil
               }
             ],
             "factions" => ["rohan"], # copied from src
             "rules" => [
               %{ "book" => "tba", "page" => 34, "issue" => "3", "obsolete" => true, "sort_order" => 2, "name_override" => nil, "url" => nil},
             ],
             "resources" => [
               %{"book" => "sbg", "issue" => "3", "page" => 37, "title" => "SBG #3", "type" => "painting_guide", "url" => nil},
               %{"book" => nil, "issue" => nil, "page" => nil, "title" => "YouTube", "type" => "analysis", "url" => "http://www.example.com"}
             ]
           }
  end

  test "can't create figure if anonymous", %{conn: conn} do
    conn = post conn, Routes.figure_path(conn, :create), figure: @valid_attrs
    assert conn.status == 401
  end

  test "can't create figure if not admin", %{conn: conn} do
    conn = TestHelper.create_logged_in_user(conn)
    conn = post conn, Routes.figure_path(conn, :create), figure: @valid_attrs
    assert conn.status == 401
  end

  test "can update figure if logged in as admin user and provides valid data", %{conn: conn} do
    %{conn: conn, user: user, const_data: const_data} = TestHelper.set_up_std_scenario(conn, :user2)

    TestHelper.promote_user_to_admin(user)

    figure_id = TestHelper.std_scenario_figure_id(const_data, 0)

    Repo.insert! %FactionFigure{figure_id: figure_id, faction_id: 24}
    Repo.insert! %FactionFigure{figure_id: figure_id, faction_id: 15}
    Repo.insert! %FactionFigure{figure_id: figure_id, faction_id: 35}

    # We only edit the Figure<->Character relation from the Character side,
    # so updating the figure should preserve any Character relation
    conn = put conn, Routes.figure_path(conn, :update, figure_id), figure: @valid_attrs

    check = Figure.query_by_id(figure_id)
            |> Figure.with_characters_and_resources_and_rules
            |> Figure.with_factions
            |> Repo.one!

    assert json_response(conn, 200)["data"] == %{
             "id" => check.id,
             "name" => "The Name",
             "plural_name" => "The Plural Name",
             "type" => "warrior",
             "unique" => false,
             "slug" => "/rohan/the-name",
             "history" => [],
             "owned" => 2,
             "painted" => 2,
             "scenarios" => [%{"amount" => 9, "name" => "A", "scenario_id" => const_data["id"], "source" => nil}],
             "factions" => ["rohan", "shire"],
             "rules" => [
               %{ "book" => "tba", "page" => 34, "issue" => "3", "obsolete" => true, "sort_order" => 2, "name_override" => nil, "url" => nil},
             ],
             "resources" => [
               %{"title" => "SBG #3", "type" => "painting_guide", "book" => "sbg", "issue" => "3", "page" => 37, "url" => nil},
               %{"title" => "YouTube", "type" => "analysis", "book" => nil, "issue" => nil, "page" => nil, "url" => "http://www.example.com"}
             ]
           }
  end

  test "can't update figure if anonymous", %{conn: conn} do
    figure = Repo.insert! %Figure{name: "n",  plural_name: "p", type: :warrior, unique: false}
    conn = put conn, Routes.figure_path(conn, :update, figure.id), figure: @valid_attrs
    assert conn.status == 401
  end

  test "can't update figure if not admin", %{conn: conn} do
    figure = Repo.insert! %Figure{name: "n",  plural_name: "p", type: :warrior, unique: false}
    conn = TestHelper.create_logged_in_user(conn)
    conn = put conn, Routes.figure_path(conn, :update, figure.id), figure: @valid_attrs
    assert conn.status == 401
  end
end
