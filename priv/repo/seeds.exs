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
    # SHADOW & FLAME
    #########################################################################

    #========================================================================
    saf_s1 = Repo.insert! %Scenario {
      name: "The Eastgate",
      blurb: "Balin's dwarves assault the east gate of Moria.",
      date_age: 3, date_year: 2989, is_canonical: true, size: 43
    }

    Repo.insert! %ScenarioResource { scenario_id: saf_s1.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 1, page: 14 }

    Repo.insert! %ScenarioFaction { scenario_id: saf_s1.id, faction: :dwarves, suggested_points: 200, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: saf_s1.id, faction: :moria,   suggested_points: 200, actual_points: 0, sort_order: 2 }

    #========================================================================
    saf_s2 = Repo.insert! %Scenario {
      name: "Battle for the Dwarrowdelf",
      blurb: "Balin faces off against Durbûrz deep within Moria.",
      date_age: 3, date_year: 2990, is_canonical: true, size: 77
    }

    Repo.insert! %ScenarioResource { scenario_id: saf_s2.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 2, page: 20 }

    Repo.insert! %ScenarioFaction { scenario_id: saf_s2.id, faction: :dwarves, suggested_points: 600, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: saf_s2.id, faction: :moria,   suggested_points: 600, actual_points: 0, sort_order: 2 }

    #========================================================================
    saf_s3 = Repo.insert! %Scenario {
      name: "Mirrormere",
      blurb: "The Goblins ambush Balin as he gazes into the waters of the Kheled-zâram.",
      date_age: 3, date_year: 2993, is_canonical: true, size: 51
    }

    Repo.insert! %ScenarioResource { scenario_id: saf_s3.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 3, page: 24 }

    Repo.insert! %ScenarioFaction { scenario_id: saf_s3.id, faction: :dwarves, suggested_points: 300, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: saf_s3.id, faction: :moria,   suggested_points: 300, actual_points: 0, sort_order: 2 }

    #========================================================================
    saf_s4 = Repo.insert! %Scenario {
      name: "They Are Coming",
      blurb: "The last dwarves in Moria face the Balrog.",
      date_age: 3, date_year: 2994, is_canonical: true, size: 55
    }

    Repo.insert! %ScenarioResource { scenario_id: saf_s4.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 4, page: 28 }

    Repo.insert! %ScenarioFaction { scenario_id: saf_s4.id, faction: :dwarves, suggested_points: 500, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: saf_s4.id, faction: :moria,   suggested_points: 500, actual_points: 0, sort_order: 2 }

    #========================================================================
    saf_s5 = Repo.insert! %Scenario {
      name: "Fog on the Barrow Downs",
      blurb: "Frodo and friends are attacked by the Barrow Wights.",
      date_age: 3, date_year: 3018, is_canonical: true, size: 9   # Sep 28
    }

    Repo.insert! %ScenarioResource { scenario_id: saf_s5.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 5, page: 36 }

    Repo.insert! %ScenarioFaction { scenario_id: saf_s5.id, faction: :fellowship, suggested_points: 200, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: saf_s5.id, faction: :angmar,     suggested_points: 200, actual_points: 0, sort_order: 2 }

    #========================================================================
    saf_s6 = Repo.insert! %Scenario {
      name: "Surrounded!",
      blurb: "Elves under Glorfindel are surrounded by Orcs on one side and Goblins on the other.",
      date_age: 3, date_year: 2925, is_canonical: true, size: 101
    }

    Repo.insert! %ScenarioResource { scenario_id: saf_s6.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 6, page: 42 }

    Repo.insert! %ScenarioFaction { scenario_id: saf_s6.id, faction: :rivendell, suggested_points: 650, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: saf_s6.id, faction: :angmar,    suggested_points: 700, actual_points: 0, sort_order: 2 }

    #========================================================================
    saf_s7 = Repo.insert! %Scenario {
      name: "Fangorn",
      blurb: "The Rohirrim, chasing down an Orcish raiding party, get some unexpected help.",
      date_age: 3, date_year: 3016, is_canonical: true, size: 53
    }

    Repo.insert! %ScenarioResource { scenario_id: saf_s7.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 7, page: 46 }

    Repo.insert! %ScenarioFaction { scenario_id: saf_s7.id, faction: :rohan,    suggested_points: 500, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: saf_s7.id, faction: :isengard, suggested_points: 500, actual_points: 0, sort_order: 2 }

    #########################################################################
    # SIEGE OF GONDOR
    #########################################################################

    #========================================================================
    sog_s1 = Repo.insert! %Scenario {
      name: "Osgiliath",
      blurb: "Boromir and Faramir defend Osgiliath against the initial assault from Mordor.",
      date_age: 3, date_year: 3018, is_canonical: true, size: 105  # Sep 20
    }

    Repo.insert! %ScenarioResource { scenario_id: sog_s1.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 1, page: 18 }

    Repo.insert! %ScenarioFaction { scenario_id: sog_s1.id, faction: :gondor, suggested_points: 800, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: sog_s1.id, faction: :mordor, suggested_points: 800, actual_points: 0, sort_order: 2 }

    #========================================================================
    sog_s2 = Repo.insert! %Scenario {
      name: "First Assault on Cair Andros",
      blurb: "Faramir defends the Anduin crossing north of Osgiliath.",
      date_age: 3, date_year: 3019, is_canonical: true, size: 100  # Mar 10
    }

    Repo.insert! %ScenarioResource { scenario_id: sog_s2.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 2, page: 32 }

    Repo.insert! %ScenarioFaction { scenario_id: sog_s2.id, faction: :gondor, suggested_points: 250, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: sog_s2.id, faction: :mordor, suggested_points: 750, actual_points: 0, sort_order: 2 }

    #========================================================================
    sog_s3 = Repo.insert! %Scenario {
      name: "Second Assault on Cair Andros",
      blurb: "Gothmog leads another assault on Cair Andros.",
      date_age: 3, date_year: 3019, is_canonical: true, size: 69  # Mar 11?
    }

    Repo.insert! %ScenarioResource { scenario_id: sog_s3.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 3, page: 40 }

    Repo.insert! %ScenarioFaction { scenario_id: sog_s3.id, faction: :gondor, suggested_points: 150, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: sog_s3.id, faction: :mordor, suggested_points: 600, actual_points: 0, sort_order: 2 }

    #========================================================================
    sog_s4 = Repo.insert! %Scenario {
      name: "The Rammas",
      blurb: "Gothmog pursues Faramir out of Osgiliath to the edge of the Pelennor Fields.",
      date_age: 3, date_year: 3019, is_canonical: true, size: 87  # Mar 12
    }

    Repo.insert! %ScenarioResource { scenario_id: sog_s4.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 4, page: 46 }

    Repo.insert! %ScenarioFaction { scenario_id: sog_s4.id, faction: :gondor, suggested_points: 500, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: sog_s4.id, faction: :mordor, suggested_points: 500, actual_points: 0, sort_order: 2 }

    #========================================================================
    sog_s5 = Repo.insert! %Scenario {
      name: "The Siege of Minas Tirith",
      blurb: "Gandalf the White defends the walls of Minas Tirith from the forces of Mordor under Gothmog.",
      date_age: 3, date_year: 3019, is_canonical: true, size: 112  # Mar 14
    }

    Repo.insert! %ScenarioResource { scenario_id: sog_s5.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 5, page: 48 }

    Repo.insert! %ScenarioFaction { scenario_id: sog_s5.id, faction: :gondor, suggested_points:  750, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: sog_s5.id, faction: :mordor, suggested_points: 1000, actual_points: 0, sort_order: 2 }

    #========================================================================
    sog_s6 = Repo.insert! %Scenario {
      name: "The Pyre of Denethor",
      blurb: "Gandalf the White rescues Faramir from the insanity of Denethor.",
      date_age: 3, date_year: 3019, is_canonical: true, size: 84  # Mar 15
    }

    Repo.insert! %ScenarioResource { scenario_id: sog_s6.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 5, page: 52 }

    Repo.insert! %ScenarioFaction { scenario_id: sog_s6.id, faction: :gondor, suggested_points:  750, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: sog_s6.id, faction: :mordor, suggested_points: 1000, actual_points: 0, sort_order: 2 }

    #========================================================================
    sog_s7 = Repo.insert! %Scenario {
      name: "The Defenses Must Hold!",
      blurb: "Theoden and friends hold out at Helm's Deep.",
      date_age: 3, date_year: 3019, is_canonical: true, size: 109  # Mar 3
    }

    Repo.insert! %ScenarioResource { scenario_id: sog_s7.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 6, page: 58 }

    Repo.insert! %ScenarioFaction { scenario_id: sog_s7.id, faction: :gondor, suggested_points: 250, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: sog_s7.id, faction: :mordor, suggested_points: 375, actual_points: 0, sort_order: 2 }

    #========================================================================
    sog_s8 = Repo.insert! %Scenario {
      name: "Forth Eorlingas!",
      blurb: "Theoden leads a mounted charge out from Helm's Deep.",
      date_age: 3, date_year: 3019, is_canonical: true, size: 105  # Mar 4
    }

    Repo.insert! %ScenarioResource { scenario_id: sog_s8.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 7, page: 62 }

    Repo.insert! %ScenarioFaction { scenario_id: sog_s8.id, faction: :gondor, suggested_points: 800, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: sog_s8.id, faction: :mordor, suggested_points: 800, actual_points: 0, sort_order: 2 }

    #########################################################################
    # A SHADOW IN THE EAST
    #########################################################################

    #========================================================================
    site_s1 = Repo.insert! %Scenario {
      name: "The Fall of Amon Barad",
      blurb: "Easterlings under Khamûl launch a surprise attack on a Gondorian outpost in Ithilien.",
      date_age: 3, date_year: 2998, is_canonical: true, size: 30
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s1.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 1, page: 14 }
    Repo.insert! %ScenarioResource { scenario_id: site_s1.id, resource_type: :web_replay, url: "http://www.davetownsend.org/Battles/LotR-20160604/", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s1.id, faction: :gondor, suggested_points: 200, actual_points: 203, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: site_s1.id, faction: :easterlings, suggested_points: 200, actual_points: 220, sort_order: 2 }

    #========================================================================
    site_s2 = Repo.insert! %Scenario {
      name: "Pursuit Through Ithilien",
      blurb: "Easterlings pursue Cirion after the fall of Amon Barad.",
      date_age: 3, date_year: 2998, is_canonical: true, size: 28
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s2.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 2, page: 16 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s2.id, faction: :gondor, suggested_points: 275, actual_points: 279, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: site_s2.id, faction: :easterlings, suggested_points: 225, actual_points: 197, sort_order: 2 }

    #========================================================================
    site_s3 = Repo.insert! %Scenario {
      name: "Gathering Information",
      blurb: "Cirion's forces try to capture a Khandish leader from a fort.",
      date_age: 3, date_year: 2998, is_canonical: true, size: 47
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s3.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 3, page: 28 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s3.id, faction: :gondor, suggested_points: 350, actual_points: 329, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: site_s3.id, faction: :easterlings, suggested_points: 350, actual_points: 420, sort_order: 2 }

    #========================================================================
    site_s4 = Repo.insert! %Scenario {
      name: "Turning the Tide",
      blurb: "Cirion surprise attacks an Easterling camp at night.",
      date_age: 3, date_year: 2998, is_canonical: true, size: 121
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s4.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 4, page: 30 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s4.id, faction: :gondor, suggested_points: 900, actual_points: 849, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: site_s4.id, faction: :easterlings, suggested_points: 600, actual_points: 813, sort_order: 2 }

    #========================================================================
    site_s5 = Repo.insert! %Scenario {
      name: "Reprisals",
      blurb: "Dáin Ironfoot leads a dwarven raid against the Easterlings.",
      date_age: 3, date_year: 3001, is_canonical: true, size: 71
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s5.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 5, page: 36 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s5.id, faction: :dwarves, suggested_points: 500, actual_points: 460, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: site_s5.id, faction: :easterlings, suggested_points: 550, actual_points: 511, sort_order: 2 }

    #========================================================================
    site_s6 = Repo.insert! %Scenario {
      name: "Strange Circumstances",
      blurb: "Cirion joins his Khandish captors to fight off an Orc raid.",
      date_age: 3, date_year: 3002, is_canonical: true, size: 101
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s6.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 6, page: 38 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s6.id, faction: :easterlings, suggested_points: 500, actual_points: 700, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: site_s6.id, faction: :mordor, suggested_points: 750, actual_points: 796, sort_order: 2 }

    #========================================================================
    site_s7 = Repo.insert! %Scenario {
      name: "The Field of Celebrant",
      blurb: "Eorl the Young saves Gondor from the Khandish and their Orc allies.",
      date_age: 3, date_year: 2510, is_canonical: true, size: 107
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s7.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 7, page: 40 }

    Repo.insert! %ScenarioFaction { scenario_id: site_s7.id, faction: :rohan, suggested_points: 650, actual_points: 635, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: site_s7.id, faction: :easterlings, suggested_points: 800, actual_points: 949, sort_order: 2 }

    #========================================================================
    site_s8 = Repo.insert! %Scenario {
      name: "Hunter & Hunted",
      blurb: "Easterling raiders under Khamûl encounter the defenders of Fangorn.",
      date_age: 3, date_year: 2520, is_canonical: true, size: 28
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s8.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 8, page: 46 }

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

    Repo.insert! %ScenarioResource { scenario_id: fotn_s1.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 1, page: 8 }
    Repo.insert! %ScenarioResource { scenario_id: fotn_s1.id, resource_type: 1, url: "https://www.youtube.com/watch?v=0_dCdLngsKs&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s1.id, faction: :mirkwood, suggested_points: 200, actual_points: 273, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: fotn_s1.id, faction: :dol_guldur, suggested_points: 200, actual_points: 150, sort_order: 2 }

    #========================================================================
    fotn_s2 = Repo.insert! %Scenario {
      name: "In the Nick of Time",
      blurb: "Elrond joins Thranduil against an attack from Dol Guldur lead by Khamûl.",
      date_age: 3,  date_year: 2061, is_canonical: true, size: 65
    }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s2.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 2, page: 10 }
    Repo.insert! %ScenarioResource { scenario_id: fotn_s2.id, resource_type: 1, url: "https://www.youtube.com/watch?v=AMrP8abPj0Q&index=2&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s2.id, faction: :mirkwood, suggested_points: 600, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: fotn_s2.id, faction: :dol_guldur, suggested_points: 600, actual_points: 0, sort_order: 2 }

    #========================================================================
    fotn_s3 = Repo.insert! %Scenario {
      name: "A Walk Through Dark Places",
      blurb: "A Rivendell band tries to protect Arwen and Círdan from the minions of Dol Guldur.",
      date_age: 3, date_year: 2062, is_canonical: true, size: 23
    }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s3.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 3, page: 12 }
    Repo.insert! %ScenarioResource { scenario_id: fotn_s3.id, resource_type: 1, url: "https://www.youtube.com/watch?v=YN8X_azJfO8&index=3&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s3.id, faction: :rivendell, suggested_points: 550, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: fotn_s3.id, faction: :dol_guldur, suggested_points: 300, actual_points: 0, sort_order: 2 }

    #========================================================================
    fotn_s4 = Repo.insert! %Scenario {
      name: "Meddle Not in the Affairs of Wizards",
      blurb: "The Istari faces the minions of Dol Guldur.",
      date_age: 3, date_year: 2062, is_canonical: true, size: 17
    }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s4.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 4, page: 14 }
    Repo.insert! %ScenarioResource { scenario_id: fotn_s4.id, resource_type: 1, url: "https://www.youtube.com/watch?v=UbIM0XE6jT8&index=4&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s4.id, faction: :white_council, suggested_points: 500, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: fotn_s4.id, faction: :dol_guldur,     suggested_points: 400, actual_points: 0, sort_order: 2 }

    #========================================================================
    fotn_s5 = Repo.insert! %Scenario {
      name: "The Lair of the Spider Queen",
      blurb: "Lothlorien attacks the beasts of Mirkwood",
      date_age: 3, date_year: 2063, is_canonical: true, size: 41
    }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s5.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 5, page: 16 }
    Repo.insert! %ScenarioResource { scenario_id: fotn_s5.id, resource_type: :video_replay, url: "https://www.youtube.com/watch?v=eyHTP-Vjhd8&index=5&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s5.id, faction: :lothlorien, suggested_points: 450, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: fotn_s5.id, faction: :dol_guldur, suggested_points: 300, actual_points: 0, sort_order: 2 }

    #========================================================================
    fotn_s6 = Repo.insert! %Scenario {
      name: "In the Shadow of Dol Guldur",
      blurb: "Elrond's elves fight a Ringwraith-led Dol Guldur army.",
      date_age: 3, date_year: 2850, is_canonical: true, size: 91
    }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s6.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 6, page: 18 }
    Repo.insert! %ScenarioResource { scenario_id: fotn_s6.id, resource_type: :video_replay, url: "https://www.youtube.com/watch?v=Cug7stLutRQ&index=6&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s6.id, faction: :rivendell,  suggested_points: 700, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: fotn_s6.id, faction: :dol_guldur, suggested_points: 800, actual_points: 0, sort_order: 2 }

    #========================================================================
    fotn_s7 = Repo.insert! %Scenario {
      name: "The Fall of the Necromancer",
      blurb: "The White Council battles the Necromancer himself at Dol Guldur.",
      date_age: 3, date_year: 2851, is_canonical: true, size: 29
    }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s7.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 7, page: 20 }
    Repo.insert! %ScenarioResource { scenario_id: fotn_s7.id, resource_type: :video_replay, url: "https://www.youtube.com/watch?v=2J5px0_J2wQ&index=7&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s7.id, faction: :rivendell,  suggested_points: 1500, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: fotn_s7.id, faction: :dol_guldur, suggested_points: 1400, actual_points: 0, sort_order: 2 }
  end
end

SbgInv.Data.generate
