defmodule SbgInv.Web.CharacterControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{Character, Figure}

  @valid_attrs %{
    "name" => "char name",
    "faction" => "harad"
  }

  test "anonymous user can't create character", %{conn: conn} do
    conn = post conn, Routes.character_path(conn, :create), character: @valid_attrs
    assert conn.status == 401
  end

  test "non-admin user can't create character", %{conn: conn} do
    conn = TestHelper.create_logged_in_user(conn, "abc", "xyz@example.com")
    conn = post conn, Routes.character_path(conn, :create), character: @valid_attrs
    assert conn.status == 401
  end

  test "admin user can create character", %{conn: conn} do
    conn = TestHelper.create_logged_in_user(conn, "abc", "xyz@example.com", true)

    f1 = TestHelper.add_figure("warriorB")
    f2 = TestHelper.add_figure("warriorA")

    conn = post conn, Routes.character_path(conn, :create),
                character: Map.merge(@valid_attrs,
                %{
                    "figure_ids" => [f1.id, f2.id],
                    "resources" => [
                      %{
                         type: "painting_guide",
                         title: "ABC",
                         url: "http://www.example.com"
                      }
                    ],
                    "rules" => [
                      %{
                        name_override: "OVER",
                        book: :aaa,
                        page: 82
                      }
                    ]
                })

    check_query =
      from c in Character,
      preload: [figures: ^from(f in Figure, order_by: f.name)]
    check = Repo.one!(check_query)

    assert json_response(conn, 201)["data"] == %{
             "id" => check.id,
             "name" => @valid_attrs["name"],
             "figures" => [
               %{ "id" => f2.id, "name" => f2.name },
               %{ "id" => f1.id, "name" => f1.name }
             ],
             "num_painting_guides" => 1,
             "num_analyses" => 0,
             "resources" => [
               %{
                 "type" => "painting_guide",
                 "title" => "ABC",
                 "url" => "http://www.example.com",
                 "book" => nil,
                 "issue" => nil,
                 "page" => nil
               }
             ],
             "rules" => [
               %{
                 "name_override" => "OVER",
                 "book" => "aaa",
                 "issue" => nil,
                 "page" => 82,
                 "url" => nil,
                 "obsolete" => nil,
                 "sort_order" => nil
               }
             ]
           }
  end

  test "can create character without figures or resources", %{conn: conn} do
    conn = TestHelper.create_logged_in_user(conn, "abc", "xyz@example.com", true)

    conn = post conn, Routes.character_path(conn, :create), character: @valid_attrs

    check = Repo.one!(Character)

    assert json_response(conn, 201)["data"] == %{
             "id" => check.id,
             "name" => @valid_attrs["name"],
             "figures" => [],
             "resources" => [],
             "rules" => [],
             "num_analyses" => 0,
             "num_painting_guides" => 0
           }
  end

  test "anonymous user can't update character", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn)
    ch_id = hd(const_data["character_ids"])
    conn = put conn, Routes.character_path(conn, :update, ch_id), character: @valid_attrs
    assert conn.status == 401
  end

  test "non-admin user can't update character", %{conn: conn} do
    %{conn: conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn, :user2)
    ch_id = hd(const_data["character_ids"])
    conn = put conn, Routes.character_path(conn, :update, ch_id), character: @valid_attrs
    assert conn.status == 401
  end

  test "admin user can update character", %{conn: conn} do
    %{conn: conn, user: user, const_data: const_data} = TestHelper.set_up_std_scenario(conn, :user2)
    TestHelper.promote_user_to_admin(user)

    ch_id = hd(const_data["character_ids"])
    f1 = TestHelper.add_figure("warriorB")
    f2 = TestHelper.add_figure("warriorA")

    conn = put conn, Routes.character_path(conn, :update, ch_id),
                character: Map.merge(@valid_attrs,
                  %{
                    figure_ids: [f1.id, f2.id],
                    resources: [
                      %{
                        type: "painting_guide",
                        title: "ABC",
                        url: "http://www.example.com",
                        issue: "42",
                        book: :sbg,
                        page: 12
                      }
                    ],
                    rules: [
                      %{
                        name_override: "OVER",
                        book: :tba,
                        page: 64
                      }
                    ]
                  })

    check_query =
      from c in Character,
      where: c.id == ^ch_id
    check = Repo.one!(check_query)

    assert json_response(conn, 200)["data"] == %{
             "id" => check.id,
             "name" => @valid_attrs["name"],
             "figures" => [
               %{ "id" => f2.id, "name" => f2.name },
               %{ "id" => f1.id, "name" => f1.name }
             ],
             "resources" => [
               %{
                 "type" => "painting_guide",
                 "title" => "ABC",
                 "url" => "http://www.example.com",
                 "issue" => "42",
                 "book" => "sbg",
                 "page" => 12
               }
             ],
             "rules" => [
               %{
                 "name_override" => "OVER",
                 "book" => "tba",
                 "issue" => nil,
                 "page" => 64,
                 "url" => nil,
                 "obsolete" => nil,
                 "sort_order" => nil
               }
             ],
             "num_painting_guides" => 1,
             "num_analyses" => 0
           }
  end

  test "anonymous user can't read character", %{conn: conn} do
    ch = Repo.insert! %Character{name: "A"}
    conn = get conn, Routes.character_path(conn, :show, ch.id)
    assert conn.status == 401
  end

  test "non-admin user can't show character", %{conn: conn} do
    ch = Repo.insert! %Character{name: "A"}
    conn = TestHelper.create_logged_in_user(conn, "abc", "xyz@example.com")
    conn = get conn, Routes.character_path(conn, :show, ch.id)
    assert conn.status == 401
  end

  test "admin user can show character", %{conn: conn} do
    %{conn: conn, user: user, const_data: const_data} = TestHelper.set_up_std_scenario(conn)
    TestHelper.promote_user_to_admin(user)
    ch_id = hd(const_data["character_ids"])
    conn = get conn, Routes.character_path(conn, :show, ch_id)
    assert json_response(conn, 200)["data"] == %{
             "id" => ch_id,
             "name" => "N1",
             "figures" => [
               %{"id" => TestHelper.std_scenario_figure_id(const_data, 0), "name" => "ABC"}
             ],
             "resources" => [
               %{
                 "type" => "painting_guide",
                 "title" => "SBG #3",
                 "book" => "sbg",
                 "issue" => "3",
                 "page" => 37,
                 "url" => nil
               },
               %{
                 "type" => "analysis",
                 "title" => "YouTube",
                 "url" => "http://www.example.com",
                 "book" => nil,
                 "issue" => nil,
                 "page" => nil
               }
             ],
             "rules" => [
               %{ "book" => "tba", "page" => 34, "issue" => "3", "obsolete" => true,  "sort_order" => 2, "name_override" => nil, "url" => nil},
             ],
             "num_painting_guides" => 1,
             "num_analyses" => 1
           }
  end
end
