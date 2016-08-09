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
  alias SbgInv.Figure
  alias SbgInv.Scenario
  alias SbgInv.ScenarioFaction
  alias SbgInv.ScenarioFactionFigure
  alias SbgInv.ScenarioResource
  alias SbgInv.UserFigure

  def generate do
    _generate
  end

  defp _generate do
    IO.puts "Generating data"

    #########################################################################
    # FIGURES: DWARVES
    #########################################################################

    dain  = Repo.insert! %Figure { name: "Dáin Ironfoot" }
    drar  = Repo.insert! %Figure { name: "Drar" }
    murin = Repo.insert! %Figure { name: "Murin" }

    dwarf_captain = Repo.insert! %Figure { name: "Dwarf Captain", plural_name: "Dwarf Captains" }

    dwarf_khazad_gd = Repo.insert! %Figure { name: "Khazad Guard",              plural_name: "Khazad Guards" }
    dwarf_w_bow     = Repo.insert! %Figure { name: "Dwarf with Dwarf bow",      plural_name: "Dwarves with Dwarf bow" }
    dwarf_w_shield  = Repo.insert! %Figure { name: "Dwarf with shield",         plural_name: "Dwarves with shield" }
    dwarf_w_axe     = Repo.insert! %Figure { name: "Dwarf with two-handed axe", plural_name: "Dwarves with two-handed axe" }
    dwarf_w_banner  = Repo.insert! %Figure { name: "Dwarf with banner",         plural_name: "Dwarves with banner" }

    #########################################################################
    # FIGURES: EASTERLINGS
    #########################################################################

    khamul       = Repo.insert! %Figure { name: "Khamûl the Easterling" }
    khamul_horse = Repo.insert! %Figure { name: "Khamûl the Easterling on horseback" }

    easterling_captain       = Repo.insert! %Figure { name: "Easterling Captain",           plural_name: "Easterling Captains" }
    khandish_chieftain       = Repo.insert! %Figure { name: "Khandish Chieftain",           plural_name: "Khandish Chieftains" }
    khandish_chieftain_horse = Repo.insert! %Figure { name: "Khandish Chieftain on horse",  plural_name: "Khandish Chieftains on horse" }
    khandish_king_chariot    = Repo.insert! %Figure { name: "Khandish King in chariot",     plural_name: "Khandish Kings in chariot" }
    khandish_merc_chieftain  = Repo.insert! %Figure { name: "Khandish Mercenary Chieftain", plural_name: "Khandish Mercenary Chieftains" }

    easterling_w_shield        = Repo.insert! %Figure { name: "Easterling Warrior with shield",           plural_name: "Easterling Warriors with shield" }
    easterling_w_bow           = Repo.insert! %Figure { name: "Easterling Warrior with bow",              plural_name: "Easterling Warriors with bow" }
    easterling_w_shield_spear  = Repo.insert! %Figure { name: "Easterling Warrior with shield and spear", plural_name: "Easterling Warriors with shield and spear" }
    easterling_w_banner        = Repo.insert! %Figure { name: "Easterling Warrior with banner",           plural_name: "Easterling Warriors with banner" }
    easterling_kataphrakt      = Repo.insert! %Figure { name: "Easterling Kataphrakt",                    plural_name: "Easterling Kataphrakts" }
    khandish_charioteer        = Repo.insert! %Figure { name: "Khandish Charioteer with bow",             plural_name: "Khandish Charioteers with bow" }
    khandish_merc_bow          = Repo.insert! %Figure { name: "Khandish Mercenary with bow",              plural_name: "Khandish Mercenaries with bow" }
    khandish_merc_axe          = Repo.insert! %Figure { name: "Khandish Mercenary with two-handed axe",   plural_name: "Khandish Mercenaries with two-handed axe" }
    khandish_w_bow             = Repo.insert! %Figure { name: "Khandish Warrior with bow",                plural_name: "Khandish Warriors with bow" }
    khandish_w_axe             = Repo.insert! %Figure { name: "Khandish Warrior with two-handed axe",     plural_name: "Khandish Warriors with two-handed axe" }
    khandish_horseman          = Repo.insert! %Figure { name: "Khandish Horseman",                        plural_name: "Khandish Horsemen" }

    #########################################################################
    # FIGURES: FREE PEOPLES
    #########################################################################

    treebeard = Repo.insert! %Figure { name: "Treebeard" }
    gwaihir   = Repo.insert! %Figure { name: "Gwaihir" }

    eagle = Repo.insert! %Figure { name: "Giant Eagle", plural_name: "Giant Eagles" }

    #########################################################################
    # FIGURES: GONDOR
    #########################################################################

    cirion                   = Repo.insert! %Figure { name: "Cirion" }
    faramir                  = Repo.insert! %Figure { name: "Faramir" }
    madril                   = Repo.insert! %Figure { name: "Madril" }

    gondor_captain_mt        = Repo.insert! %Figure { name: "Captain of Minas Tirith", plural_name: "Captains of Minas Tirith" }

    gondor_citadel_gd_spear  = Repo.insert! %Figure { name: "Citadel Guard with spear",                      plural_name: "Citadel Guards with spear" }
    gondor_citadel_gd_bow    = Repo.insert! %Figure { name: "Citadel Guard with longbow",                    plural_name: "Citadel Guards with longbow" }
    gondor_rog               = Repo.insert! %Figure { name: "Ranger of Gondor",                              plural_name: "Rangers of Gondor" }
    gondor_womt_banner       = Repo.insert! %Figure { name: "Warrior of Minas Tirith with banner",           plural_name: "Warriors of Minas Tirith with banner" }
    gondor_womt_bow          = Repo.insert! %Figure { name: "Warrior of Minas Tirith with bow",              plural_name: "Warriors of Minas Tirith with bow" }
    gondor_womt_shield       = Repo.insert! %Figure { name: "Warrior of Minas Tirith with shield",           plural_name: "Warriors of Minas Tirith with shield" }
    gondor_womt_spear_shield = Repo.insert! %Figure { name: "Warrior of Minas Tirith with spear and shield", plural_name: "Warriors of Minas Tirith with spear and shield" }

    #########################################################################
    # FIGURES: MORDOR
    #########################################################################

    orc_captain      = Repo.insert! %Figure { name: "Orc Captain",         plural_name: "Orc Captains" }
    orc_captain_warg = Repo.insert! %Figure { name: "Orc Captain on Warg", plural_name: "Orc Captains on Warg" }

    orc_w_banner      = Repo.insert! %Figure { name: "Orc with banner",            plural_name: "Orcs with banner" }
    orc_w_bow         = Repo.insert! %Figure { name: "Orc with Orc bow",           plural_name: "Orcs with Orc bow" }
    orc_w_shield      = Repo.insert! %Figure { name: "Orc with shield",            plural_name: "Orcs with shield" }
    orc_w_spear       = Repo.insert! %Figure { name: "Orc with spear",             plural_name: "Orcs with spear" }
    orc_w_2h          = Repo.insert! %Figure { name: "Orc with two-handed weapon", plural_name: "Orcs with two-handed weapon" }
    warg_rider_bow    = Repo.insert! %Figure { name: "Warg Rider with bow",        plural_name: "Warg Riders with bow" }
    warg_rider_shield = Repo.insert! %Figure { name: "Warg Rider with shield",     plural_name: "Warg Riders with shield" }
    warg_rider_spear  = Repo.insert! %Figure { name: "Warg Rider with spear",      plural_name: "Warg Riders with spear" }

    war_catapult       = Repo.insert! %Figure { name: "War Catapult",       plural_name: "War Catapults" }
    war_catapult_troll = Repo.insert! %Figure { name: "War Catapult Troll", plural_name: "War Catapult Trolls" }

    #########################################################################
    # FIGURES: ROHAN
    #########################################################################

    eorl_horse = Repo.insert! %Figure { name: "Eorl the Young on horse" }

    rohan_captain_horse = Repo.insert! %Figure { name: "Captain of Rohan on horse", plural_name: "Captains of Rohan on horse" }

    rohan_gd_horse_spear  = Repo.insert! %Figure { name: "Rohan Royal Guard with throwing spear on horse", plural_name: "Rohan Royal Guards with throwing spear on horse" }
    rohan_gd_horse_banner = Repo.insert! %Figure { name: "Rohan Royal Guard with banner",                  plural_name: "Rohan Royal Guards with banner" }
    rohan_rider           = Repo.insert! %Figure { name: "Rider of Rohan",                                 plural_name: "Riders of Rohan" }
    rohan_rider_spear     = Repo.insert! %Figure { name: "Rider of Rohan with throwing spear",             plural_name: "Riders of Rohan with throwing spear" }

    #########################################################################
    # USER_FIGURES
    #########################################################################
    Repo.insert! %UserFigure { user_id: 1, figure_id: murin.id,           owned:  1, painted:  1 }
    Repo.insert! %UserFigure { user_id: 1, figure_id: gondor_womt_bow.id, owned: 36, painted: 24 }
    Repo.insert! %UserFigure { user_id: 1, figure_id: khandish_w_bow.id,  owned:  6, painted:  0 }

    #########################################################################
    # SHADOW & FLAME
    #########################################################################

    #========================================================================
    saf_s1 = Repo.insert! %Scenario {
      name: "The Eastgate",
      blurb: "Balin's dwarves assault the east gate of Moria.",
      date_age: 3, date_year: 2989, date_month: 0, date_day: 0, is_canonical: true, size: 43
    }

    Repo.insert! %ScenarioResource { scenario_id: saf_s1.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 1, page: 14 }

    Repo.insert! %ScenarioFaction { scenario_id: saf_s1.id, faction: :dwarves, suggested_points: 200, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: saf_s1.id, faction: :moria,   suggested_points: 200, actual_points: 0, sort_order: 2 }

    #========================================================================
    saf_s2 = Repo.insert! %Scenario {
      name: "Battle for the Dwarrowdelf",
      blurb: "Balin faces off against Durbûrz deep within Moria.",
      date_age: 3, date_year: 2990, date_month: 0, date_day: 0, is_canonical: true, size: 77
    }

    Repo.insert! %ScenarioResource { scenario_id: saf_s2.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 2, page: 20 }

    Repo.insert! %ScenarioFaction { scenario_id: saf_s2.id, faction: :dwarves, suggested_points: 600, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: saf_s2.id, faction: :moria,   suggested_points: 600, actual_points: 0, sort_order: 2 }

    #========================================================================
    saf_s3 = Repo.insert! %Scenario {
      name: "Mirrormere",
      blurb: "The Goblins ambush Balin as he gazes into the waters of the Kheled-zâram.",
      date_age: 3, date_year: 2993, date_month: 0, date_day: 0, is_canonical: true, size: 51
    }

    Repo.insert! %ScenarioResource { scenario_id: saf_s3.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 3, page: 24 }

    Repo.insert! %ScenarioFaction { scenario_id: saf_s3.id, faction: :dwarves, suggested_points: 300, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: saf_s3.id, faction: :moria,   suggested_points: 300, actual_points: 0, sort_order: 2 }

    #========================================================================
    saf_s4 = Repo.insert! %Scenario {
      name: "They Are Coming",
      blurb: "The last dwarves in Moria face the Balrog.",
      date_age: 3, date_year: 2994, date_month: 0, date_day: 0, is_canonical: true, size: 55
    }

    Repo.insert! %ScenarioResource { scenario_id: saf_s4.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 4, page: 28 }

    Repo.insert! %ScenarioFaction { scenario_id: saf_s4.id, faction: :dwarves, suggested_points: 500, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: saf_s4.id, faction: :moria,   suggested_points: 500, actual_points: 0, sort_order: 2 }

    #========================================================================
    saf_s5 = Repo.insert! %Scenario {
      name: "Fog on the Barrow Downs",
      blurb: "Frodo and friends are attacked by the Barrow Wights.",
      date_age: 3, date_year: 3018, date_month: 9, date_day: 28, is_canonical: true, size: 9
    }

    Repo.insert! %ScenarioResource { scenario_id: saf_s5.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 5, page: 36 }

    Repo.insert! %ScenarioFaction { scenario_id: saf_s5.id, faction: :fellowship, suggested_points: 200, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: saf_s5.id, faction: :angmar,     suggested_points: 200, actual_points: 0, sort_order: 2 }

    #========================================================================
    saf_s6 = Repo.insert! %Scenario {
      name: "Surrounded!",
      blurb: "Elves under Glorfindel are surrounded by Orcs on one side and Goblins on the other.",
      date_age: 3, date_year: 2925, date_month: 0, date_day: 0, is_canonical: true, size: 101
    }

    Repo.insert! %ScenarioResource { scenario_id: saf_s6.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 6, page: 42 }

    Repo.insert! %ScenarioFaction { scenario_id: saf_s6.id, faction: :rivendell, suggested_points: 650, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: saf_s6.id, faction: :angmar,    suggested_points: 700, actual_points: 0, sort_order: 2 }

    #========================================================================
    saf_s7 = Repo.insert! %Scenario {
      name: "Fangorn",
      blurb: "The Rohirrim, chasing down an Orcish raiding party, get some unexpected help.",
      date_age: 3, date_year: 3016, date_month: 0, date_day: 0, is_canonical: true, size: 53
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
      date_age: 3, date_year: 3018, date_month: 9, date_day: 20, is_canonical: true, size: 105
    }

    Repo.insert! %ScenarioResource { scenario_id: sog_s1.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 1, page: 18 }

    Repo.insert! %ScenarioFaction { scenario_id: sog_s1.id, faction: :gondor, suggested_points: 800, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: sog_s1.id, faction: :mordor, suggested_points: 800, actual_points: 0, sort_order: 2 }

    #========================================================================
    sog_s2 = Repo.insert! %Scenario {
      name: "First Assault on Cair Andros",
      blurb: "Faramir defends the Anduin crossing north of Osgiliath.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 10, is_canonical: true, size: 100
    }

    Repo.insert! %ScenarioResource { scenario_id: sog_s2.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 2, page: 32 }

    Repo.insert! %ScenarioFaction { scenario_id: sog_s2.id, faction: :gondor, suggested_points: 250, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: sog_s2.id, faction: :mordor, suggested_points: 750, actual_points: 0, sort_order: 2 }

    #========================================================================
    sog_s3 = Repo.insert! %Scenario {
      name: "Second Assault on Cair Andros",
      blurb: "Gothmog leads another assault on Cair Andros.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 11, is_canonical: true, size: 69
    }

    Repo.insert! %ScenarioResource { scenario_id: sog_s3.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 3, page: 40 }

    Repo.insert! %ScenarioFaction { scenario_id: sog_s3.id, faction: :gondor, suggested_points: 150, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: sog_s3.id, faction: :mordor, suggested_points: 600, actual_points: 0, sort_order: 2 }

    #========================================================================
    sog_s4 = Repo.insert! %Scenario {
      name: "The Rammas",
      blurb: "Gothmog pursues Faramir out of Osgiliath to the edge of the Pelennor Fields.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 12, is_canonical: true, size: 87
    }

    Repo.insert! %ScenarioResource { scenario_id: sog_s4.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 4, page: 46 }

    Repo.insert! %ScenarioFaction { scenario_id: sog_s4.id, faction: :gondor, suggested_points: 500, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: sog_s4.id, faction: :mordor, suggested_points: 500, actual_points: 0, sort_order: 2 }

    #========================================================================
    sog_s5 = Repo.insert! %Scenario {
      name: "The Siege of Minas Tirith",
      blurb: "Gandalf the White defends the walls of Minas Tirith from the forces of Mordor under Gothmog.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 14, is_canonical: true, size: 112
    }

    Repo.insert! %ScenarioResource { scenario_id: sog_s5.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 5, page: 48 }

    Repo.insert! %ScenarioFaction { scenario_id: sog_s5.id, faction: :gondor, suggested_points:  750, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: sog_s5.id, faction: :mordor, suggested_points: 1000, actual_points: 0, sort_order: 2 }

    #========================================================================
    sog_s6 = Repo.insert! %Scenario {
      name: "The Pyre of Denethor",
      blurb: "Gandalf the White rescues Faramir from the insanity of Denethor.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, is_canonical: true, size: 84
    }

    Repo.insert! %ScenarioResource { scenario_id: sog_s6.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 5, page: 52 }

    Repo.insert! %ScenarioFaction { scenario_id: sog_s6.id, faction: :gondor, suggested_points:  750, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: sog_s6.id, faction: :mordor, suggested_points: 1000, actual_points: 0, sort_order: 2 }

    #========================================================================
    sog_s7 = Repo.insert! %Scenario {
      name: "The Defenses Must Hold!",
      blurb: "Theoden and friends hold out at Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, is_canonical: true, size: 109
    }

    Repo.insert! %ScenarioResource { scenario_id: sog_s7.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 6, page: 58 }

    Repo.insert! %ScenarioFaction { scenario_id: sog_s7.id, faction: :gondor, suggested_points: 250, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: sog_s7.id, faction: :mordor, suggested_points: 375, actual_points: 0, sort_order: 2 }

    #========================================================================
    sog_s8 = Repo.insert! %Scenario {
      name: "Forth Eorlingas!",
      blurb: "Theoden leads a mounted charge out from Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 4, is_canonical: true, size: 105
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
      date_age: 3, date_year: 2998, date_month: 0, date_day: 0, is_canonical: true, size: 30
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s1.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 1, page: 14 }
    Repo.insert! %ScenarioResource { scenario_id: site_s1.id, resource_type: :web_replay, title: "Dave T", url: "http://www.davetownsend.org/Battles/LotR-20160604/", sort_order: 1 }

    site_s1f1 = Repo.insert! %ScenarioFaction { scenario_id: site_s1.id, faction: :gondor, suggested_points: 200, actual_points: 203, sort_order: 1 }

    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s1f1.id, amount: 1, sort_order: 1, figure_id: cirion.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s1f1.id, amount: 4, sort_order: 2, figure_id: gondor_womt_spear_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s1f1.id, amount: 4, sort_order: 3, figure_id: gondor_womt_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s1f1.id, amount: 4, sort_order: 4, figure_id: gondor_womt_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s1f1.id, amount: 6, sort_order: 5, figure_id: gondor_rog.id }

    site_s1f2 = Repo.insert! %ScenarioFaction { scenario_id: site_s1.id, faction: :easterlings, suggested_points: 200, actual_points: 220, sort_order: 2 }

    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s1f2.id, amount: 1, sort_order: 1, figure_id: khamul.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s1f2.id, amount: 4, sort_order: 2, figure_id: easterling_w_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s1f2.id, amount: 4, sort_order: 3, figure_id: easterling_w_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s1f2.id, amount: 2, sort_order: 4, figure_id: easterling_w_shield_spear.id }

    #========================================================================
    site_s2 = Repo.insert! %Scenario {
      name: "Pursuit Through Ithilien",
      blurb: "Easterlings pursue Cirion after the fall of Amon Barad.",
      date_age: 3, date_year: 2998, date_month: 0, date_day: 0, is_canonical: true, size: 28
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s2.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 2, page: 16 }
    Repo.insert! %ScenarioResource { scenario_id: site_s2.id, resource_type: :web_replay, title: "Dave T", url: "http://davetownsend.org/Battles/LotR-20160727/", sort_order: 1 }

    site_s2f1 = Repo.insert! %ScenarioFaction { scenario_id: site_s2.id, faction: :gondor, suggested_points: 275, actual_points: 279, sort_order: 1 }

    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s2f1.id, amount: 1, sort_order: 1, figure_id: cirion.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s2f1.id, amount: 1, sort_order: 2, figure_id: murin.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s2f1.id, amount: 1, sort_order: 3, figure_id: drar.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s2f1.id, amount: 2, sort_order: 4, figure_id: gondor_womt_spear_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s2f1.id, amount: 2, sort_order: 5, figure_id: gondor_womt_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s2f1.id, amount: 2, sort_order: 6, figure_id: gondor_womt_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s2f1.id, amount: 3, sort_order: 7, figure_id: gondor_rog.id }

    site_s2f2 = Repo.insert! %ScenarioFaction { scenario_id: site_s2.id, faction: :easterlings, suggested_points: 225, actual_points: 197, sort_order: 2 }

    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s2f2.id, amount: 1, sort_order: 1, figure_id: easterling_captain.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s2f2.id, amount: 4, sort_order: 2, figure_id: easterling_w_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s2f2.id, amount: 4, sort_order: 3, figure_id: easterling_w_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s2f2.id, amount: 2, sort_order: 4, figure_id: easterling_w_shield_spear.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s2f2.id, amount: 5, sort_order: 5, figure_id: easterling_kataphrakt.id }

    #========================================================================
    site_s3 = Repo.insert! %Scenario {
      name: "Gathering Information",
      blurb: "Cirion's forces try to capture a Khandish leader from a fort.",
      date_age: 3, date_year: 2998, date_month: 0, date_day: 0, is_canonical: true, size: 47
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s3.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 3, page: 28 }

    site_s3f1 = Repo.insert! %ScenarioFaction { scenario_id: site_s3.id, faction: :gondor, suggested_points: 350, actual_points: 329, sort_order: 1 }

    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s3f1.id, amount: 1, sort_order: 1, figure_id: cirion.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s3f1.id, amount: 1, sort_order: 2, figure_id: murin.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s3f1.id, amount: 1, sort_order: 3, figure_id: drar.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s3f1.id, amount: 4, sort_order: 4, figure_id: gondor_womt_spear_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s3f1.id, amount: 4, sort_order: 5, figure_id: gondor_womt_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s3f1.id, amount: 4, sort_order: 6, figure_id: gondor_womt_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s3f1.id, amount: 3, sort_order: 7, figure_id: gondor_rog.id }

    site_s3f2 = Repo.insert! %ScenarioFaction { scenario_id: site_s3.id, faction: :easterlings, suggested_points: 350, actual_points: 420, sort_order: 2 }

    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s3f2.id, amount: 2, sort_order: 1, figure_id: khandish_chieftain.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s3f2.id, amount: 4, sort_order: 2, figure_id: khandish_w_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s3f2.id, amount: 8, sort_order: 3, figure_id: khandish_w_axe.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s3f2.id, amount: 5, sort_order: 4, figure_id: khandish_horseman.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s3f2.id, amount: 3, sort_order: 5, figure_id: easterling_w_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s3f2.id, amount: 2, sort_order: 6, figure_id: easterling_w_shield_spear.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s3f2.id, amount: 4, sort_order: 7, figure_id: easterling_w_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s3f2.id, amount: 1, sort_order: 8, figure_id: easterling_w_banner.id }

    #========================================================================
    site_s4 = Repo.insert! %Scenario {
      name: "Turning the Tide",
      blurb: "Cirion surprise attacks an Easterling camp at night.",
      date_age: 3, date_year: 2998, date_month: 0, date_day: 0, is_canonical: true, size: 121
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s4.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 4, page: 30 }

    site_s4f1 = Repo.insert! %ScenarioFaction { scenario_id: site_s4.id, faction: :gondor, suggested_points: 900, actual_points: 849, sort_order: 1 }

    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f1.id, amount:  1, sort_order:  1, figure_id: cirion.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f1.id, amount:  1, sort_order:  2, figure_id: murin.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f1.id, amount:  1, sort_order:  3, figure_id: drar.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f1.id, amount:  1, sort_order:  4, figure_id: madril.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f1.id, amount:  1, sort_order:  5, figure_id: faramir.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f1.id, amount:  1, sort_order:  6, figure_id: gondor_captain_mt.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f1.id, amount:  3, sort_order:  7, figure_id: gondor_citadel_gd_spear.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f1.id, amount:  3, sort_order:  8, figure_id: gondor_citadel_gd_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f1.id, amount: 12, sort_order:  9, figure_id: gondor_womt_spear_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f1.id, amount: 11, sort_order: 10, figure_id: gondor_womt_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f1.id, amount: 12, sort_order: 11, figure_id: gondor_womt_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f1.id, amount:  1, sort_order: 12, figure_id: gondor_womt_banner.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f1.id, amount:  9, sort_order: 13, figure_id: gondor_rog.id }

    site_s4f2 = Repo.insert! %ScenarioFaction { scenario_id: site_s4.id, faction: :easterlings, suggested_points: 600, actual_points: 813, sort_order: 2 }

    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f2.id, amount:  1, sort_order:  1, figure_id: khamul.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f2.id, amount:  1, sort_order:  2, figure_id: easterling_captain.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f2.id, amount:  1, sort_order:  3, figure_id: khandish_chieftain.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f2.id, amount: 11, sort_order:  4, figure_id: easterling_w_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f2.id, amount: 12, sort_order:  5, figure_id: easterling_w_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f2.id, amount:  9, sort_order:  6, figure_id: easterling_w_shield_spear.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f2.id, amount:  1, sort_order:  7, figure_id: easterling_w_banner.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f2.id, amount: 12, sort_order:  8, figure_id: khandish_w_axe.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f2.id, amount:  6, sort_order:  9, figure_id: khandish_w_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f2.id, amount:  5, sort_order: 10, figure_id: khandish_horseman.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s4f2.id, amount:  5, sort_order: 11, figure_id: easterling_kataphrakt.id }

    #========================================================================
    site_s5 = Repo.insert! %Scenario {
      name: "Reprisals",
      blurb: "Dáin Ironfoot leads a dwarven raid against the Easterlings.",
      date_age: 3, date_year: 3001, date_month: 0, date_day: 0, is_canonical: true, size: 71
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s5.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 5, page: 36 }

    site_s5f1 = Repo.insert! %ScenarioFaction { scenario_id: site_s5.id, faction: :dwarves, suggested_points: 500, actual_points: 460, sort_order: 1 }

    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s5f1.id, amount:  1, sort_order: 1, figure_id: dain.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s5f1.id, amount:  1, sort_order: 2, figure_id: dwarf_captain.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s5f1.id, amount:  6, sort_order: 3, figure_id: dwarf_khazad_gd.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s5f1.id, amount:  9, sort_order: 4, figure_id: dwarf_w_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s5f1.id, amount:  7, sort_order: 5, figure_id: dwarf_w_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s5f1.id, amount:  4, sort_order: 6, figure_id: dwarf_w_axe.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s5f1.id, amount:  1, sort_order: 7, figure_id: dwarf_w_banner.id }

    site_s5f2 = Repo.insert! %ScenarioFaction { scenario_id: site_s5.id, faction: :easterlings, suggested_points: 550, actual_points: 511, sort_order: 2 }

    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s5f2.id, amount:  2, sort_order: 1, figure_id: easterling_captain.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s5f2.id, amount: 11, sort_order: 2, figure_id: easterling_w_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s5f2.id, amount: 12, sort_order: 3, figure_id: easterling_w_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s5f2.id, amount:  6, sort_order: 4, figure_id: easterling_w_shield_spear.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s5f2.id, amount:  1, sort_order: 6, figure_id: easterling_w_banner.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s5f2.id, amount: 10, sort_order: 5, figure_id: easterling_kataphrakt.id }

    #========================================================================
    site_s6 = Repo.insert! %Scenario {
      name: "Strange Circumstances",
      blurb: "Cirion joins his Khandish captors to fight off an Orc raid.",
      date_age: 3, date_year: 3002, date_month: 0, date_day: 0, is_canonical: true, size: 101
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s6.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 6, page: 38 }

    site_s6f1 = Repo.insert! %ScenarioFaction { scenario_id: site_s6.id, faction: :easterlings, suggested_points: 500, actual_points: 700, sort_order: 1 }

    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f1.id, amount:  1, sort_order: 1, figure_id: cirion.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f1.id, amount:  1, sort_order: 2, figure_id: khandish_king_chariot.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f1.id, amount:  2, sort_order: 3, figure_id: khandish_chieftain_horse.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f1.id, amount:  3, sort_order: 4, figure_id: gondor_rog.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f1.id, amount:  8, sort_order: 5, figure_id: khandish_w_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f1.id, amount: 16, sort_order: 6, figure_id: khandish_w_axe.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f1.id, amount: 12, sort_order: 7, figure_id: khandish_horseman.id }

    site_s6f2 = Repo.insert! %ScenarioFaction { scenario_id: site_s6.id, faction: :mordor, suggested_points: 750, actual_points: 796, sort_order: 2 }

    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f2.id, amount:  3, sort_order:  1, figure_id: orc_captain.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f2.id, amount:  1, sort_order:  2, figure_id: orc_captain_warg.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f2.id, amount: 10, sort_order:  3, figure_id: orc_w_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f2.id, amount: 12, sort_order:  4, figure_id: orc_w_spear.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f2.id, amount:  6, sort_order:  5, figure_id: orc_w_2h.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f2.id, amount:  6, sort_order:  6, figure_id: orc_w_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f2.id, amount:  2, sort_order:  7, figure_id: orc_w_banner.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f2.id, amount:  4, sort_order:  8, figure_id: warg_rider_spear.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f2.id, amount:  4, sort_order:  9, figure_id: warg_rider_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f2.id, amount:  4, sort_order: 10, figure_id: warg_rider_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f2.id, amount:  1, sort_order: 11, figure_id: war_catapult.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s6f2.id, amount:  1, sort_order: 12, figure_id: war_catapult_troll.id }

    #========================================================================
    site_s7 = Repo.insert! %Scenario {
      name: "The Field of Celebrant",
      blurb: "Eorl the Young saves Gondor from the Khandish and their Orc allies.",
      date_age: 3, date_year: 2510, date_month: 0, date_day: 0, is_canonical: true, size: 107
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s7.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 7, page: 40 }

    site_s7f1 = Repo.insert! %ScenarioFaction { scenario_id: site_s7.id, faction: :rohan, suggested_points: 650, actual_points: 635, sort_order: 1 }

    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f1.id, amount:  1, sort_order:  1, figure_id: eorl_horse.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f1.id, amount:  2, sort_order:  2, figure_id: rohan_captain_horse.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f1.id, amount:  7, sort_order:  3, figure_id: rohan_gd_horse_spear.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f1.id, amount: 12, sort_order:  4, figure_id: rohan_rider.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f1.id, amount:  6, sort_order:  5, figure_id: rohan_rider_spear.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f1.id, amount:  1, sort_order:  6, figure_id: rohan_gd_horse_banner.id }

    site_s7f2 = Repo.insert! %ScenarioFaction { scenario_id: site_s7.id, faction: :easterlings, suggested_points: 800, actual_points: 949, sort_order: 2 }

    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f2.id, amount:  1, sort_order:  1, figure_id: khandish_king_chariot.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f2.id, amount:  1, sort_order:  2, figure_id: khandish_chieftain.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f2.id, amount:  1, sort_order:  3, figure_id: khandish_chieftain_horse.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f2.id, amount:  1, sort_order:  4, figure_id: orc_captain.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f2.id, amount:  8, sort_order:  5, figure_id: khandish_w_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f2.id, amount: 16, sort_order:  6, figure_id: khandish_w_axe.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f2.id, amount: 12, sort_order:  7, figure_id: khandish_horseman.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f2.id, amount:  2, sort_order:  8, figure_id: khandish_charioteer.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f2.id, amount: 11, sort_order:  9, figure_id: orc_w_shield.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f2.id, amount: 12, sort_order: 10, figure_id: orc_w_spear.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f2.id, amount:  6, sort_order: 11, figure_id: orc_w_2h.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f2.id, amount:  6, sort_order: 12, figure_id: orc_w_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s7f2.id, amount:  1, sort_order: 13, figure_id: orc_w_banner.id }

    #========================================================================
    site_s8 = Repo.insert! %Scenario {
      name: "Hunter & Hunted",
      blurb: "Easterling raiders under Khamûl encounter the defenders of Fangorn.",
      date_age: 3, date_year: 2520, date_month: 0, date_day: 0, is_canonical: true, size: 28
    }

    Repo.insert! %ScenarioResource { scenario_id: site_s8.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 8, page: 46 }

    site_s8f1 = Repo.insert! %ScenarioFaction { scenario_id: site_s8.id, faction: :free_peoples, suggested_points: 400, actual_points: 495, sort_order: 1 }

    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s8f1.id, amount:  1, sort_order: 1, figure_id: treebeard.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s8f1.id, amount:  1, sort_order: 2, figure_id: gwaihir.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s8f1.id, amount:  2, sort_order: 3, figure_id: eagle.id }

    site_s8f2 = Repo.insert! %ScenarioFaction { scenario_id: site_s8.id, faction: :easterlings, suggested_points: 450, actual_points: 430, sort_order: 2 }

    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s8f2.id, amount:  1, sort_order: 1, figure_id: khamul_horse.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s8f2.id, amount:  1, sort_order: 2, figure_id: khandish_merc_chieftain.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s8f2.id, amount: 10, sort_order: 3, figure_id: easterling_kataphrakt.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s8f2.id, amount:  4, sort_order: 4, figure_id: khandish_merc_bow.id }
    Repo.insert! %ScenarioFactionFigure { scenario_faction_id: site_s8f2.id, amount:  8, sort_order: 5, figure_id: khandish_merc_axe.id }

    #########################################################################
    # THE FALL OF THE NECROMANCER
    #########################################################################

    #========================================================================
    fotn_s1 = Repo.insert! %Scenario {
      name: "Dol Guldur Awakens",
      blurb: "Thranduil leads a warband against the creatures of Mirkwood.",
      date_age: 3,  date_year: 2060, date_month: 0, date_day: 0, is_canonical: true, size: 22
    }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s1.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 1, page: 8 }
    Repo.insert! %ScenarioResource { scenario_id: fotn_s1.id, resource_type: 1, url: "https://www.youtube.com/watch?v=0_dCdLngsKs&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s1.id, faction: :mirkwood, suggested_points: 200, actual_points: 273, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: fotn_s1.id, faction: :dol_guldur, suggested_points: 200, actual_points: 150, sort_order: 2 }

    #========================================================================
    fotn_s2 = Repo.insert! %Scenario {
      name: "In the Nick of Time",
      blurb: "Elrond joins Thranduil against an attack from Dol Guldur lead by Khamûl.",
      date_age: 3,  date_year: 2061, date_month: 0, date_day: 0, is_canonical: true, size: 65
    }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s2.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 2, page: 10 }
    Repo.insert! %ScenarioResource { scenario_id: fotn_s2.id, resource_type: 1, url: "https://www.youtube.com/watch?v=AMrP8abPj0Q&index=2&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s2.id, faction: :mirkwood, suggested_points: 600, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: fotn_s2.id, faction: :dol_guldur, suggested_points: 600, actual_points: 0, sort_order: 2 }

    #========================================================================
    fotn_s3 = Repo.insert! %Scenario {
      name: "A Walk Through Dark Places",
      blurb: "A Rivendell band tries to protect Arwen and Círdan from the minions of Dol Guldur.",
      date_age: 3, date_year: 2062, date_month: 0, date_day: 0, is_canonical: true, size: 23
    }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s3.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 3, page: 12 }
    Repo.insert! %ScenarioResource { scenario_id: fotn_s3.id, resource_type: 1, url: "https://www.youtube.com/watch?v=YN8X_azJfO8&index=3&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s3.id, faction: :rivendell, suggested_points: 550, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: fotn_s3.id, faction: :dol_guldur, suggested_points: 300, actual_points: 0, sort_order: 2 }

    #========================================================================
    fotn_s4 = Repo.insert! %Scenario {
      name: "Meddle Not in the Affairs of Wizards",
      blurb: "The Istari faces the minions of Dol Guldur.",
      date_age: 3, date_year: 2062, date_month: 0, date_day: 0, is_canonical: true, size: 17
    }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s4.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 4, page: 14 }
    Repo.insert! %ScenarioResource { scenario_id: fotn_s4.id, resource_type: 1, url: "https://www.youtube.com/watch?v=UbIM0XE6jT8&index=4&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s4.id, faction: :white_council, suggested_points: 500, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: fotn_s4.id, faction: :dol_guldur,     suggested_points: 400, actual_points: 0, sort_order: 2 }

    #========================================================================
    fotn_s5 = Repo.insert! %Scenario {
      name: "The Lair of the Spider Queen",
      blurb: "Lothlorien attacks the beasts of Mirkwood",
      date_age: 3, date_year: 2063, date_month: 0, date_day: 0, is_canonical: true, size: 41
    }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s5.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 5, page: 16 }
    Repo.insert! %ScenarioResource { scenario_id: fotn_s5.id, resource_type: :video_replay, url: "https://www.youtube.com/watch?v=eyHTP-Vjhd8&index=5&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s5.id, faction: :lothlorien, suggested_points: 450, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: fotn_s5.id, faction: :dol_guldur, suggested_points: 300, actual_points: 0, sort_order: 2 }

    #========================================================================
    fotn_s6 = Repo.insert! %Scenario {
      name: "In the Shadow of Dol Guldur",
      blurb: "Elrond's elves fight a Ringwraith-led Dol Guldur army.",
      date_age: 3, date_year: 2850, date_month: 0, date_day: 0, is_canonical: true, size: 91
    }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s6.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 6, page: 18 }
    Repo.insert! %ScenarioResource { scenario_id: fotn_s6.id, resource_type: :video_replay, url: "https://www.youtube.com/watch?v=Cug7stLutRQ&index=6&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s6.id, faction: :rivendell,  suggested_points: 700, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: fotn_s6.id, faction: :dol_guldur, suggested_points: 800, actual_points: 0, sort_order: 2 }

    #========================================================================
    fotn_s7 = Repo.insert! %Scenario {
      name: "The Fall of the Necromancer",
      blurb: "The White Council battles the Necromancer himself at Dol Guldur.",
      date_age: 3, date_year: 2851, date_month: 0, date_day: 0, is_canonical: true, size: 29
    }

    Repo.insert! %ScenarioResource { scenario_id: fotn_s7.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 7, page: 20 }
    Repo.insert! %ScenarioResource { scenario_id: fotn_s7.id, resource_type: :video_replay, url: "https://www.youtube.com/watch?v=2J5px0_J2wQ&index=7&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1 }

    Repo.insert! %ScenarioFaction { scenario_id: fotn_s7.id, faction: :rivendell,  suggested_points: 1500, actual_points: 0, sort_order: 1 }
    Repo.insert! %ScenarioFaction { scenario_id: fotn_s7.id, faction: :dol_guldur, suggested_points: 1400, actual_points: 0, sort_order: 2 }
  end
end

SbgInv.Data.generate
