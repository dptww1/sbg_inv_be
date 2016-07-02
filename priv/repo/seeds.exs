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

  def generate do
    _generate
  end

  defp _generate do
    IO.puts "Generating data"

    site_s1 = Repo.insert! %Scenario {
      name: "The Fall of Amon Barad",
      blurb: "Easterlings under Khamûl launch a surprise attack on a Gondorian outpost in Ithilien.",
      date_age: 3,
      date_year: 2998,
      is_canonical: true,
      size: 30
    }

    site_s2 = Repo.insert! %Scenario {
      name: "Pursuit Through Ithilien",
      blurb: "Easterlings pursue Cirion after the fall of Amon Barad.",
      date_age: 3,
      date_year: 2998,
      is_canonical: true,
      size: 28
    }
  end
end

SbgInv.Data.generate
