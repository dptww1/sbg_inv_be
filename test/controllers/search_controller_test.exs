defmodule SbgInv.Web.SearchControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{Character, Figure, Scenario, ScenarioResource}

  setup _context do
    amon_hen_id     = declare_scenario("Amon Hen")
    amon_lhaw_id    = declare_scenario("Amon Lhaw")
    hunt_thrain_id  = declare_scenario("The Hunt for Thrain")
    monster_mash_id = declare_scenario("Monster Mash")

    thrain_id   = declare_figure("Thrain", "Thrains")
    gimli_f_id  = declare_figure("Gimli (Fellowship)", "Gimlis (F)")
    gimli_ah_id = declare_figure("Gimli (Amon Hen)", "Gimlis (A)")
    aragorn_id  = declare_figure("Aragorn", "Aragorns")

    gimli_ch_id = declare_character("Gimli (Character)", [gimli_f_id, gimli_ah_id])

    {:ok, %{ ids: %{
      amon_hen_id: amon_hen_id,
      amon_lhaw_id: amon_lhaw_id,
      hunt_thrain_id: hunt_thrain_id,
      monster_mash_id: monster_mash_id,
      thrain_id: thrain_id,
      gimli_f_id: gimli_f_id,
      gimli_ah_id: gimli_ah_id,
      aragorn_id: aragorn_id,
      gimli_ch_id: gimli_ch_id
    }}}
  end

  test "search for figures works (characters are excluded by default) ", %{conn: conn} = context do
    conn = get conn, Routes.search_path(conn, :index, q: "Gimli")
    assert json_response(conn, 200)["data"] == [
             %{
               "id" => context.ids.gimli_ah_id,
               "name" => "Gimli (Amon Hen)",
               "plural_name" => "Gimlis (A)",
               "type" => "f",
               "start" => 0,
               "book" => ""
             },
             %{
               "id" => context.ids.gimli_f_id,
               "name" => "Gimli (Fellowship)",
               "plural_name" => "Gimlis (F)",
               "type" => "f",
               "start" => 0,
               "book" => ""
             }
           ]
  end

  test "search can filter by figure", %{conn: conn} = context do
    conn = get conn, Routes.search_path(conn, :index, q: "amon", type: "f")
    assert json_response(conn, 200)["data"] == [
             %{
               "id" => context.ids.gimli_ah_id,
               "name" => "Gimli (Amon Hen)",
               "plural_name" => "Gimlis (A)",
               "type" => "f",
               "start" => 7,
               "book" => ""
             }
           ]
  end

  test "search can filter by scenario", %{conn: conn} = context do
    conn = get conn, Routes.search_path(conn, :index, q: "thrain", type: "s")
    assert json_response(conn, 200)["data"] == [
             %{
               "id" => context.ids.hunt_thrain_id,
               "name" => "The Hunt for Thrain",
               "plural_name" => "",
               "type" => "s",
               "start" => 13,
               "book" => "gaw"
             }
           ]
  end

  test "search can filter by character", %{conn: conn} = context do
    conn = get conn, Routes.search_path(conn, :index, q: "Gimli", type: "c")
    assert json_response(conn, 200)["data"] == [
             %{
               "id" => context.ids.gimli_ch_id,
               "name" => "Gimli (Character)",
               "plural_name" => "",
               "type" => "c",
               "start" => 0,
               "book" => ""
             }
           ]
  end

  defp declare_scenario(name) do
    struct = Repo.insert! %Scenario{
      name: name,
      blurb: "blurb goes here",
      date_age: 3,
      date_year: 3017,
      date_month: -1,
      date_day: -1,
      size: 17,
      map_width: 48,
      map_height: 48,
      location: :ithilien
    }

    TestHelper.create_scenario_source(struct.id)
    Repo.insert! %ScenarioResource{
      scenario_id: struct.id,
      resource_type: :video_replay,
      url: "http://www.example.com",
      updated_at: ~N[2020-10-19 00:00:00]
    }

    struct.id
  end

  defp declare_figure(name, plural_name) do
    struct = Repo.insert! %Figure{
      name: name,
      plural_name: plural_name,
      type: :hero
    }

    struct.id
  end

  defp declare_character(name, figure_id_list) do
    struct = Repo.insert! %Character{
      name: name,
      book: 12,
      page: 14,
      figures: Enum.map(figure_id_list, fn fid -> Repo.get!(Figure, fid) end)
    }

    struct.id
  end
end
