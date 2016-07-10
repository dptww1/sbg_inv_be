# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SbgInv.Repo.insert!(%SbgInv.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# modeled on https://github.com/parkerl/fishing_spot/blob/master/priv/repo/seeds.exs

defmodule SbgInv.Data do
  alias SbgInv.Repo
  alias SbgInv.Scenario
  alias SbgInv.ScenarioResource
  alias SbgInv.ScenarioFaction

  def generate do
    _generate
  end

  defp _generate do
    IO.puts "Generating data"

    #########################################################################
    # A SHADOW IN THE EAST
    #########################################################################

    #========================================================================
    site_s1 = Repo.insert! %Scenario {
      name: "The Fall of Amon Barad",
      blurb: "Easterlings under Khamûl launch a surprise attack on a Gondorian outpost in Ithilien.",
      date_age: 3, date_year: 2998, is_canonical: true, size: 30
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s1.id, resource_type: 0, book: :site, sort_order: 1, page: 14 }

    Repo.insert! %ScenarioResource { scenario_id: site_s1.id, resource_type: 2, url: "http://www.davetownsend.org/Battles/LotR-20160604/", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s1.id, faction: :minas_tirith, suggested_points: 200, actual_points: 203, sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s1.id, faction: :easterlings, suggested_points: 200, actual_points: 220, sort_order: 2 }

    #========================================================================
    site_s2 = Repo.insert! %Scenario {
      name: "Pursuit Through Ithilien",
      blurb: "Easterlings pursue Cirion after the fall of Amon Barad.",
      date_age: 3, date_year: 2998, is_canonical: true, size: 28
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s2.id, resource_type: 0, book: :site, sort_order: 2, page: 16 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s2.id, faction: :minas_tirith, suggested_points: 275, actual_points: 279, sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s2.id, faction: :easterlings, suggested_points: 225, actual_points: 197, sort_order: 2 }

    #========================================================================
    site_s3 = Repo.insert! %Scenario {
      name: "Gathering Information",
      blurb: "Cirion's forces try to capture a Khandish leader from a fort.",
      date_age: 3, date_year: 2998, is_canonical: true, size: 47
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s3.id, resource_type: 0, book: :site, sort_order: 3, page: 28 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s3.id, faction: :minas_tirith, suggested_points: 350, actual_points: 329, sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s3.id, faction: :easterlings, suggested_points: 350, actual_points: 420, sort_order: 2 }

    #========================================================================
    site_s4 = Repo.insert! %Scenario {
      name: "Turning the Tide",
      blurb: "Cirion surprise attacks an Easterling camp at night.",
      date_age: 3, date_year: 2998, is_canonical: true, size: 121
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s4.id, resource_type: 0, book: :site, sort_order: 4, page: 30 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s4.id, faction: :minas_tirith, suggested_points: 900, actual_points: 849, sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s4.id, faction: :easterlings, suggested_points: 600, actual_points: 813, sort_order: 2 }

    #========================================================================
    site_s5 = Repo.insert! %Scenario {
      name: "Reprisals",
      blurb: "Dáin Ironfoot leads a dwarven raid against the Easterlings.",
      date_age: 3, date_year: 3001, is_canonical: true, size: 71
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s5.id, resource_type: 0, book: :site, sort_order: 5, page: 36 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s5.id, faction: :dwarves, suggested_points: 500, actual_points: 460, sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s5.id, faction: :easterlings, suggested_points: 550, actual_points: 511, sort_order: 2 }

    #========================================================================
    site_s6 = Repo.insert! %Scenario {
      name: "Strange Circumstances",
      blurb: "Cirion joins his Khandish captors to fight off an Orc raid.",
      date_age: 3, date_year: 3002, is_canonical: true, size: 101
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s6.id, resource_type: 0, book: :site, sort_order: 6, page: 38 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s6.id, faction: :easterlings, suggested_points: 500, actual_points: 700, sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s6.id, faction: :mordor, suggested_points: 750, actual_points: 796, sort_order: 2 }

    #========================================================================
    site_s7 = Repo.insert! %Scenario {
      name: "The Field of Celebrant",
      blurb: "Eorl the Young saves Gondor from the Khandish and their Orc allies.",
      date_age: 3, date_year: 2510, is_canonical: true, size: 107
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s7.id, resource_type: 0, book: :site, sort_order: 7, page: 40 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s7.id, faction: :rohan, suggested_points: 650, actual_points: 635, sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s7.id, faction: :easterlings, suggested_points: 800, actual_points: 949, sort_order: 2 }

    #========================================================================
    site_s8 = Repo.insert! %Scenario {
      name: "Hunter & Hunted",
      blurb: "Easterling raiders under Khamûl encounter the defenders of Fangorn.",
      date_age: 3, date_year: 2520, is_canonical: true, size: 28
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s8.id, resource_type: 0, book: :site, sort_order: 8, page: 46 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s8.id, faction: :free_peoples, suggested_points: 400, actual_points: 495, sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s8.id, faction: :easterlings, suggested_points: 450, actual_points: 430, sort_order: 2 }

    #########################################################################
    # THE FALL OF THE NECROMANCER
    #########################################################################

    #========================================================================
    fotn_s1 = Repo.insert! %Scenario {
      name: "Dol Guldur Awakens",
      blurb: "Thranduil leads a warband against the creatures of Mirkwood.",
      date_age: 3,  date_year: 2060, is_canonical: true, size: 22
    }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s1.id, resource_type: 0, book: :fotn, sort_order: 1, page: 8 }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s1.id, resource_type: 1, url: "https://www.youtube.com/watch?v=0_dCdLngsKs&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s1.id, faction: :mirkwood, suggested_points: 200, actual_points: 273, sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s1.id, faction: :dol_guldur, suggested_points: 200, actual_points: 150, sort_order: 2 }

    #========================================================================
    fotn_s2 = Repo.insert! %Scenario {
      name: "In the Nick of Time",
      blurb: "Elrond joins Thranduil against an attack from Dol Guldur lead by Khamûl.",
      date_age: 3,  date_year: 2061, is_canonical: true, size: 65
    }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s2.id, resource_type: 0, book: :fotn, sort_order: 2, page: 10 }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s1.id, resource_type: 1, url: "https://www.youtube.com/watch?v=AMrP8abPj0Q&index=2&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s2.id, faction: :mirkwood, suggested_points: 600, actual_points: 0, sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s2.id, faction: :dol_guldur, suggested_points: 600, actual_points: 0, sort_order: 2 }
  end
end

SbgInv.Data.generate
