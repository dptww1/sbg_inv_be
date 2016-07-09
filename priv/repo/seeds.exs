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

    #========================================================================
    site_s1 = Repo.insert! %Scenario {
      name: "The Fall of Amon Barad",
      blurb: "Easterlings under Khamûl launch a surprise attack on a Gondorian outpost in Ithilien.",
      date_age: 3,
      date_year: 2998,
      is_canonical: true,
      size: 30
    }

    Repo.insert! %ScenarioResource {
      scenario_id: site_s1.id,
      resource_type: 0,
      book: :site,
      sort_order: 1,
      page: 14
    }

    Repo.insert! %ScenarioFaction {
      scenario_id: site_s1.id,
      faction: :minas_tirith,
      suggested_points: 200,
      actual_points: 203,
      sort_order: 1
    }

    Repo.insert! %ScenarioFaction {
      scenario_id: site_s1.id,
      faction: :easterlings,
      suggested_points: 200,
      actual_points: 220,
      sort_order: 2
    }

    #========================================================================
    site_s2 = Repo.insert! %Scenario {
      name: "Pursuit Through Ithilien",
      blurb: "Easterlings pursue Cirion after the fall of Amon Barad.",
      date_age: 3,
      date_year: 2998,
      is_canonical: true,
      size: 28
    }

    Repo.insert! %ScenarioResource {
      scenario_id: site_s2.id,
      resource_type: 0,
      book: :site,
      sort_order: 2,
      page: 16
    }

    Repo.insert! %ScenarioFaction {
      scenario_id: site_s2.id,
      faction: :minas_tirith,
      suggested_points: 275,
      actual_points: 279,
      sort_order: 1
    }

    Repo.insert! %ScenarioFaction {
      scenario_id: site_s2.id,
      faction: :easterlings,
      suggested_points: 225,
      actual_points: 197,
      sort_order: 2
    }

    #========================================================================
    site_s3 = Repo.insert! %Scenario {
      name: "Gathering Information",
      blurb: "Cirion's forces try to capture a Khandish leader from a fort.",
      date_age: 3,
      date_year: 2998,
      is_canonical: true,
      size: 47
    }

    Repo.insert! %ScenarioResource {
      scenario_id: site_s3.id,
      resource_type: 0,
      book: :site,
      sort_order: 3,
      page: 28
    }

    Repo.insert! %ScenarioFaction {
      scenario_id: site_s3.id,
      faction: :minas_tirith,
      suggested_points: 350,
      actual_points: 329,
      sort_order: 1
    }

    Repo.insert! %ScenarioFaction {
      scenario_id: site_s3.id,
      faction: :easterlings,
      suggested_points: 350,
      actual_points: 420,
      sort_order: 2
    }
  end
end

SbgInv.Data.generate
