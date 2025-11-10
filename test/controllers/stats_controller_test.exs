defmodule SbgInv.StatsTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.{Repo, TestHelper}
  alias SbgInv.Web.{Figure, UserFigureHistory}

  test "site stats are returned", %{conn: conn} do
    TestHelper.set_up_std_scenario(conn)

    # Add some more users
    u3 = TestHelper.create_user("USER3", "somewhere@example.com")
    u4 = TestHelper.create_user("USER4", "otherguy@example.com")

    # Add some heroes
    hero1_id = TestHelper.add_figure("HERO1", "X", :hero).id
    hero2_id = TestHelper.add_figure("HERO2", "X", :hero).id

    TestHelper.add_user_figure(u3.id, hero1_id, 9, 3)
    TestHelper.add_user_figure(u4.id, hero2_id, 8, 8)

    # Add some more warriors (std scenario already includes one)
    warrior1_id = TestHelper.add_figure("WARRIOR1", "X", :warrior).id
    warrior2_id = TestHelper.add_figure("WARRIOR2", "X", :warrior).id

    TestHelper.add_user_figure(u3.id, warrior1_id, 23, 21)
    TestHelper.add_user_figure(u4.id, warrior1_id, 12, 12)

    TestHelper.add_user_figure(u3.id, warrior2_id, 8, 5)

    # Add some monsters
    monster1_id = TestHelper.add_figure("MONSTER1", "X", :monster).id
    monster2_id = TestHelper.add_figure("MONSTER2", "X", :monster).id

    TestHelper.add_user_figure(u3.id, monster1_id, 4, 1)
    TestHelper.add_user_figure(u4.id, monster1_id, 2, 0)

    TestHelper.add_user_figure(u3.id, monster2_id, 7, 2)

    fig0_id = Repo.get_by!(Figure, name: "ABC").id
    fig1_id = Repo.get_by!(Figure, name: "DEF").id

    Repo.insert! %UserFigureHistory{user_id: u3.id, figure_id: warrior1_id, op: :buy_unpainted, amount: 9, op_date: ~D[2025-10-08]}
    Repo.insert! %UserFigureHistory{user_id: u4.id, figure_id: warrior1_id, op: :buy_unpainted, amount: 8, op_date: ~D[2025-11-06]}
    Repo.insert! %UserFigureHistory{user_id: u3.id, figure_id: warrior1_id, op: :paint,         amount: 3, op_date: ~D[2025-11-05]}
    Repo.insert! %UserFigureHistory{user_id: u4.id, figure_id: warrior1_id, op: :paint,         amount: 1, op_date: ~D[2025-11-07]}

    conn = get conn, Routes.stats_path(conn, :index)

    assert json_response(conn, 200)["data"] == %{
             "users" => %{"total" => 4},
             "models" => %{
               "totalOwned" => 83,
               "totalPainted" => 57,
               "mostCollected" => %{
                 "character" => [
                   %{"id" => fig0_id, "name" => "ABC", "slug" => "/azogs-legion/abc", "total" => 6}
                 ],
                 "hero" => [
                   %{"id" => hero1_id, "name" => "HERO1", "slug" => nil, "total" => 9},
                   %{"id" => hero2_id, "name" => "HERO2", "slug" => nil, "total" => 8}
                 ],
                 "warrior" => [
                   %{"id" => warrior1_id, "name" => "WARRIOR1", "slug" => nil, "total" => 35},
                   %{"id" => warrior2_id, "name" => "WARRIOR2", "slug" => nil, "total" => 8},
                   %{"id" => fig1_id, "name" => "DEF", "slug" => "/azogs-legion/def", "total" => 4}
                 ],
                 "monster" => [
                   %{"id" => monster2_id, "name" => "MONSTER2", "slug" => nil, "total" => 7},
                   %{"id" => monster1_id, "name" => "MONSTER1", "slug" => nil, "total" => 6}
                 ]
               },
               "mostPainted" => %{
                 "character" => [
                   %{"id" => fig0_id, "name" => "ABC", "slug" => "/azogs-legion/abc", "total" => 4}
                 ],
                 "hero" => [
                   %{"id" => hero2_id, "name" => "HERO2", "slug" => nil, "total" => 8},
                   %{"id" => hero1_id, "name" => "HERO1", "slug" => nil, "total" => 3}
                 ],
                 "warrior" => [
                   %{"id" => warrior1_id, "name" => "WARRIOR1", "slug" => nil, "total" => 33},
                   %{"id" => warrior2_id, "name" => "WARRIOR2", "slug" => nil, "total" => 5},
                   %{"id" => fig1_id, "name" => "DEF", "slug" => "/azogs-legion/def", "total" => 1}
                 ],
                 "monster" => [
                   %{"id" => monster2_id, "name" => "MONSTER2", "slug" => nil, "total" => 2},
                   %{"id" => monster1_id, "name" => "MONSTER1", "slug" => nil, "total" => 1}
                 ]
               },
               "recentlyPainted" => [
                 %{"id" => warrior1_id, "amt" => 3, "name" => "WARRIOR1", "slug" => nil},
                 %{"id" => warrior1_id, "amt" => 1, "name" => "WARRIOR1", "slug" => nil}
               ]
             }
           }
  end
end
