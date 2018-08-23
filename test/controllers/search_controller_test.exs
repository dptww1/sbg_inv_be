defmodule SbgInv.Web.SearchControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.Web.{Figure, Scenario}

  setup _context do
    amon_hen_id     = declare_scenario("Amon Hen")
    amon_lhaw_id    = declare_scenario("Amon Lhaw")
    hunt_thrain_id  = declare_scenario("The Hunt for Thrain")
    monster_mash_id = declare_scenario("Monster Mash")

    thrain_id   = declare_figure("Thrain")
    gimli_f_id  = declare_figure("Gimli (Fellowship)")
    gimli_ah_id = declare_figure("Gimli (Amon Hen)")
    aragorn_id  = declare_figure("Aragorn")

    {:ok, %{ ids: %{
      amon_hen_id: amon_hen_id,
      amon_lhaw_id: amon_lhaw_id,
      hunt_thrain_id: hunt_thrain_id,
      monster_mash_id: monster_mash_id,
      thrain_id: thrain_id,
      gimli_f_id: gimli_f_id,
      gimli_ah_id: gimli_ah_id,
      aragorn_id: aragorn_id
    }}}
  end

  test "search for figures works", context do
    conn = get conn(), search_path(conn, :index, q: "Gimli")
    assert json_response(conn, 200)["data"] == [
             %{"id" => context[:ids][:gimli_ah_id], "name" => "Gimli (Amon Hen)",   "type" => "f", "start" => 0},
             %{"id" => context[:ids][:gimli_f_id],  "name" => "Gimli (Fellowship)", "type" => "f", "start" => 0}
           ]
  end

  def declare_scenario(name) do
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

    struct.id
  end

  def declare_figure(name) do
    struct = Repo.insert! %Figure{
      name: name,
      type: :hero
    }

    struct.id
  end
end
