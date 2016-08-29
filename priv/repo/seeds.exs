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
  alias SbgInv.Role
  alias SbgInv.RoleFigure
  alias SbgInv.Scenario
  alias SbgInv.ScenarioFaction
  alias SbgInv.ScenarioResource
  alias SbgInv.UserFigure
  alias SbgInv.UserScenario

  def generate do
    _generate
  end

  defp _generate do
    IO.puts "Generating data"

    #########################################################################
    # FIGURES: SHADOW & FLAME
    #########################################################################

    birch_tree_giant  = Repo.insert! %Figure{name: "Birch Tree Giant",  plural_name: "Birch Tree Giants"}
    linden_tree_giant = Repo.insert! %Figure{name: "Linden Tree Giant", plural_name: "Linden Tree Giants"}
    ash_tree_giant    = Repo.insert! %Figure{name: "Ash Tree Giant",    plural_name: "Ash Tree Giants"}

    #########################################################################
    # FIGURES: ANGMAR
    #########################################################################

    warg_chieftain = Repo.insert! %Figure{name: "Wild Warg Chieftain"}

    warg = Repo.insert! %Figure{name: "Wild Warg", plural_name: "Wild Wargs"}

    #########################################################################
    # FIGURES: DWARVES
    #########################################################################

    dain  = Repo.insert! %Figure{name: "Dáin Ironfoot"}
    drar  = Repo.insert! %Figure{name: "Drar"}
    murin = Repo.insert! %Figure{name: "Murin"}

    dwarf_captain = Repo.insert! %Figure{name: "Dwarf Captain", plural_name: "Dwarf Captains"}

    dwarf_khazad_gd = Repo.insert! %Figure{name: "Khazad Guard",              plural_name: "Khazad Guards"}
    dwarf_w_bow     = Repo.insert! %Figure{name: "Dwarf with Dwarf bow",      plural_name: "Dwarves with Dwarf bow"}
    dwarf_w_shield  = Repo.insert! %Figure{name: "Dwarf with shield",         plural_name: "Dwarves with shield"}
    dwarf_w_axe     = Repo.insert! %Figure{name: "Dwarf with two-handed axe", plural_name: "Dwarves with two-handed axe"}
    dwarf_w_banner  = Repo.insert! %Figure{name: "Dwarf with banner",         plural_name: "Dwarves with banner"}

    #########################################################################
    # FIGURES: DOL GULDUR
    #########################################################################

    necromancer  = Repo.insert! %Figure{name: "The Necromancer"}
    spider_queen = Repo.insert! %Figure{name: "Spider Queen"}

    castellan    = Repo.insert! %Figure{name: "Castellan of Dol Guldur", plural_name: "Castellans of Dol Guldur"}
    bat_swarm    = Repo.insert! %Figure{name: "Bat Swarm",               plural_name: "Bat Swarms"}
    giant_spider = Repo.insert! %Figure{name: "Giant Spider",            plural_name: "Giant Spiders"}

    #########################################################################
    # FIGURES: EASTERLINGS
    #########################################################################

    khamul       = Repo.insert! %Figure{name: "Khamûl the Easterling"}
    khamul_horse = Repo.insert! %Figure{name: "Khamûl the Easterling on horseback"}

    easterling_captain       = Repo.insert! %Figure{name: "Easterling Captain",           plural_name: "Easterling Captains"}
    khandish_chieftain       = Repo.insert! %Figure{name: "Khandish Chieftain",           plural_name: "Khandish Chieftains"}
    khandish_chieftain_horse = Repo.insert! %Figure{name: "Khandish Chieftain on horse",  plural_name: "Khandish Chieftains on horse"}
    khandish_king_chariot    = Repo.insert! %Figure{name: "Khandish King in chariot",     plural_name: "Khandish Kings in chariot"}

    easterling_w_shield        = Repo.insert! %Figure{name: "Easterling Warrior with shield",           plural_name: "Easterling Warriors with shield"}
    easterling_w_bow           = Repo.insert! %Figure{name: "Easterling Warrior with bow",              plural_name: "Easterling Warriors with bow"}
    easterling_w_shield_spear  = Repo.insert! %Figure{name: "Easterling Warrior with shield and spear", plural_name: "Easterling Warriors with shield and spear"}
    easterling_w_banner        = Repo.insert! %Figure{name: "Easterling Warrior with banner",           plural_name: "Easterling Warriors with banner"}
    easterling_kataphrakt      = Repo.insert! %Figure{name: "Easterling Kataphrakt",                    plural_name: "Easterling Kataphrakts"}
    khandish_charioteer        = Repo.insert! %Figure{name: "Khandish Charioteer with bow",             plural_name: "Khandish Charioteers with bow"}
    khandish_w_bow             = Repo.insert! %Figure{name: "Khandish Warrior with bow",                plural_name: "Khandish Warriors with bow"}
    khandish_w_axe             = Repo.insert! %Figure{name: "Khandish Warrior with two-handed axe",     plural_name: "Khandish Warriors with two-handed axe"}
    khandish_horseman          = Repo.insert! %Figure{name: "Khandish Horseman",                        plural_name: "Khandish Horsemen"}

    #########################################################################
    # FIGURES: FREE PEOPLES
    #########################################################################

    cirdan       = Repo.insert! %Figure{name: "Círdan"}
    gandalf_grey = Repo.insert! %Figure{name: "Gandalf the Grey"}
    gwaihir      = Repo.insert! %Figure{name: "Gwaihir"}
    radagast     = Repo.insert! %Figure{name: "Radagast"}
    saruman      = Repo.insert! %Figure{name: "Saruman the White"}
    treebeard    = Repo.insert! %Figure{name: "Treebeard"}

    eagle = Repo.insert! %Figure{name: "Giant Eagle", plural_name: "Giant Eagles"}
    ent   = Repo.insert! %Figure{name: "Ent",         plural_name: "Ents"}

    #########################################################################
    # FIGURES: GONDOR
    #########################################################################

    cirion                   = Repo.insert! %Figure{name: "Cirion"}
    faramir                  = Repo.insert! %Figure{name: "Faramir"}
    madril                   = Repo.insert! %Figure{name: "Madril"}

    gondor_captain_mt        = Repo.insert! %Figure{name: "Captain of Minas Tirith", plural_name: "Captains of Minas Tirith"}

    gondor_citadel_gd_spear  = Repo.insert! %Figure{name: "Citadel Guard with spear",                      plural_name: "Citadel Guards with spear"}
    gondor_citadel_gd_bow    = Repo.insert! %Figure{name: "Citadel Guard with longbow",                    plural_name: "Citadel Guards with longbow"}
    gondor_rog               = Repo.insert! %Figure{name: "Ranger of Gondor",                              plural_name: "Rangers of Gondor"}
    gondor_womt_banner       = Repo.insert! %Figure{name: "Warrior of Minas Tirith with banner",           plural_name: "Warriors of Minas Tirith with banner"}
    gondor_womt_bow          = Repo.insert! %Figure{name: "Warrior of Minas Tirith with bow",              plural_name: "Warriors of Minas Tirith with bow"}
    gondor_womt_shield       = Repo.insert! %Figure{name: "Warrior of Minas Tirith with shield",           plural_name: "Warriors of Minas Tirith with shield"}
    gondor_womt_spear_shield = Repo.insert! %Figure{name: "Warrior of Minas Tirith with spear and shield", plural_name: "Warriors of Minas Tirith with spear and shield"}

    #########################################################################
    # FIGURES: ISENGARD
    #########################################################################

    uruk_hai_captain_shield = Repo.insert! %Figure{name: "Uruk-hai Captain with shield", plural_name: "Uruk-hai Captains with shield"}

    uruk_hai_berserker  = Repo.insert! %Figure{name: "Uruk-hai Berserker",             plural_name: "Uruk-hai Berserkers"}
    uruk_hai_feral      = Repo.insert! %Figure{name: "Feral Uruk-hai",                 plural_name: "Feral Uruk-hai"}
    uruk_hai_w_banner   = Repo.insert! %Figure{name: "Uruk-hai Warrior with banner",   plural_name: "Uruk-hai Warriors with banner"}
    uruk_hai_w_crossbow = Repo.insert! %Figure{name: "Uruk-hai Warrior with crossbow", plural_name: "Uruk-hai Warriors with crossbow"}
    uruk_hai_w_pike     = Repo.insert! %Figure{name: "Uruk-hai Warrior with pike",     plural_name: "Uruk-hai Warriors with pike"}
    uruk_hai_w_shield   = Repo.insert! %Figure{name: "Uruk-hai Warrior with shield",   plural_name: "Uruk-hai Warriors with shield"}

    isengard_troll = Repo.insert! %Figure{name: "Isengard Troll"}

    #########################################################################
    # FIGURES: LOTHLORIEN
    #########################################################################

    celeborn       = Repo.insert! %Figure{name: "Celeborn"}
    galadriel_lotg = Repo.insert! %Figure{name: "Galadriel, Lady of the Galadhrim"}

    #########################################################################
    # FIGURES: MIRKWOOD
    #########################################################################

    thranduil = Repo.insert! %Figure{name: "Thranduil" }

    wood_elf_sentinel = Repo.insert! %Figure{name: "Wood Elf Sentinel", plural_name: "Wood Elf Sentinels"}
    wood_elf_w_banner = Repo.insert! %Figure{name: "Wood Elf Warrior with banner",                          plural_name: "Wood Elf Warriors with banner"}
    wood_elf_w_blade  = Repo.insert! %Figure{name: "Wood Elf Warrior with Elven blade and throwing dagger", plural_name: "Wood Elf Warriors with Elven blade and throwing dagger"}
    wood_elf_w_bow    = Repo.insert! %Figure{name: "Wood Elf Warrior with bow",                             plural_name: "Wood Elf Warriors with bow"}
    wood_elf_w_spear  = Repo.insert! %Figure{name: "Wood Elf Warrior with spear",                           plural_name: "Wood Elf Warriors with spear"}

    #########################################################################
    # FIGURES: MORDOR
    #########################################################################

    orc_captain      = Repo.insert! %Figure{name: "Orc Captain",         plural_name: "Orc Captains"}
    orc_captain_warg = Repo.insert! %Figure{name: "Orc Captain on Warg", plural_name: "Orc Captains on Warg"}
    ringwraith       = Repo.insert! %Figure{name: "Ringwraith",          plural_name: "Ringwraiths"}
    troll_chieftain  = Repo.insert! %Figure{name: "Troll Chieftain",     plural_name: "Troll Chieftain"}

    mordor_troll      = Repo.insert! %Figure{name: "Mordor Troll",               plural_name: "Mordor Trolls"}
    orc_w_banner      = Repo.insert! %Figure{name: "Orc with banner",            plural_name: "Orcs with banner"}
    orc_w_bow         = Repo.insert! %Figure{name: "Orc with Orc bow",           plural_name: "Orcs with Orc bow"}
    orc_w_shield      = Repo.insert! %Figure{name: "Orc with shield",            plural_name: "Orcs with shield"}
    orc_w_spear       = Repo.insert! %Figure{name: "Orc with spear",             plural_name: "Orcs with spear"}
    orc_w_2h          = Repo.insert! %Figure{name: "Orc with two-handed weapon", plural_name: "Orcs with two-handed weapon"}
    warg_rider_bow    = Repo.insert! %Figure{name: "Warg Rider with bow",        plural_name: "Warg Riders with bow"}
    warg_rider_shield = Repo.insert! %Figure{name: "Warg Rider with shield",     plural_name: "Warg Riders with shield"}
    warg_rider_spear  = Repo.insert! %Figure{name: "Warg Rider with spear",      plural_name: "Warg Riders with spear"}

    war_catapult       = Repo.insert! %Figure{name: "War Catapult",       plural_name: "War Catapults"}
    war_catapult_troll = Repo.insert! %Figure{name: "War Catapult Troll", plural_name: "War Catapult Trolls"}

    #########################################################################
    # FIGURES: RIVENDELL
    #########################################################################

    arwen           = Repo.insert! %Figure{name: "Arwen (FotR)"}
    arwen2          = Repo.insert! %Figure{name: "Arwen (LotR)"}
    elrond          = Repo.insert! %Figure{name: "Elrond"}
    erestor         = Repo.insert! %Figure{name: "Erestor"}
    glorfindel_lotw = Repo.insert! %Figure{name: "Glorfindel, Lord of the West"}
    legolas         = Repo.insert! %Figure{name: "Legolas"}

    high_elf_captain = Repo.insert! %Figure{name: "High Elf Captain", plural_name: "High Elf Captains"}

    high_elf_w_banner       = Repo.insert! %Figure{name: "High Elf with banner",           plural_name: "High Elves with banner"}
    high_elf_w_blade        = Repo.insert! %Figure{name: "High Elf with Elven blade",      plural_name: "High Elves with Elven blade"}
    high_elf_w_bow          = Repo.insert! %Figure{name: "High Elf with bow",              plural_name: "High Elves with bow"}
    high_elf_w_spear_shield = Repo.insert! %Figure{name: "High Elf with spear and shield", plural_name: "High Elves with spear and shield"}

    #########################################################################
    # FIGURES: ROHAN
    #########################################################################

    eorl_horse = Repo.insert! %Figure{name: "Eorl the Young on horse"}

    rohan_captain_horse = Repo.insert! %Figure{name: "Captain of Rohan on horse", plural_name: "Captains of Rohan on horse"}

    rohan_gd_horse_spear  = Repo.insert! %Figure{name: "Rohan Royal Guard with throwing spear on horse", plural_name: "Rohan Royal Guards with throwing spear on horse"}
    rohan_gd_horse_banner = Repo.insert! %Figure{name: "Rohan Royal Guard with banner",                  plural_name: "Rohan Royal Guards with banner"}
    rohan_rider           = Repo.insert! %Figure{name: "Rider of Rohan",                                 plural_name: "Riders of Rohan"}
    rohan_rider_spear     = Repo.insert! %Figure{name: "Rider of Rohan with throwing spear",             plural_name: "Riders of Rohan with throwing spear"}

    #########################################################################
    # USER_FIGURES
    #########################################################################
    Repo.insert! %UserFigure{user_id: 1, figure_id: birch_tree_giant.id,  owned: 1, painted: 1}
    Repo.insert! %UserFigure{user_id: 1, figure_id: linden_tree_giant.id, owned: 1, painted: 1}
    Repo.insert! %UserFigure{user_id: 1, figure_id: ash_tree_giant.id,    owned: 1, painted: 0}

    Repo.insert! %UserFigure{user_id: 1, figure_id: drar.id,               owned:  1, painted:  1}
    Repo.insert! %UserFigure{user_id: 1, figure_id: murin.id,              owned:  1, painted:  1}

    Repo.insert! %UserFigure{user_id: 1, figure_id: easterling_captain.id,        owned:  2, painted: 2}
    Repo.insert! %UserFigure{user_id: 1, figure_id: easterling_w_bow.id,          owned: 12, painted: 8}
    Repo.insert! %UserFigure{user_id: 1, figure_id: easterling_w_shield.id,       owned: 12, painted: 8}
    Repo.insert! %UserFigure{user_id: 1, figure_id: easterling_w_shield_spear.id, owned:  6, painted: 4}
    Repo.insert! %UserFigure{user_id: 1, figure_id: easterling_kataphrakt.id,     owned:  5, painted: 5}
    Repo.insert! %UserFigure{user_id: 1, figure_id: khandish_w_bow.id,            owned:  6, painted:  0}

    Repo.insert! %UserFigure{user_id: 1, figure_id: treebeard.id, owned:  1, painted: 1}

    Repo.insert! %UserFigure{user_id: 1, figure_id: cirion.id,  owned:  1, painted: 1}
    Repo.insert! %UserFigure{user_id: 1, figure_id: faramir.id, owned:  1, painted: 1}
    Repo.insert! %UserFigure{user_id: 1, figure_id: madril.id,  owned:  1, painted: 1}

    Repo.insert! %UserFigure{user_id: 1, figure_id: gondor_womt_bow.id, owned: 36, painted: 24}

    #########################################################################
    # SHADOW & FLAME
    #########################################################################

    #========================================================================
    saf_s1 = Repo.insert! %Scenario{
      name: "The Eastgate",
      blurb: "Balin's dwarves assault the east gate of Moria.",
      date_age: 3, date_year: 2989, date_month: 0, date_day: 0, is_canonical: true, size: 43
   }

    Repo.insert! %ScenarioResource{scenario_id: saf_s1.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 1, page: 14}

    Repo.insert! %ScenarioFaction{scenario_id: saf_s1.id, faction: :dwarves, suggested_points: 200, actual_points: 0, sort_order: 1}
    Repo.insert! %ScenarioFaction{scenario_id: saf_s1.id, faction: :moria,   suggested_points: 200, actual_points: 0, sort_order: 2}

    #========================================================================
    saf_s2 = Repo.insert! %Scenario{
      name: "Battle for the Dwarrowdelf",
      blurb: "Balin faces off against Durbûrz deep within Moria.",
      date_age: 3, date_year: 2990, date_month: 0, date_day: 0, is_canonical: true, size: 77
   }

    Repo.insert! %ScenarioResource{scenario_id: saf_s2.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 2, page: 20}

    Repo.insert! %ScenarioFaction{scenario_id: saf_s2.id, faction: :dwarves, suggested_points: 600, actual_points: 0, sort_order: 1}
    Repo.insert! %ScenarioFaction{scenario_id: saf_s2.id, faction: :moria,   suggested_points: 600, actual_points: 0, sort_order: 2}

    #========================================================================
    saf_s3 = Repo.insert! %Scenario{
      name: "Mirrormere",
      blurb: "The Goblins ambush Balin as he gazes into the waters of the Kheled-zâram.",
      date_age: 3, date_year: 2993, date_month: 0, date_day: 0, is_canonical: true, size: 51
   }

    Repo.insert! %ScenarioResource{scenario_id: saf_s3.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 3, page: 24}

    Repo.insert! %ScenarioFaction{scenario_id: saf_s3.id, faction: :dwarves, suggested_points: 300, actual_points: 0, sort_order: 1}
    Repo.insert! %ScenarioFaction{scenario_id: saf_s3.id, faction: :moria,   suggested_points: 300, actual_points: 0, sort_order: 2}

    #========================================================================
    saf_s4 = Repo.insert! %Scenario{
      name: "They Are Coming",
      blurb: "The last dwarves in Moria face the Balrog.",
      date_age: 3, date_year: 2994, date_month: 0, date_day: 0, is_canonical: true, size: 55
   }

    Repo.insert! %ScenarioResource{scenario_id: saf_s4.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 4, page: 28}

    Repo.insert! %ScenarioFaction{scenario_id: saf_s4.id, faction: :dwarves, suggested_points: 500, actual_points: 0, sort_order: 1}
    Repo.insert! %ScenarioFaction{scenario_id: saf_s4.id, faction: :moria,   suggested_points: 500, actual_points: 0, sort_order: 2}

    #========================================================================
    saf_s5 = Repo.insert! %Scenario{
      name: "Fog on the Barrow Downs",
      blurb: "Frodo and friends are attacked by the Barrow Wights.",
      date_age: 3, date_year: 3018, date_month: 9, date_day: 28, is_canonical: true, size: 9
   }

    Repo.insert! %ScenarioResource{scenario_id: saf_s5.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 5, page: 36}

    Repo.insert! %ScenarioFaction{scenario_id: saf_s5.id, faction: :fellowship, suggested_points: 200, actual_points: 0, sort_order: 1}
    Repo.insert! %ScenarioFaction{scenario_id: saf_s5.id, faction: :angmar,     suggested_points: 200, actual_points: 0, sort_order: 2}

    #========================================================================
    saf_s6 = Repo.insert! %Scenario{
      name: "Surrounded!",
      blurb: "Elves under Glorfindel are surrounded by Orcs on one side and Goblins on the other.",
      date_age: 3, date_year: 2925, date_month: 0, date_day: 0, is_canonical: true, size: 101
   }

    Repo.insert! %ScenarioResource{scenario_id: saf_s6.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 6, page: 42}

    Repo.insert! %ScenarioFaction{scenario_id: saf_s6.id, faction: :rivendell, suggested_points: 650, actual_points: 0, sort_order: 1}
    Repo.insert! %ScenarioFaction{scenario_id: saf_s6.id, faction: :angmar,    suggested_points: 700, actual_points: 0, sort_order: 2}

    #========================================================================
    saf_s7 = Repo.insert! %Scenario{
      name: "Fangorn",
      blurb: "The Rohirrim, chasing down an Orcish raiding party, get some unexpected help.",
      date_age: 3, date_year: 3016, date_month: 0, date_day: 0, is_canonical: true, size: 53
   }

    Repo.insert! %ScenarioResource{scenario_id: saf_s7.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 7, page: 46}

    Repo.insert! %ScenarioFaction{scenario_id: saf_s7.id, faction: :rohan,    suggested_points: 500, actual_points: 0, sort_order: 1}
    Repo.insert! %ScenarioFaction{scenario_id: saf_s7.id, faction: :isengard, suggested_points: 500, actual_points: 0, sort_order: 2}

    #########################################################################
    # SIEGE OF GONDOR
    #########################################################################

    #========================================================================
    sog_s1 = Repo.insert! %Scenario{
      name: "Osgiliath",
      blurb: "Boromir and Faramir defend Osgiliath against the initial assault from Mordor.",
      date_age: 3, date_year: 3018, date_month: 9, date_day: 20, is_canonical: true, size: 105
   }

    Repo.insert! %ScenarioResource{scenario_id: sog_s1.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 1, page: 18}

    Repo.insert! %ScenarioFaction{scenario_id: sog_s1.id, faction: :gondor, suggested_points: 800, actual_points: 0, sort_order: 1}
    Repo.insert! %ScenarioFaction{scenario_id: sog_s1.id, faction: :mordor, suggested_points: 800, actual_points: 0, sort_order: 2}

    #========================================================================
    sog_s2 = Repo.insert! %Scenario{
      name: "First Assault on Cair Andros",
      blurb: "Faramir defends the Anduin crossing north of Osgiliath.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 10, is_canonical: true, size: 100
   }

    Repo.insert! %ScenarioResource{scenario_id: sog_s2.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 2, page: 32}

    Repo.insert! %ScenarioFaction{scenario_id: sog_s2.id, faction: :gondor, suggested_points: 250, actual_points: 0, sort_order: 1}
    Repo.insert! %ScenarioFaction{scenario_id: sog_s2.id, faction: :mordor, suggested_points: 750, actual_points: 0, sort_order: 2}

    #========================================================================
    sog_s3 = Repo.insert! %Scenario{
      name: "Second Assault on Cair Andros",
      blurb: "Gothmog leads another assault on Cair Andros.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 11, is_canonical: true, size: 69
   }

    Repo.insert! %ScenarioResource{scenario_id: sog_s3.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 3, page: 40}

    Repo.insert! %ScenarioFaction{scenario_id: sog_s3.id, faction: :gondor, suggested_points: 150, actual_points: 0, sort_order: 1}
    Repo.insert! %ScenarioFaction{scenario_id: sog_s3.id, faction: :mordor, suggested_points: 600, actual_points: 0, sort_order: 2}

    #========================================================================
    sog_s4 = Repo.insert! %Scenario{
      name: "The Rammas",
      blurb: "Gothmog pursues Faramir out of Osgiliath to the edge of the Pelennor Fields.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 12, is_canonical: true, size: 87
   }

    Repo.insert! %ScenarioResource{scenario_id: sog_s4.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 4, page: 46}

    Repo.insert! %ScenarioFaction{scenario_id: sog_s4.id, faction: :gondor, suggested_points: 500, actual_points: 0, sort_order: 1}
    Repo.insert! %ScenarioFaction{scenario_id: sog_s4.id, faction: :mordor, suggested_points: 500, actual_points: 0, sort_order: 2}

    #========================================================================
    sog_s5 = Repo.insert! %Scenario{
      name: "The Siege of Minas Tirith",
      blurb: "Gandalf the White defends the walls of Minas Tirith from the forces of Mordor under Gothmog.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 14, is_canonical: true, size: 112
   }

    Repo.insert! %ScenarioResource{scenario_id: sog_s5.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 5, page: 48}

    Repo.insert! %ScenarioFaction{scenario_id: sog_s5.id, faction: :gondor, suggested_points:  750, actual_points: 0, sort_order: 1}
    Repo.insert! %ScenarioFaction{scenario_id: sog_s5.id, faction: :mordor, suggested_points: 1000, actual_points: 0, sort_order: 2}

    #========================================================================
    sog_s6 = Repo.insert! %Scenario{
      name: "The Pyre of Denethor",
      blurb: "Gandalf the White rescues Faramir from the insanity of Denethor.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, is_canonical: true, size: 84
   }

    Repo.insert! %ScenarioResource{scenario_id: sog_s6.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 5, page: 52}

    Repo.insert! %ScenarioFaction{scenario_id: sog_s6.id, faction: :gondor, suggested_points:  750, actual_points: 0, sort_order: 1}
    Repo.insert! %ScenarioFaction{scenario_id: sog_s6.id, faction: :mordor, suggested_points: 1000, actual_points: 0, sort_order: 2}

    #========================================================================
    sog_s7 = Repo.insert! %Scenario{
      name: "The Defenses Must Hold!",
      blurb: "Theoden and friends hold out at Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, is_canonical: true, size: 109
   }

    Repo.insert! %ScenarioResource{scenario_id: sog_s7.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 6, page: 58}

    Repo.insert! %ScenarioFaction{scenario_id: sog_s7.id, faction: :gondor, suggested_points: 250, actual_points: 0, sort_order: 1}
    Repo.insert! %ScenarioFaction{scenario_id: sog_s7.id, faction: :mordor, suggested_points: 375, actual_points: 0, sort_order: 2}

    #========================================================================
    sog_s8 = Repo.insert! %Scenario{
      name: "Forth Eorlingas!",
      blurb: "Theoden leads a mounted charge out from Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 4, is_canonical: true, size: 105
   }

    Repo.insert! %ScenarioResource{scenario_id: sog_s8.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 7, page: 62}

    Repo.insert! %ScenarioFaction{scenario_id: sog_s8.id, faction: :gondor, suggested_points: 800, actual_points: 0, sort_order: 1}
    Repo.insert! %ScenarioFaction{scenario_id: sog_s8.id, faction: :mordor, suggested_points: 800, actual_points: 0, sort_order: 2}

    #########################################################################
    # A SHADOW IN THE EAST
    #########################################################################

    #========================================================================
    site_s1 = Repo.insert! %Scenario{
      name: "The Fall of Amon Barad",
      blurb: "Easterlings under Khamûl launch a surprise attack on a Gondorian outpost in Ithilien.",
      date_age: 3, date_year: 2998, date_month: -4, date_day: 0, is_canonical: true, size: 30
   }

    Repo.insert! %ScenarioResource{scenario_id: site_s1.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 1, page: 14}
    Repo.insert! %ScenarioResource{scenario_id: site_s1.id, resource_type: :web_replay, title: "Dave T", url: "http://www.davetownsend.org/Battles/LotR-20160604/", sort_order: 1}

    site_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s1.id, faction: :gondor, suggested_points: 200, actual_points: 203, sort_order: 1}

    site_s1f1r1 = Repo.insert! %Role{scenario_faction_id: site_s1f1.id, amount: 1, sort_order: 1, name: "Cirion"}
    Repo.insert! %RoleFigure{role_id: site_s1f1r1.id, figure_id: cirion.id}

    site_s1f1r2 = Repo.insert! %Role{scenario_faction_id: site_s1f1.id, amount: 4, sort_order: 2, name: "Warriors of Minas Tirith with spear and shield"}
    Repo.insert! %RoleFigure{role_id: site_s1f1r2.id, figure_id: gondor_womt_spear_shield.id}

    site_s1f1r3 = Repo.insert! %Role{scenario_faction_id: site_s1f1.id, amount: 4, sort_order: 3, name: "Warriors of Minas Tirith with shield"}
    Repo.insert! %RoleFigure{role_id: site_s1f1r3.id, figure_id: gondor_womt_shield.id}

    site_s1f1r4 = Repo.insert! %Role{scenario_faction_id: site_s1f1.id, amount: 4, sort_order: 4, name: "Warriors of Minas Tirith with bow"}
    Repo.insert! %RoleFigure{role_id: site_s1f1r4.id, figure_id: gondor_womt_bow.id}

    site_s1f1r5 = Repo.insert! %Role{scenario_faction_id: site_s1f1.id, amount: 6, sort_order: 5, name: "Rangers of Gondor"}
    Repo.insert! %RoleFigure{role_id: site_s1f1r5.id, figure_id: gondor_rog.id}

    site_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s1.id, faction: :easterlings, suggested_points: 200, actual_points: 220, sort_order: 2}

    site_s1f2r1 = Repo.insert! %Role{scenario_faction_id: site_s1f2.id, amount: 1, sort_order: 1, name: "Khamûl the Easterling"}
    Repo.insert! %RoleFigure{role_id: site_s1f2r1.id, figure_id: khamul.id}

    site_s1f2r2 = Repo.insert! %Role{scenario_faction_id: site_s1f2.id, amount: 4, sort_order: 2, name: "Easterling Warriors with shield"}
    Repo.insert! %RoleFigure{role_id: site_s1f2r1.id, figure_id: easterling_w_shield.id}

    site_s1f2r3 = Repo.insert! %Role{scenario_faction_id: site_s1f2.id, amount: 4, sort_order: 3, name: "Easterling Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: site_s1f2r1.id, figure_id: easterling_w_bow.id}

    site_s1f2r4 = Repo.insert! %Role{scenario_faction_id: site_s1f2.id, amount: 2, sort_order: 4, name: "Easterling Warriors with shield and spear"}
    Repo.insert! %RoleFigure{role_id: site_s1f2r1.id, figure_id: easterling_w_shield_spear.id}

    #========================================================================
    site_s2 = Repo.insert! %Scenario{
      name: "Pursuit Through Ithilien",
      blurb: "Easterlings pursue Cirion after the fall of Amon Barad.",
      date_age: 3, date_year: 2998, date_month: -3, date_day: 0, is_canonical: true, size: 28
   }

    Repo.insert! %ScenarioResource{scenario_id: site_s2.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 2, page: 16}
    Repo.insert! %ScenarioResource{scenario_id: site_s2.id, resource_type: :web_replay, title: "Dave T", url: "http://davetownsend.org/Battles/LotR-20160727/", sort_order: 1}

    site_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s2.id, faction: :gondor, suggested_points: 275, actual_points: 279, sort_order: 1}

    site_s2f1r1 = Repo.insert! %Role{scenario_faction_id: site_s2f1.id, amount: 1, sort_order: 1, name: "Cirion"}
    Repo.insert! %RoleFigure{role_id: site_s2f1r1.id, figure_id: cirion.id}

    site_s2f1r2 = Repo.insert! %Role{scenario_faction_id: site_s2f1.id, amount: 1, sort_order: 2, name: "Murin"}
    Repo.insert! %RoleFigure{role_id: site_s2f1r2.id, figure_id: murin.id}

    site_s2f1r3 = Repo.insert! %Role{scenario_faction_id: site_s2f1.id, amount: 1, sort_order: 3, name: "Drar"}
    Repo.insert! %RoleFigure{role_id: site_s2f1r3.id, figure_id: drar.id}

    site_s2f1r4 = Repo.insert! %Role{scenario_faction_id: site_s2f1.id, amount: 2, sort_order: 4, name: "Warriors of Minas Tirith with spear and shield"}
    Repo.insert! %RoleFigure{role_id: site_s2f1r4.id, figure_id: gondor_womt_spear_shield.id}

    site_s2f1r5 = Repo.insert! %Role{scenario_faction_id: site_s2f1.id, amount: 2, sort_order: 5, name: "Warriors of Minas Tirith with shield"}
    Repo.insert! %RoleFigure{role_id: site_s2f1r5.id, figure_id: gondor_womt_shield.id}

    site_s2f1r6 = Repo.insert! %Role{scenario_faction_id: site_s2f1.id, amount: 2, sort_order: 6, name: "Warriors of Minas Tirith with bow"}
    Repo.insert! %RoleFigure{role_id: site_s2f1r6.id, figure_id: gondor_womt_bow.id}

    site_s2f1r7 = Repo.insert! %Role{scenario_faction_id: site_s2f1.id, amount: 3, sort_order: 7, name: "Rangers of Gondor"}
    Repo.insert! %RoleFigure{role_id: site_s2f1r7.id, figure_id: gondor_rog.id}

    site_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s2.id, faction: :easterlings, suggested_points: 225, actual_points: 197, sort_order: 2}

    site_s2f2r1 = Repo.insert! %Role{scenario_faction_id: site_s2f2.id, amount: 1, sort_order: 1, name: "Easterling Captain"}
    Repo.insert! %RoleFigure{role_id: site_s2f2r1.id, figure_id: easterling_captain.id}

    site_s2f2r2 = Repo.insert! %Role{scenario_faction_id: site_s2f2.id, amount: 4, sort_order: 2, name: "Easterling Warriors with shield"}
    Repo.insert! %RoleFigure{role_id: site_s2f2r2.id, figure_id: easterling_w_shield.id}

    site_s2f2r3 = Repo.insert! %Role{scenario_faction_id: site_s2f2.id, amount: 4, sort_order: 3, name: "Easterling Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: site_s2f2r3.id, figure_id: easterling_w_bow.id}

    site_s2f2r4 = Repo.insert! %Role{scenario_faction_id: site_s2f2.id, amount: 2, sort_order: 4, name: "Easterling Warriors with shield and spear"}
    Repo.insert! %RoleFigure{role_id: site_s2f2r4.id, figure_id: easterling_w_shield_spear.id}

    site_s2f2r5 = Repo.insert! %Role{scenario_faction_id: site_s2f2.id, amount: 5, sort_order: 5, name: "Easterling Kataphrakts"}
    Repo.insert! %RoleFigure{role_id: site_s2f2r5.id, figure_id: easterling_kataphrakt.id}

    #========================================================================
    site_s3 = Repo.insert! %Scenario{
      name: "Gathering Information",
      blurb: "Cirion's forces try to capture a Khandish leader from a fort.",
      date_age: 3, date_year: 2998, date_month: -2, date_day: 0, is_canonical: true, size: 47
   }

    Repo.insert! %ScenarioResource{scenario_id: site_s3.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 3, page: 28}

    site_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s3.id, faction: :gondor, suggested_points: 350, actual_points: 329, sort_order: 1}

    site_s3f1r1 = Repo.insert! %Role{scenario_faction_id: site_s3f1.id, amount: 1, sort_order: 1, name: "Cirion"}
    Repo.insert! %RoleFigure{role_id: site_s3f1r1.id, figure_id: cirion.id}

    site_s3f1r2 = Repo.insert! %Role{scenario_faction_id: site_s3f1.id, amount: 1, sort_order: 2, name: "Murin"}
    Repo.insert! %RoleFigure{role_id: site_s3f1r2.id, figure_id: murin.id}

    site_s3f1r3 = Repo.insert! %Role{scenario_faction_id: site_s3f1.id, amount: 1, sort_order: 3, name: "Drar"}
    Repo.insert! %RoleFigure{role_id: site_s3f1r3.id, figure_id: drar.id}

    site_s3f1r4 = Repo.insert! %Role{scenario_faction_id: site_s3f1.id, amount: 4, sort_order: 4, name: "Warriors of Minas Tirith with spear and shield"}
    Repo.insert! %RoleFigure{role_id: site_s3f1r4.id, figure_id: gondor_womt_spear_shield.id}

    site_s3f1r5 = Repo.insert! %Role{scenario_faction_id: site_s3f1.id, amount: 4, sort_order: 5, name: "Warriors of Minas Tirith with shield"}
    Repo.insert! %RoleFigure{role_id: site_s3f1r5.id, figure_id: gondor_womt_shield.id}

    site_s3f1r6 = Repo.insert! %Role{scenario_faction_id: site_s3f1.id, amount: 4, sort_order: 6, name: "Warriors of Minas Tirith with bow"}
    Repo.insert! %RoleFigure{role_id: site_s3f1r6.id, figure_id: gondor_womt_bow.id}

    site_s3f1r7 = Repo.insert! %Role{scenario_faction_id: site_s3f1.id, amount: 3, sort_order: 7, name: "Rangers of Gondor"}
    Repo.insert! %RoleFigure{role_id: site_s3f1r7.id, figure_id: gondor_rog.id}

    site_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s3.id, faction: :easterlings, suggested_points: 350, actual_points: 420, sort_order: 2}

    site_s3f2r1 = Repo.insert! %Role{scenario_faction_id: site_s3f2.id, amount: 2, sort_order: 1, name: "Khandish Chieftains"}
    Repo.insert! %RoleFigure{role_id: site_s3f2r1.id, figure_id: khandish_chieftain.id}

    site_s3f2r2 = Repo.insert! %Role{scenario_faction_id: site_s3f2.id, amount: 4, sort_order: 2, name: "Khandish Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: site_s3f2r2.id, figure_id: khandish_w_bow.id}

    site_s3f2r3 = Repo.insert! %Role{scenario_faction_id: site_s3f2.id, amount: 8, sort_order: 3, name: "Khandish Warriors with two-handed axe"}
    Repo.insert! %RoleFigure{role_id: site_s3f2r3.id, figure_id: khandish_w_axe.id}

    site_s3f2r4 = Repo.insert! %Role{scenario_faction_id: site_s3f2.id, amount: 5, sort_order: 4, name: "Khandish Horsemen"}
    Repo.insert! %RoleFigure{role_id: site_s3f2r4.id, figure_id: khandish_horseman.id}

    site_s3f2r5 = Repo.insert! %Role{scenario_faction_id: site_s3f2.id, amount: 3, sort_order: 5, name: "Easterling Warriors with shield"}
    Repo.insert! %RoleFigure{role_id: site_s3f2r5.id, figure_id: easterling_w_shield.id}

    site_s3f2r6 = Repo.insert! %Role{scenario_faction_id: site_s3f2.id, amount: 2, sort_order: 6, name: "Easterling Warriors with shield and spear"}
    Repo.insert! %RoleFigure{role_id: site_s3f2r6.id, figure_id: easterling_w_shield_spear.id}

    site_s3f2r7 = Repo.insert! %Role{scenario_faction_id: site_s3f2.id, amount: 4, sort_order: 7, name: "Easterling Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: site_s3f2r7.id, figure_id: easterling_w_bow.id}

    site_s3f2r8 = Repo.insert! %Role{scenario_faction_id: site_s3f2.id, amount: 1, sort_order: 8, name: "Easterling Warrior with banner"}
    Repo.insert! %RoleFigure{role_id: site_s3f2r8.id, figure_id: easterling_w_banner.id}

    #========================================================================
    site_s4 = Repo.insert! %Scenario{
      name: "Turning the Tide",
      blurb: "Cirion surprise attacks an Easterling camp at night.",
      date_age: 3, date_year: 2998, date_month: -1, date_day: 0, is_canonical: true, size: 121
   }

    Repo.insert! %ScenarioResource{scenario_id: site_s4.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 4, page: 30}

    site_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s4.id, faction: :gondor, suggested_points: 900, actual_points: 849, sort_order: 1}

    site_s4f1r1  = Repo.insert! %Role{scenario_faction_id: site_s4f1.id, amount:  1, sort_order:  1, name: "Cirion"}
    Repo.insert! %RoleFigure{role_id: site_s4f1r1.id, figure_id: cirion.id}

    site_s4f1r2  = Repo.insert! %Role{scenario_faction_id: site_s4f1.id, amount:  1, sort_order:  2, name: "Murin"}
    Repo.insert! %RoleFigure{role_id: site_s4f1r2.id, figure_id: murin.id}

    site_s4f1r3  = Repo.insert! %Role{scenario_faction_id: site_s4f1.id, amount:  1, sort_order:  3, name: "Drar"}
    Repo.insert! %RoleFigure{role_id: site_s4f1r3.id, figure_id: drar.id}

    site_s4f1r4  = Repo.insert! %Role{scenario_faction_id: site_s4f1.id, amount:  1, sort_order:  4, name: "Madril"}
    Repo.insert! %RoleFigure{role_id: site_s4f1r4.id, figure_id: madril.id}

    site_s4f1r5  = Repo.insert! %Role{scenario_faction_id: site_s4f1.id, amount:  1, sort_order:  5, name: "Faramir"}
    Repo.insert! %RoleFigure{role_id: site_s4f1r5.id, figure_id: faramir.id}

    site_s4f1r6  = Repo.insert! %Role{scenario_faction_id: site_s4f1.id, amount:  1, sort_order:  6, name: "Captain of Minas Tirith"}
    Repo.insert! %RoleFigure{role_id: site_s4f1r6.id, figure_id: gondor_captain_mt.id}

    site_s4f1r7  = Repo.insert! %Role{scenario_faction_id: site_s4f1.id, amount:  3, sort_order:  7, name: "Citadel Guards with spear"}
    Repo.insert! %RoleFigure{role_id: site_s4f1r7.id, figure_id: gondor_citadel_gd_spear.id}

    site_s4f1r8  = Repo.insert! %Role{scenario_faction_id: site_s4f1.id, amount:  3, sort_order:  8, name: "Citadel Guards with longbow"}
    Repo.insert! %RoleFigure{role_id: site_s4f1r8.id, figure_id: gondor_citadel_gd_bow.id}

    site_s4f1r9  = Repo.insert! %Role{scenario_faction_id: site_s4f1.id, amount: 12, sort_order:  9, name: "Warriors of Minas Tirith with spear and shield"}
    Repo.insert! %RoleFigure{role_id: site_s4f1r9.id, figure_id: gondor_womt_spear_shield.id}

    site_s4f1r10 = Repo.insert! %Role{scenario_faction_id: site_s4f1.id, amount: 11, sort_order: 10, name: "Warriors of Minas Tirith with shield"}
    Repo.insert! %RoleFigure{role_id: site_s4f1r10.id, figure_id: gondor_womt_shield.id}

    site_s4f1r11 = Repo.insert! %Role{scenario_faction_id: site_s4f1.id, amount: 12, sort_order: 11, name: "Warriors of Minas Tirith with bow"}
    Repo.insert! %RoleFigure{role_id: site_s4f1r11.id, figure_id: gondor_womt_bow.id}

    site_s4f1r12 = Repo.insert! %Role{scenario_faction_id: site_s4f1.id, amount:  1, sort_order: 12, name: "Warrior of Minas Tirith with banner"}
    Repo.insert! %RoleFigure{role_id: site_s4f1r12.id, figure_id: gondor_womt_banner.id}

    site_s4f1r13 = Repo.insert! %Role{scenario_faction_id: site_s4f1.id, amount:  9, sort_order: 13, name: "Rangers of Gondor"}
    Repo.insert! %RoleFigure{role_id: site_s4f1r13.id, figure_id: gondor_rog.id}

    site_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s4.id, faction: :easterlings, suggested_points: 600, actual_points: 813, sort_order: 2}

    site_s4f2r1 = Repo.insert! %Role{scenario_faction_id: site_s4f2.id, amount:  1, sort_order:  1, name: "Khamûl the Easterling"}
    Repo.insert! %RoleFigure{role_id: site_s4f2r1.id, figure_id: khamul.id}

    site_s4f2r2 = Repo.insert! %Role{scenario_faction_id: site_s4f2.id, amount:  1, sort_order:  2, name: "Easterling Captain"}
    Repo.insert! %RoleFigure{role_id: site_s4f2r1.id, figure_id: easterling_captain.id}

    site_s4f2r3 = Repo.insert! %Role{scenario_faction_id: site_s4f2.id, amount:  1, sort_order:  3, name: "Khandish Chieftain"}
    Repo.insert! %RoleFigure{role_id: site_s4f2r1.id, figure_id: khandish_chieftain.id}

    site_s4f2r4 = Repo.insert! %Role{scenario_faction_id: site_s4f2.id, amount: 11, sort_order:  4, name: "Easterling Warriors with shield"}
    Repo.insert! %RoleFigure{role_id: site_s4f2r1.id, figure_id: easterling_w_shield.id}

    site_s4f2r5 = Repo.insert! %Role{scenario_faction_id: site_s4f2.id, amount: 12, sort_order:  5, name: "Easterling Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: site_s4f2r1.id, figure_id: easterling_w_bow.id}

    site_s4f2r6 = Repo.insert! %Role{scenario_faction_id: site_s4f2.id, amount:  9, sort_order:  6, name: "Easterling Warriors with shield and spear"}
    Repo.insert! %RoleFigure{role_id: site_s4f2r1.id, figure_id: easterling_w_shield_spear.id}

    site_s4f2r7 = Repo.insert! %Role{scenario_faction_id: site_s4f2.id, amount:  1, sort_order:  7, name: "Easterling Warrior with banner"}
    Repo.insert! %RoleFigure{role_id: site_s4f2r1.id, figure_id: easterling_w_banner.id}

    site_s4f2r8 = Repo.insert! %Role{scenario_faction_id: site_s4f2.id, amount: 12, sort_order:  8, name: "Khandish Warriors with two-handed axe"}
    Repo.insert! %RoleFigure{role_id: site_s4f2r1.id, figure_id: khandish_w_axe.id}

    site_s4f2r9 = Repo.insert! %Role{scenario_faction_id: site_s4f2.id, amount:  6, sort_order:  9, name: "Khandish Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: site_s4f2r1.id, figure_id: khandish_w_bow.id}

    site_s4f2r10 = Repo.insert! %Role{scenario_faction_id: site_s4f2.id, amount:  5, sort_order: 10, name: "Khandish Horsemen"}
    Repo.insert! %RoleFigure{role_id: site_s4f2r1.id, figure_id: khandish_horseman.id}

    site_s4f2r11 = Repo.insert! %Role{scenario_faction_id: site_s4f2.id, amount:  5, sort_order: 11, name: "Easterling Kataphrakts"}
    Repo.insert! %RoleFigure{role_id: site_s4f2r1.id, figure_id: easterling_kataphrakt.id}

    #========================================================================
    site_s5 = Repo.insert! %Scenario{
      name: "Reprisals",
      blurb: "Dáin Ironfoot leads a dwarven raid against the Easterlings.",
      date_age: 3, date_year: 3001, date_month: 0, date_day: 0, is_canonical: true, size: 71
   }

    Repo.insert! %ScenarioResource{scenario_id: site_s5.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 5, page: 36}

    site_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s5.id, faction: :dwarves, suggested_points: 500, actual_points: 460, sort_order: 1}

    site_s5f1r1 = Repo.insert! %Role{scenario_faction_id: site_s5f1.id, amount:  1, sort_order: 1, name: "Dáin Ironfoot"}
    Repo.insert! %RoleFigure{role_id: site_s5f1r1.id, figure_id: dain.id}

    site_s5f1r2 = Repo.insert! %Role{scenario_faction_id: site_s5f1.id, amount:  1, sort_order: 2, name: "Dwarf Captain"}
    Repo.insert! %RoleFigure{role_id: site_s5f1r2.id, figure_id: dwarf_captain.id}

    site_s5f1r3 = Repo.insert! %Role{scenario_faction_id: site_s5f1.id, amount:  6, sort_order: 3, name: "Khazad Guards"}
    Repo.insert! %RoleFigure{role_id: site_s5f1r3.id, figure_id: dwarf_khazad_gd.id}

    site_s5f1r4 = Repo.insert! %Role{scenario_faction_id: site_s5f1.id, amount:  9, sort_order: 4, name: "Dwarves with bow"}
    Repo.insert! %RoleFigure{role_id: site_s5f1r4.id, figure_id: dwarf_w_bow.id}

    site_s5f1r5 = Repo.insert! %Role{scenario_faction_id: site_s5f1.id, amount:  7, sort_order: 5, name: "Dwarves with shield"}
    Repo.insert! %RoleFigure{role_id: site_s5f1r5.id, figure_id: dwarf_w_shield.id}

    site_s5f1r6 = Repo.insert! %Role{scenario_faction_id: site_s5f1.id, amount:  4, sort_order: 6, name: "Dwarves with two-handed axe"}
    Repo.insert! %RoleFigure{role_id: site_s5f1r6.id, figure_id: dwarf_w_axe.id}

    site_s5f1r7 = Repo.insert! %Role{scenario_faction_id: site_s5f1.id, amount:  1, sort_order: 7, name: "Dwarf with banner"}
    Repo.insert! %RoleFigure{role_id: site_s5f1r7.id, figure_id: dwarf_w_banner.id}

    site_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s5.id, faction: :easterlings, suggested_points: 550, actual_points: 511, sort_order: 2}

    site_s5f2r1 = Repo.insert! %Role{scenario_faction_id: site_s5f2.id, amount:  2, sort_order: 1, name: "Easterling Captains"}
    Repo.insert! %RoleFigure{role_id: site_s5f2r1.id, figure_id: easterling_captain.id}

    site_s5f2r2 = Repo.insert! %Role{scenario_faction_id: site_s5f2.id, amount: 11, sort_order: 2, name: "Easterling Warriors with shield"}
    Repo.insert! %RoleFigure{role_id: site_s5f2r2.id, figure_id: easterling_w_shield.id}

    site_s5f2r3 = Repo.insert! %Role{scenario_faction_id: site_s5f2.id, amount: 12, sort_order: 3, name: "Easterling Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: site_s5f2r3.id, figure_id: easterling_w_bow.id}

    site_s5f2r4 = Repo.insert! %Role{scenario_faction_id: site_s5f2.id, amount:  6, sort_order: 4, name: "Easterling Warriors with shield and spear"}
    Repo.insert! %RoleFigure{role_id: site_s5f2r4.id, figure_id: easterling_w_shield_spear.id}

    site_s5f2r5 = Repo.insert! %Role{scenario_faction_id: site_s5f2.id, amount:  1, sort_order: 6, name: "Easterling Warrior with banner"}
    Repo.insert! %RoleFigure{role_id: site_s5f2r5.id, figure_id: easterling_w_banner.id}

    site_s5f2r6 = Repo.insert! %Role{scenario_faction_id: site_s5f2.id, amount: 10, sort_order: 5, name: "Easterling Kataphrakts"}
    Repo.insert! %RoleFigure{role_id: site_s5f2r6.id, figure_id: easterling_kataphrakt.id}

    #========================================================================
    site_s6 = Repo.insert! %Scenario{
      name: "Strange Circumstances",
      blurb: "Cirion joins his Khandish captors to fight off an Orc raid.",
      date_age: 3, date_year: 3002, date_month: 0, date_day: 0, is_canonical: true, size: 101
   }

    Repo.insert! %ScenarioResource{scenario_id: site_s6.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 6, page: 38}

    site_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s6.id, faction: :easterlings, suggested_points: 500, actual_points: 700, sort_order: 1}

    site_s6f1r1 = Repo.insert! %Role{scenario_faction_id: site_s6f1.id, amount:  1, sort_order: 1, name: "Cirion"}
    Repo.insert! %RoleFigure{role_id: site_s6f1r1.id, figure_id: cirion.id}

    site_s6f1r2 = Repo.insert! %Role{scenario_faction_id: site_s6f1.id, amount:  1, sort_order: 2, name: "Khandish King in chariot"}
    Repo.insert! %RoleFigure{role_id: site_s6f1r2.id, figure_id: khandish_king_chariot.id}

    site_s6f1r3 = Repo.insert! %Role{scenario_faction_id: site_s6f1.id, amount:  2, sort_order: 3, name: "Khandish Chieftains on horse"}
    Repo.insert! %RoleFigure{role_id: site_s6f1r3.id, figure_id: khandish_chieftain_horse.id}

    site_s6f1r4 = Repo.insert! %Role{scenario_faction_id: site_s6f1.id, amount:  3, sort_order: 4, name: "Rangers of Gondor"}
    Repo.insert! %RoleFigure{role_id: site_s6f1r4.id, figure_id: gondor_rog.id}

    site_s6f1r5 = Repo.insert! %Role{scenario_faction_id: site_s6f1.id, amount:  8, sort_order: 5, name: "Khandish Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: site_s6f1r5.id, figure_id: khandish_w_bow.id}

    site_s6f1r6 = Repo.insert! %Role{scenario_faction_id: site_s6f1.id, amount: 16, sort_order: 6, name: "Khandish Warriors with two-handed axe"}
    Repo.insert! %RoleFigure{role_id: site_s6f1r6.id, figure_id: khandish_w_axe.id}

    site_s6f1r7 = Repo.insert! %Role{scenario_faction_id: site_s6f1.id, amount: 12, sort_order: 7, name: "Khandish Horsemen"}
    Repo.insert! %RoleFigure{role_id: site_s6f1r7.id, figure_id: khandish_horseman.id}

    site_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s6.id, faction: :mordor, suggested_points: 750, actual_points: 796, sort_order: 2}

    site_s6f2r1 = Repo.insert! %Role{scenario_faction_id: site_s6f2.id, amount:  3, sort_order:  1, name: "Orc Captains"}
    Repo.insert! %RoleFigure{role_id: site_s6f2r1.id, figure_id: orc_captain.id}

    site_s6f2r2 = Repo.insert! %Role{scenario_faction_id: site_s6f2.id, amount:  1, sort_order:  2, name: "Orc Captain on Warg"}
    Repo.insert! %RoleFigure{role_id: site_s6f2r2.id, figure_id: orc_captain_warg.id}

    site_s6f2r3 = Repo.insert! %Role{scenario_faction_id: site_s6f2.id, amount: 10, sort_order:  3, name: "Orc Warriors with shield"}
    Repo.insert! %RoleFigure{role_id: site_s6f2r3.id, figure_id: orc_w_shield.id}

    site_s6f2r4 = Repo.insert! %Role{scenario_faction_id: site_s6f2.id, amount: 12, sort_order:  4, name: "Orc Warriors with spear"}
    Repo.insert! %RoleFigure{role_id: site_s6f2r4.id, figure_id: orc_w_spear.id}

    site_s6f2r5 = Repo.insert! %Role{scenario_faction_id: site_s6f2.id, amount:  6, sort_order:  5, name: "Orc Warriors with two-handed weapon"}
    Repo.insert! %RoleFigure{role_id: site_s6f2r5.id, figure_id: orc_w_2h.id}

    site_s6f2r6 = Repo.insert! %Role{scenario_faction_id: site_s6f2.id, amount:  6, sort_order:  6, name: "Orc Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: site_s6f2r6.id, figure_id: orc_w_bow.id}

    site_s6f2r7 = Repo.insert! %Role{scenario_faction_id: site_s6f2.id, amount:  2, sort_order:  7, name: "Orc Warriors with banner"}
    Repo.insert! %RoleFigure{role_id: site_s6f2r7.id, figure_id: orc_w_banner.id}

    site_s6f2r8 = Repo.insert! %Role{scenario_faction_id: site_s6f2.id, amount:  4, sort_order:  8, name: "Warg Riders with throwing spear"}
    Repo.insert! %RoleFigure{role_id: site_s6f2r8.id, figure_id: warg_rider_spear.id}

    site_s6f2r9 = Repo.insert! %Role{scenario_faction_id: site_s6f2.id, amount:  4, sort_order:  9, name: "Warg Riders with bow"}
    Repo.insert! %RoleFigure{role_id: site_s6f2r9.id, figure_id: warg_rider_bow.id}

    site_s6f2r10 = Repo.insert! %Role{scenario_faction_id: site_s6f2.id, amount:  4, sort_order: 10, name: "Warg Riders with shield"}
    Repo.insert! %RoleFigure{role_id: site_s6f2r10.id, figure_id: warg_rider_shield.id}

    site_s6f2r11 = Repo.insert! %Role{scenario_faction_id: site_s6f2.id, amount:  1, sort_order: 11, name: "War Catapult"}
    Repo.insert! %RoleFigure{role_id: site_s6f2r11.id, figure_id: war_catapult.id}

    site_s6f2r12 = Repo.insert! %Role{scenario_faction_id: site_s6f2.id, amount:  1, sort_order: 12, name: "War Catapult Troll"}
    Repo.insert! %RoleFigure{role_id: site_s6f2r12.id, figure_id: war_catapult_troll.id}

    #========================================================================
    site_s7 = Repo.insert! %Scenario{
      name: "The Field of Celebrant",
      blurb: "Eorl the Young saves Gondor from the Khandish and their Orc allies.",
      date_age: 3, date_year: 2510, date_month: 0, date_day: 0, is_canonical: true, size: 107
   }

    Repo.insert! %ScenarioResource{scenario_id: site_s7.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 7, page: 40}

    site_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s7.id, faction: :rohan, suggested_points: 650, actual_points: 635, sort_order: 1}

    site_s7f1r1 = Repo.insert! %Role{scenario_faction_id: site_s7f1.id, amount:  1, sort_order:  1, name: "Eorl the Young on horse"}
    Repo.insert! %RoleFigure{role_id: site_s7f1r1.id, figure_id: eorl_horse.id}

    site_s7f1r2 = Repo.insert! %Role{scenario_faction_id: site_s7f1.id, amount:  2, sort_order:  2, name: "Rohan Captains on horse"}
    Repo.insert! %RoleFigure{role_id: site_s7f1r2.id, figure_id: rohan_captain_horse.id}

    site_s7f1r3 = Repo.insert! %Role{scenario_faction_id: site_s7f1.id, amount:  7, sort_order:  3, name: "Rohan Royal Guards on horse with throwing spear"}
    Repo.insert! %RoleFigure{role_id: site_s7f1r3.id, figure_id: rohan_gd_horse_spear.id}

    site_s7f1r4 = Repo.insert! %Role{scenario_faction_id: site_s7f1.id, amount: 12, sort_order:  4, name: "Riders of Rohan"}
    Repo.insert! %RoleFigure{role_id: site_s7f1r4.id, figure_id: rohan_rider.id}

    site_s7f1r5 = Repo.insert! %Role{scenario_faction_id: site_s7f1.id, amount:  6, sort_order:  5, name: "Riders of Rohan with throwing spear"}
    Repo.insert! %RoleFigure{role_id: site_s7f1r5.id, figure_id: rohan_rider_spear.id}

    site_s7f1r6 = Repo.insert! %Role{scenario_faction_id: site_s7f1.id, amount:  1, sort_order:  6, name: "Rohan Royal Guard on horse with banner"}
    Repo.insert! %RoleFigure{role_id: site_s7f1r6.id, figure_id: rohan_gd_horse_banner.id}

    site_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s7.id, faction: :easterlings, suggested_points: 800, actual_points: 949, sort_order: 2}

    site_s7f2r1 = Repo.insert! %Role{scenario_faction_id: site_s7f2.id, amount:  1, sort_order:  1, name: "Khandish King on chariot"}
    Repo.insert! %RoleFigure{role_id: site_s7f2r1.id, figure_id: khandish_king_chariot.id}

    site_s7f2r2 = Repo.insert! %Role{scenario_faction_id: site_s7f2.id, amount:  1, sort_order:  2, name: "Khandish Chieftain"}
    Repo.insert! %RoleFigure{role_id: site_s7f2r2.id, figure_id: khandish_chieftain.id}

    site_s7f2r3 = Repo.insert! %Role{scenario_faction_id: site_s7f2.id, amount:  1, sort_order:  3, name: "Khandish Chieftain on horse"}
    Repo.insert! %RoleFigure{role_id: site_s7f2r3.id, figure_id: khandish_chieftain_horse.id}

    site_s7f2r4 = Repo.insert! %Role{scenario_faction_id: site_s7f2.id, amount:  1, sort_order:  4, name: "Orc Captain"}
    Repo.insert! %RoleFigure{role_id: site_s7f2r4.id, figure_id: orc_captain.id}

    site_s7f2r5 = Repo.insert! %Role{scenario_faction_id: site_s7f2.id, amount:  8, sort_order:  5, name: "Khandish Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: site_s7f2r5.id, figure_id: khandish_w_bow.id}

    site_s7f2r6 = Repo.insert! %Role{scenario_faction_id: site_s7f2.id, amount: 16, sort_order:  6, name: "Khandish Warriors with two-handed axe"}
    Repo.insert! %RoleFigure{role_id: site_s7f2r6.id, figure_id: khandish_w_axe.id}

    site_s7f2r7 = Repo.insert! %Role{scenario_faction_id: site_s7f2.id, amount: 12, sort_order:  7, name: "Khandish horsemen"}
    Repo.insert! %RoleFigure{role_id: site_s7f2r7.id, figure_id: khandish_horseman.id}

    site_s7f2r8 = Repo.insert! %Role{scenario_faction_id: site_s7f2.id, amount:  2, sort_order:  8, name: "Khandish Charioteers with bow"}
    Repo.insert! %RoleFigure{role_id: site_s7f2r8.id, figure_id: khandish_charioteer.id}

    site_s7f2r9 = Repo.insert! %Role{scenario_faction_id: site_s7f2.id, amount: 11, sort_order:  9, name: "Orc Warriors with shield"}
    Repo.insert! %RoleFigure{role_id: site_s7f2r9.id, figure_id: orc_w_shield.id}

    site_s7f2r10 = Repo.insert! %Role{scenario_faction_id: site_s7f2.id, amount: 12, sort_order: 10, name: "Orc Warriors with spear"}
    Repo.insert! %RoleFigure{role_id: site_s7f2r10.id, figure_id: orc_w_spear.id}

    site_s7f2r11 = Repo.insert! %Role{scenario_faction_id: site_s7f2.id, amount:  6, sort_order: 11, name: "Orc Warriors with two-handed weapons"}
    Repo.insert! %RoleFigure{role_id: site_s7f2r11.id, figure_id: orc_w_2h.id}

    site_s7f2r12 = Repo.insert! %Role{scenario_faction_id: site_s7f2.id, amount:  6, sort_order: 12, name: "Orc Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: site_s7f2r12.id, figure_id: orc_w_bow.id}

    site_s7f2r13 = Repo.insert! %Role{scenario_faction_id: site_s7f2.id, amount:  1, sort_order: 13, name: "Orc Warrior with banner"}
    Repo.insert! %RoleFigure{role_id: site_s7f2r13.id, figure_id: orc_w_banner.id}

    #========================================================================
    site_s8 = Repo.insert! %Scenario{
      name: "Hunter & Hunted",
      blurb: "Easterling raiders under Khamûl encounter the defenders of Fangorn.",
      date_age: 3, date_year: 2520, date_month: 0, date_day: 0, is_canonical: true, size: 28
   }

    Repo.insert! %ScenarioResource{scenario_id: site_s8.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 8, page: 46}

    site_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s8.id, faction: :free_peoples, suggested_points: 400, actual_points: 495, sort_order: 1}

    site_s8f1r1 = Repo.insert! %Role{scenario_faction_id: site_s8f1.id, amount:  1, sort_order: 1, name: "Treebeard"}
    Repo.insert! %RoleFigure{role_id: site_s8f1r1.id, figure_id: treebeard.id}

    site_s8f1r2 = Repo.insert! %Role{scenario_faction_id: site_s8f1.id, amount:  1, sort_order: 2, name: "Gwaihir"}
    Repo.insert! %RoleFigure{role_id: site_s8f1r2.id, figure_id: gwaihir.id}

    site_s8f1r3 = Repo.insert! %Role{scenario_faction_id: site_s8f1.id, amount:  2, sort_order: 3, name: "Giant Eagles"}
    Repo.insert! %RoleFigure{role_id: site_s8f1r3.id, figure_id: eagle.id}

    site_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s8.id, faction: :easterlings, suggested_points: 450, actual_points: 430, sort_order: 2}

    site_s8f2r1 = Repo.insert! %Role{scenario_faction_id: site_s8f2.id, amount:  1, sort_order: 1, name: "Khamûl the Easterling on horse"}
    Repo.insert! %RoleFigure{role_id: site_s8f2r1.id, figure_id: khamul_horse.id}

    site_s8f2r2 = Repo.insert! %Role{scenario_faction_id: site_s8f2.id, amount:  1, sort_order: 2, name: "Khandish Mercenary Chieftain"}
    Repo.insert! %RoleFigure{role_id: site_s8f2r2.id, figure_id: khandish_chieftain.id}

    site_s8f2r3 = Repo.insert! %Role{scenario_faction_id: site_s8f2.id, amount: 10, sort_order: 3, name: "Easterling Kataphrakts"}
    Repo.insert! %RoleFigure{role_id: site_s8f2r3.id, figure_id: easterling_kataphrakt.id}

    site_s8f2r4 = Repo.insert! %Role{scenario_faction_id: site_s8f2.id, amount:  4, sort_order: 4, name: "Khandish Mercenaries with bow"}
    Repo.insert! %RoleFigure{role_id: site_s8f2r4.id, figure_id: khandish_w_bow.id}

    site_s8f2r5 = Repo.insert! %Role{scenario_faction_id: site_s8f2.id, amount:  8, sort_order: 5, name: "Khandish Mercenaries Warriors with two-handed axe"}
    Repo.insert! %RoleFigure{role_id: site_s8f2r5.id, figure_id: khandish_w_axe.id}

    #########################################################################
    # THE FALL OF THE NECROMANCER
    #########################################################################

    #========================================================================
    fotn_s1 = Repo.insert! %Scenario{
      name: "Dol Guldur Awakens",
      blurb: "Thranduil leads a warband against the creatures of Mirkwood.",
      date_age: 3,  date_year: 2060, date_month: 0, date_day: 0, is_canonical: true, size: 22
   }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s1.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 1, page: 8}
    Repo.insert! %ScenarioResource{scenario_id: fotn_s1.id, resource_type: 1, url: "https://www.youtube.com/watch?v=0_dCdLngsKs&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1}

    fotn_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s1.id, faction: :mirkwood, suggested_points: 200, actual_points: 273, sort_order: 1}

    fotn_s1f1r1 = Repo.insert! %Role{scenario_faction_id: fotn_s1f1.id, amount: 1, sort_order: 1, name: "Thranduil"}
    Repo.insert! %RoleFigure{role_id: fotn_s1f1r1.id, figure_id: thranduil.id}

    fotn_s1f1r2 = Repo.insert! %Role{scenario_faction_id: fotn_s1f1.id, amount: 3, sort_order: 2, name: "Wood Elf Sentinels"}
    Repo.insert! %RoleFigure{role_id: fotn_s1f1r2.id, figure_id: wood_elf_sentinel.id}

    fotn_s1f1r3 = Repo.insert! %Role{scenario_faction_id: fotn_s1f1.id, amount: 4, sort_order: 3, name: "Wood Elf Warriors with Elven blade and throwing dagger"}
    Repo.insert! %RoleFigure{role_id: fotn_s1f1r3.id, figure_id: wood_elf_w_blade.id}

    fotn_s1f1r4 = Repo.insert! %Role{scenario_faction_id: fotn_s1f1.id, amount: 4, sort_order: 4, name: "Wood Elf Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: fotn_s1f1r4.id, figure_id: wood_elf_w_bow.id}

    fotn_s1f1r5 = Repo.insert! %Role{scenario_faction_id: fotn_s1f1.id, amount: 4, sort_order: 5, name: "Wood Elf Warriors with spear"}
    Repo.insert! %RoleFigure{role_id: fotn_s1f1r5.id, figure_id: wood_elf_w_spear.id}

    fotn_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s1.id, faction: :dol_guldur, suggested_points: 200, actual_points: 150, sort_order: 2}

    fotn_s1f2r1 = Repo.insert! %Role{scenario_faction_id: fotn_s1f2.id, amount: 4, sort_order: 1, name: "Giant Spiders"}
    Repo.insert! %RoleFigure{role_id: fotn_s1f2r1.id, figure_id: giant_spider.id}

    fotn_s1f2r2 = Repo.insert! %Role{scenario_faction_id: fotn_s1f2.id, amount: 2, sort_order: 2, name: "Bat Swarms"}
    Repo.insert! %RoleFigure{role_id: fotn_s1f2r2.id, figure_id: bat_swarm.id}

    #========================================================================
    fotn_s2 = Repo.insert! %Scenario{
      name: "In the Nick of Time",
      blurb: "Elrond joins Thranduil against an attack from Dol Guldur lead by Khamûl.",
      date_age: 3,  date_year: 2061, date_month: 0, date_day: 0, is_canonical: true, size: 65
   }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s2.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 2, page: 10}
    Repo.insert! %ScenarioResource{scenario_id: fotn_s2.id, resource_type: 1, url: "https://www.youtube.com/watch?v=AMrP8abPj0Q&index=2&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1}

    fotn_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s2.id, faction: :mirkwood, suggested_points: 600, actual_points: 0, sort_order: 1}

    fotn_s2f1r1 = Repo.insert! %Role{scenario_faction_id: fotn_s2f1.id, amount: 1, sort_order: 1, name: "Thranduil"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f1r1.id, figure_id: thranduil.id}

    fotn_s2f1r2 = Repo.insert! %Role{scenario_faction_id: fotn_s2f1.id, amount: 1, sort_order: 2, name: "Elrond"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f1r2.id, figure_id: elrond.id}

    fotn_s2f1r3 = Repo.insert! %Role{scenario_faction_id: fotn_s2f1.id, amount: 1, sort_order: 3, name: "Legolas"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f1r3.id, figure_id: legolas.id}

    fotn_s2f1r4 = Repo.insert! %Role{scenario_faction_id: fotn_s2f1.id, amount: 3, sort_order: 4, name: "Wood Elf Sentinels"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f1r4.id, figure_id: wood_elf_sentinel.id}

    fotn_s2f1r5 = Repo.insert! %Role{scenario_faction_id: fotn_s2f1.id, amount: 3, sort_order: 5, name: "Wood Elf Warriors with Elven blade and throwing dagger"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f1r5.id, figure_id: wood_elf_w_blade.id}

    fotn_s2f1r6 = Repo.insert! %Role{scenario_faction_id: fotn_s2f1.id, amount: 4, sort_order: 6, name: "Wood Elf Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f1r6.id, figure_id: wood_elf_w_bow.id}

    fotn_s2f1r7 = Repo.insert! %Role{scenario_faction_id: fotn_s2f1.id, amount: 4, sort_order: 7, name: "Wood Elf Warriors with spear"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f1r7.id, figure_id: wood_elf_w_spear.id}

    fotn_s2f1r8 = Repo.insert! %Role{scenario_faction_id: fotn_s2f1.id, amount: 1, sort_order: 8, name: "Wood Elf Warrior with banner"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f1r8.id, figure_id: wood_elf_w_banner.id}

    fotn_s2f1r9 = Repo.insert! %Role{scenario_faction_id: fotn_s2f1.id, amount: 4, sort_order: 9, name: "High Elf Warriors with Elven blade"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f1r9.id, figure_id: high_elf_w_blade.id}

    fotn_s2f1r10 = Repo.insert! %Role{scenario_faction_id: fotn_s2f1.id, amount: 4, sort_order: 10, name: "High Elf Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f1r10.id, figure_id: high_elf_w_bow.id}

    fotn_s2f1r11 = Repo.insert! %Role{scenario_faction_id: fotn_s2f1.id, amount: 2, sort_order: 11, name: "High Elf Warriors with spear and shield"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f1r11.id, figure_id: high_elf_w_spear_shield.id}

    fotn_s2f1r12 = Repo.insert! %Role{scenario_faction_id: fotn_s2f1.id, amount: 1, sort_order: 12, name: "High Elf Warrior with banner"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f1r12.id, figure_id: high_elf_w_banner.id}

    fotn_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s2.id, faction: :dol_guldur, suggested_points: 600, actual_points: 0, sort_order: 2}

    fotn_s2f2r1 = Repo.insert! %Role{scenario_faction_id: fotn_s2f2.id, amount: 1, sort_order: 1, name: "Khamûl the Easterling"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f2r1.id, figure_id: khamul.id}

    fotn_s2f2r2 = Repo.insert! %Role{scenario_faction_id: fotn_s2f2.id, amount: 1, sort_order: 2, name: "Wild Warg Chieftain"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f2r2.id, figure_id: warg_chieftain.id}

    fotn_s2f2r3 = Repo.insert! %Role{scenario_faction_id: fotn_s2f2.id, amount: 1, sort_order: 3, name: "Orc Captain"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f2r3.id, figure_id: orc_captain.id}

    fotn_s2f2r4 = Repo.insert! %Role{scenario_faction_id: fotn_s2f2.id, amount: 7, sort_order: 4, name: "Orcs with shield"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f2r4.id, figure_id: orc_w_shield.id}

    fotn_s2f2r5 = Repo.insert! %Role{scenario_faction_id: fotn_s2f2.id, amount: 8, sort_order: 5, name: "Orcs with spear"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f2r5.id, figure_id: orc_w_spear.id}

    fotn_s2f2r6 = Repo.insert! %Role{scenario_faction_id: fotn_s2f2.id, amount: 4, sort_order: 6, name: "Orcs with two-handed weapon"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f2r6.id, figure_id: orc_w_2h.id}

    fotn_s2f2r7 = Repo.insert! %Role{scenario_faction_id: fotn_s2f2.id, amount: 4, sort_order: 7, name: "Orcs with bow"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f2r7.id, figure_id: orc_w_bow.id}

    fotn_s2f2r8 = Repo.insert! %Role{scenario_faction_id: fotn_s2f2.id, amount: 1, sort_order: 8, name: "Orc with banner"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f2r8.id, figure_id: orc_w_banner.id}

    fotn_s2f2r9 = Repo.insert! %Role{scenario_faction_id: fotn_s2f2.id, amount: 3, sort_order: 9, name: "Wild Wargs"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f2r9.id, figure_id: warg.id}

    fotn_s2f2r10 = Repo.insert! %Role{scenario_faction_id: fotn_s2f2.id, amount: 4, sort_order: 10, name: "Giant Spiders"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f2r10.id, figure_id: giant_spider.id}

    fotn_s2f2r11 = Repo.insert! %Role{scenario_faction_id: fotn_s2f2.id, amount: 2, sort_order: 11, name: "Bat Swarms"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f2r11.id, figure_id: bat_swarm.id}

    #========================================================================
    fotn_s3 = Repo.insert! %Scenario{
      name: "A Walk Through Dark Places",
      blurb: "A Rivendell band tries to protect Arwen and Círdan from the minions of Dol Guldur.",
      date_age: 3, date_year: 2062, date_month: 0, date_day: 0, is_canonical: true, size: 23
   }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s3.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 3, page: 12}
    Repo.insert! %ScenarioResource{scenario_id: fotn_s3.id, resource_type: 1, url: "https://www.youtube.com/watch?v=YN8X_azJfO8&index=3&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1}

    fotn_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s3.id, faction: :rivendell, suggested_points: 550, actual_points: 0, sort_order: 1}

    fotn_s3f1r1 = Repo.insert! %Role{scenario_faction_id: fotn_s3f1.id, amount: 1, sort_order: 1, name: "Círdan"}
    Repo.insert! %RoleFigure{role_id: fotn_s3f1r1.id, figure_id: cirdan.id}

    fotn_s3f1r2 = Repo.insert! %Role{scenario_faction_id: fotn_s3f1.id, amount: 1, sort_order: 2, name: "Arwen Evenstar"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f1r2.id, figure_id: arwen.id}
    Repo.insert! %RoleFigure{role_id: fotn_s2f1r2.id, figure_id: arwen2.id}

    fotn_s3f1r3 = Repo.insert! %Role{scenario_faction_id: fotn_s3f1.id, amount: 1, sort_order: 3, name: "Erestor"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f1r3.id, figure_id: erestor.id}

    fotn_s3f1r4 = Repo.insert! %Role{scenario_faction_id: fotn_s3f1.id, amount: 1, sort_order: 4, name: "Glorfindel, Lord of the West"}
    Repo.insert! %RoleFigure{role_id: fotn_s2f1r4.id, figure_id: glorfindel_lotw.id}

    fotn_s3f1r5 = Repo.insert! %Role{scenario_faction_id: fotn_s3f1.id, amount: 1, sort_order: 5, name: "High Elf Captain with heavy armor, shield, and Elven blade"}
    Repo.insert! %RoleFigure{role_id: fotn_s3f1r5.id, figure_id: high_elf_captain.id}

    fotn_s3f1r6 = Repo.insert! %Role{scenario_faction_id: fotn_s3f1.id, amount: 4, sort_order: 6, name: "High Elf Warriors with heavy armor and bow"}
    Repo.insert! %RoleFigure{role_id: fotn_s3f1r6.id, figure_id: high_elf_w_bow.id}

    fotn_s3f1r7 = Repo.insert! %Role{scenario_faction_id: fotn_s3f1.id, amount: 3, sort_order: 7, name: "High Elf Warriors with heavy armor and Elven blade"}
    Repo.insert! %RoleFigure{role_id: fotn_s3f1r7.id, figure_id: high_elf_w_blade.id}

    fotn_s3f1r8 = Repo.insert! %Role{scenario_faction_id: fotn_s3f1.id, amount: 1, sort_order: 8, name: "High Elf Warrior with banner"}
    Repo.insert! %RoleFigure{role_id: fotn_s3f1r8.id, figure_id: high_elf_w_banner.id}

    fotn_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s3.id, faction: :dol_guldur, suggested_points: 300, actual_points: 0, sort_order: 2}

    fotn_s3f2r1 = Repo.insert! %Role{scenario_faction_id: fotn_s3f2.id, amount: 4, sort_order: 1, name: "Castellans of Dol Guldur with Morgul Blade"}
    Repo.insert! %RoleFigure{role_id: fotn_s3f2r1.id, figure_id: castellan.id}

    fotn_s3f2r2 = Repo.insert! %Role{scenario_faction_id: fotn_s3f2.id, amount: 2, sort_order: 2, name: "Bat Swarms"}
    Repo.insert! %RoleFigure{role_id: fotn_s3f2r2.id, figure_id: bat_swarm.id}

    fotn_s3f2r3 = Repo.insert! %Role{scenario_faction_id: fotn_s3f2.id, amount: 4, sort_order: 3, name: "Wild Wargs"}
    Repo.insert! %RoleFigure{role_id: fotn_s3f2r3.id, figure_id: warg.id}

    #========================================================================
    fotn_s4 = Repo.insert! %Scenario{
      name: "Meddle Not in the Affairs of Wizards",
      blurb: "The Istari faces the minions of Dol Guldur.",
      date_age: 3, date_year: 2062, date_month: -1, date_day: 0, is_canonical: true, size: 17
   }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s4.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 4, page: 14}
    Repo.insert! %ScenarioResource{scenario_id: fotn_s4.id, resource_type: 1, url: "https://www.youtube.com/watch?v=UbIM0XE6jT8&index=4&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1}

    fotn_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s4.id, faction: :white_council, suggested_points: 500, actual_points: 0, sort_order: 1}

    fotn_s4f1r1 = Repo.insert! %Role{scenario_faction_id: fotn_s4f1.id, amount: 1, sort_order: 1, name: "Gandalf the Gray"}
    Repo.insert! %RoleFigure{role_id: fotn_s4f1r1.id, figure_id: gandalf_grey.id}

    fotn_s4f1r2 = Repo.insert! %Role{scenario_faction_id: fotn_s4f1.id, amount: 1, sort_order: 2, name: "Radagast the Brown"}
    Repo.insert! %RoleFigure{role_id: fotn_s4f1r2.id, figure_id: radagast.id}

    fotn_s4f1r3 = Repo.insert! %Role{scenario_faction_id: fotn_s4f1.id, amount: 1, sort_order: 3, name: "Saruman the White"}
    Repo.insert! %RoleFigure{role_id: fotn_s4f1r3.id, figure_id: saruman.id}

    fotn_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s4.id, faction: :dol_guldur,     suggested_points: 400, actual_points: 0, sort_order: 2}

    fotn_s4f2r1 = Repo.insert! %Role{scenario_faction_id: fotn_s4f2.id, amount: 4, sort_order: 1, name: "Castellans of Dol Guldur with Morgul Blade"}
    Repo.insert! %RoleFigure{role_id: fotn_s4f2r1.id, figure_id: castellan.id}

    fotn_s4f2r2 = Repo.insert! %Role{scenario_faction_id: fotn_s4f2.id, amount: 1, sort_order: 2, name: "Orc Captain"}
    Repo.insert! %RoleFigure{role_id: fotn_s4f2r2.id, figure_id: orc_captain.id}

    fotn_s4f2r3 = Repo.insert! %Role{scenario_faction_id: fotn_s4f2.id, amount: 2, sort_order: 3, name: "Warg Riders with throwing spear"}
    Repo.insert! %RoleFigure{role_id: fotn_s4f2r3.id, figure_id: warg_rider_spear.id}

    fotn_s4f2r4 = Repo.insert! %Role{scenario_faction_id: fotn_s4f2.id, amount: 2, sort_order: 4, name: "Warg Riders with bow"}
    Repo.insert! %RoleFigure{role_id: fotn_s4f2r4.id, figure_id: warg_rider_bow.id}

    fotn_s4f2r5 = Repo.insert! %Role{scenario_faction_id: fotn_s4f2.id, amount: 2, sort_order: 5, name: "Warg Riders with shield"}
    Repo.insert! %RoleFigure{role_id: fotn_s4f2r5.id, figure_id: warg_rider_shield.id}

    fotn_s4f2r6 = Repo.insert! %Role{scenario_faction_id: fotn_s4f2.id, amount: 3, sort_order: 6, name: "Wild Wargs"}
    Repo.insert! %RoleFigure{role_id: fotn_s4f2r6.id, figure_id: warg.id}

    #========================================================================
    fotn_s5 = Repo.insert! %Scenario{
      name: "The Lair of the Spider Queen",
      blurb: "Lothlorien attacks the beasts of Mirkwood",
      date_age: 3, date_year: 2063, date_month: 0, date_day: 0, is_canonical: true, size: 41
   }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s5.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 5, page: 16}
    Repo.insert! %ScenarioResource{scenario_id: fotn_s5.id, resource_type: :video_replay, url: "https://www.youtube.com/watch?v=eyHTP-Vjhd8&index=5&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1}

    fotn_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s5.id, faction: :lothlorien, suggested_points: 450, actual_points: 0, sort_order: 1}

    fotn_s5f1r1 = Repo.insert! %Role{scenario_faction_id: fotn_s5f1.id, amount: 1, sort_order: 1, name: "Galadriel, Lady of the Galadhrim"}
    Repo.insert! %RoleFigure{role_id: fotn_s5f1r1.id, figure_id: galadriel_lotg.id}

    fotn_s5f1r2 = Repo.insert! %Role{scenario_faction_id: fotn_s5f1.id, amount: 1, sort_order: 2, name: "Celeborn"}
    Repo.insert! %RoleFigure{role_id: fotn_s5f1r2.id, figure_id: celeborn.id}

    fotn_s5f1r3 = Repo.insert! %Role{scenario_faction_id: fotn_s5f1.id, amount: 2, sort_order: 3, name: "Wood Elf Sentinels"}
    Repo.insert! %RoleFigure{role_id: fotn_s5f1r3.id, figure_id: wood_elf_sentinel.id}

    fotn_s5f1r4 = Repo.insert! %Role{scenario_faction_id: fotn_s5f1.id, amount: 8, sort_order: 4, name: "Wood Elf Warriors with Elven blade and throwing dagger"}
    Repo.insert! %RoleFigure{role_id: fotn_s5f1r4.id, figure_id: wood_elf_w_blade.id}

    fotn_s5f1r5 = Repo.insert! %Role{scenario_faction_id: fotn_s5f1.id, amount: 8, sort_order: 5, name: "Wood Elf Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: fotn_s5f1r4.id, figure_id: wood_elf_w_bow.id}

    fotn_s5f1r6 = Repo.insert! %Role{scenario_faction_id: fotn_s5f1.id, amount: 8, sort_order: 6, name: "Wood Elf Warriors with spear"}
    Repo.insert! %RoleFigure{role_id: fotn_s5f1r4.id, figure_id: wood_elf_w_spear.id}

    fotn_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s5.id, faction: :dol_guldur, suggested_points: 300, actual_points: 0, sort_order: 2}

    fotn_s5f2r1 = Repo.insert! %Role{scenario_faction_id: fotn_s5f2.id, amount: 1, sort_order: 1, name: "Spider Queen"}
    Repo.insert! %RoleFigure{role_id: fotn_s5f2r1.id, figure_id: spider_queen.id}

    fotn_s5f2r2 = Repo.insert! %Role{scenario_faction_id: fotn_s5f2.id, amount: 4, sort_order: 2, name: "Giant Spiders"}
    Repo.insert! %RoleFigure{role_id: fotn_s5f2r2.id, figure_id: giant_spider.id}

    fotn_s5f2r3 = Repo.insert! %Role{scenario_faction_id: fotn_s5f2.id, amount: 2, sort_order: 3, name: "Bat Swarms"}
    Repo.insert! %RoleFigure{role_id: fotn_s5f2r3.id, figure_id: bat_swarm.id}

    fotn_s5f2r4 = Repo.insert! %Role{scenario_faction_id: fotn_s5f2.id, amount: 6, sort_order: 4, name: "Wild Wargs"}
    Repo.insert! %RoleFigure{role_id: fotn_s5f2r4.id, figure_id: warg.id}

    #========================================================================
    fotn_s6 = Repo.insert! %Scenario{
      name: "In the Shadow of Dol Guldur",
      blurb: "Elrond's elves fight a Ringwraith-led Dol Guldur army.",
      date_age: 3, date_year: 2850, date_month: 0, date_day: 0, is_canonical: true, size: 91
   }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s6.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 6, page: 18}
    Repo.insert! %ScenarioResource{scenario_id: fotn_s6.id, resource_type: :video_replay, url: "https://www.youtube.com/watch?v=Cug7stLutRQ&index=6&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1}

    fotn_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s6.id, faction: :rivendell,  suggested_points: 700, actual_points: 0, sort_order: 1}

    fotn_s6f1r1 = Repo.insert! %Role{scenario_faction_id: fotn_s6f1.id, amount: 1, sort_order: 1, name: "Elrond"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f1r1.id, figure_id: elrond.id}

    fotn_s6f1r2 = Repo.insert! %Role{scenario_faction_id: fotn_s6f1.id, amount: 3, sort_order: 2, name: "Wood Elf Sentinels"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f1r2.id, figure_id: wood_elf_sentinel.id}

    fotn_s6f1r3 = Repo.insert! %Role{scenario_faction_id: fotn_s6f1.id, amount: 8, sort_order: 3, name: "High Elf Warriors with shield and spear"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f1r3.id, figure_id: high_elf_w_spear_shield.id}

    fotn_s6f1r4 = Repo.insert! %Role{scenario_faction_id: fotn_s6f1.id, amount: 8, sort_order: 4, name: "High Elf Warriors with Elven blade"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f1r4.id, figure_id: high_elf_w_blade.id}

    fotn_s6f1r5 = Repo.insert! %Role{scenario_faction_id: fotn_s6f1.id, amount: 8, sort_order: 5, name: "High Elf Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f1r5.id, figure_id: high_elf_w_bow.id}

    fotn_s6f1r6 = Repo.insert! %Role{scenario_faction_id: fotn_s6f1.id, amount: 1, sort_order: 6, name: "High Elf Warrior with banner"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f1r6.id, figure_id: high_elf_w_banner.id}

    fotn_s6f1r7 = Repo.insert! %Role{scenario_faction_id: fotn_s6f1.id, amount: 8, sort_order: 7, name: "Wood Elf Warriors with shield and spear"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f1r7.id, figure_id: wood_elf_w_spear.id}

    fotn_s6f1r8 = Repo.insert! %Role{scenario_faction_id: fotn_s6f1.id, amount: 7, sort_order: 8, name: "Wood Elf Warriors with Elven blade"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f1r8.id, figure_id: wood_elf_w_blade.id}

    fotn_s6f1r9 = Repo.insert! %Role{scenario_faction_id: fotn_s6f1.id, amount: 8, sort_order: 9, name: "Wood Elf Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f1r9.id, figure_id: wood_elf_w_bow.id}

    fotn_s6f1r10 = Repo.insert! %Role{scenario_faction_id: fotn_s6f1.id, amount: 1, sort_order: 10, name: "Wood Elf Warrior with banner"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f1r10.id, figure_id: wood_elf_w_banner.id}

    fotn_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s6.id, faction: :dol_guldur, suggested_points: 800, actual_points: 0, sort_order: 2}

    fotn_s6f2r1 = Repo.insert! %Role{scenario_faction_id: fotn_s6f2.id, amount: 1, sort_order: 1, name: "Ringwraith"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f2r1.id, figure_id: ringwraith.id}

    fotn_s6f2r2 = Repo.insert! %Role{scenario_faction_id: fotn_s6f2.id, amount: 1, sort_order: 2, name: "Wild Warg Chieftain"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f2r2.id, figure_id: warg_chieftain.id}

    fotn_s6f2r3 = Repo.insert! %Role{scenario_faction_id: fotn_s6f2.id, amount: 1, sort_order: 3, name: "Orc Captain"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f2r3.id, figure_id: orc_captain.id}

    fotn_s6f2r4 = Repo.insert! %Role{scenario_faction_id: fotn_s6f2.id, amount: 1, sort_order: 4, name: "Castellan of Dol Guldur"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f2r4.id, figure_id: castellan.id}

    fotn_s6f2r5 = Repo.insert! %Role{scenario_faction_id: fotn_s6f2.id, amount: 7, sort_order: 5, name: "Orc Warriors with shield"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f2r5.id, figure_id: orc_w_shield.id}

    fotn_s6f2r6 = Repo.insert! %Role{scenario_faction_id: fotn_s6f2.id, amount: 8, sort_order: 6, name: "Orc Warriors with spear"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f2r6.id, figure_id: orc_w_spear.id}

    fotn_s6f2r7 = Repo.insert! %Role{scenario_faction_id: fotn_s6f2.id, amount: 4, sort_order: 7, name: "Orc Warriors with two-handed weapon"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f2r7.id, figure_id: orc_w_2h.id}

    fotn_s6f2r8 = Repo.insert! %Role{scenario_faction_id: fotn_s6f2.id, amount: 4, sort_order: 8, name: "Orc Warriors with bow"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f2r8.id, figure_id: orc_w_bow.id}

    fotn_s6f2r9 = Repo.insert! %Role{scenario_faction_id: fotn_s6f2.id, amount: 1, sort_order: 9, name: "Orc Warrior with banner"}
    Repo.insert! %RoleFigure{role_id: fotn_s6f2r9.id, figure_id: orc_w_banner.id}

    #========================================================================
    fotn_s7 = Repo.insert! %Scenario{
      name: "The Fall of the Necromancer",
      blurb: "The White Council battles the Necromancer himself at Dol Guldur.",
      date_age: 3, date_year: 2851, date_month: 0, date_day: 0, is_canonical: true, size: 29
   }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s7.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 7, page: 20}
    Repo.insert! %ScenarioResource{scenario_id: fotn_s7.id, resource_type: :video_replay, url: "https://www.youtube.com/watch?v=2J5px0_J2wQ&index=7&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1}

    fotn_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s7.id, faction: :rivendell,  suggested_points: 1500, actual_points: 0, sort_order: 1}

    fotn_s7f1r1 = Repo.insert! %Role{scenario_faction_id: fotn_s7f1.id, amount: 1, sort_order: 1, name: "Gandalf the Grey"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f1r1.id, figure_id: gandalf_grey.id}

    fotn_s7f1r2 = Repo.insert! %Role{scenario_faction_id: fotn_s7f1.id, amount: 1, sort_order: 2, name: "Saruman the White"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f1r2.id, figure_id: saruman.id}

    fotn_s7f1r3 = Repo.insert! %Role{scenario_faction_id: fotn_s7f1.id, amount: 1, sort_order: 3, name: "Radagast the Brown"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f1r3.id, figure_id: radagast.id}

    fotn_s7f1r4 = Repo.insert! %Role{scenario_faction_id: fotn_s7f1.id, amount: 1, sort_order: 4, name: "Arwen Evenstar"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f1r4.id, figure_id: arwen.id}
    Repo.insert! %RoleFigure{role_id: fotn_s7f1r4.id, figure_id: arwen2.id}

    fotn_s7f1r5 = Repo.insert! %Role{scenario_faction_id: fotn_s7f1.id, amount: 1, sort_order: 5, name: "Círdan"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f1r5.id, figure_id: cirdan.id}

    fotn_s7f1r6 = Repo.insert! %Role{scenario_faction_id: fotn_s7f1.id, amount: 1, sort_order: 6, name: "Glorfindel, Lord of the West"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f1r6.id, figure_id: glorfindel_lotw.id}

    fotn_s7f1r7 = Repo.insert! %Role{scenario_faction_id: fotn_s7f1.id, amount: 1, sort_order: 7, name: "Erestor"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f1r7.id, figure_id: erestor.id}

    fotn_s7f1r8 = Repo.insert! %Role{scenario_faction_id: fotn_s7f1.id, amount: 1, sort_order: 8, name: "Elrond"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f1r8.id, figure_id: elrond.id}

    fotn_s7f1r9 = Repo.insert! %Role{scenario_faction_id: fotn_s7f1.id, amount: 1, sort_order: 9, name: "Galadriel, Lady of the Galadhrim"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f1r9.id, figure_id: galadriel_lotg.id}

    fotn_s7f1r10 = Repo.insert! %Role{scenario_faction_id: fotn_s7f1.id, amount: 1, sort_order: 10, name: "Celeborn"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f1r10.id, figure_id: celeborn.id}

    fotn_s7f1r11 = Repo.insert! %Role{scenario_faction_id: fotn_s7f1.id, amount: 1, sort_order: 11, name: "Thranduil"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f1r11.id, figure_id: thranduil.id}

    fotn_s7f1r12 = Repo.insert! %Role{scenario_faction_id: fotn_s7f1.id, amount: 1, sort_order: 12, name: "Legolas"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f1r12.id, figure_id: legolas.id}

    fotn_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s7.id, faction: :dol_guldur, suggested_points: 1400, actual_points: 0, sort_order: 2}

    fotn_s7f2r1 = Repo.insert! %Role{scenario_faction_id: fotn_s7f2.id, amount: 1, sort_order: 1, name: "The Necromancer"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f2r1.id, figure_id: necromancer.id}

    fotn_s7f2r2 = Repo.insert! %Role{scenario_faction_id: fotn_s7f2.id, amount: 1, sort_order: 2, name: "Khamûl the Easterling"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f2r2.id, figure_id: khamul.id}

    fotn_s7f2r3 = Repo.insert! %Role{scenario_faction_id: fotn_s7f2.id, amount: 5, sort_order: 3, name: "Ringwraiths"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f2r3.id, figure_id: ringwraith.id}

    fotn_s7f2r4 = Repo.insert! %Role{scenario_faction_id: fotn_s7f2.id, amount: 4, sort_order: 4, name: "Castellans of Dol Guldur with Morgul Blade"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f2r4.id, figure_id: castellan.id}

    fotn_s7f2r5 = Repo.insert! %Role{scenario_faction_id: fotn_s7f2.id, amount: 1, sort_order: 5, name: "Troll Chieftain"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f2r5.id, figure_id: troll_chieftain.id}

    fotn_s7f2r6 = Repo.insert! %Role{scenario_faction_id: fotn_s7f2.id, amount: 1, sort_order: 6, name: "Mordor Troll"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f2r6.id, figure_id: mordor_troll.id}

    fotn_s7f2r7 = Repo.insert! %Role{scenario_faction_id: fotn_s7f2.id, amount: 4, sort_order: 6, name: "Giant Spiders"}
    Repo.insert! %RoleFigure{role_id: fotn_s7f2r7.id, figure_id: giant_spider.id}

    #########################################################################
    # THE TWO TOWERS JOURNEYBOOK
    #########################################################################
    tttjb_s8 = Repo.insert! %Scenario{
      name: "The Last March of the Ents",
      blurb: "The Ents storm Isengard",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, is_canonical: true, size: 40
   }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s8.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 8, page: 38}
    Repo.insert! %ScenarioResource{scenario_id: tttjb_s8.id, resource_type: :web_replay, title: "Dave T", url: "http://www.davetownsend.org/Battles/LotR-20150922/", sort_order: 1}
    Repo.insert! %ScenarioResource{scenario_id: tttjb_s8.id, resource_type: :web_replay, title: "Dave T", url: "http://www.davetownsend.org/Battles/LotR-20151011/", sort_order: 2}

    tttjb_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s8.id, faction: :free_peoples, suggested_points: 550, actual_points: 0, sort_order: 1}

    tttjb_s8f1r1 = Repo.insert! %Role{scenario_faction_id: tttjb_s8f1.id, amount: 1, sort_order: 1, name: "Treebeard"}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f1r1.id, figure_id: treebeard.id}

    tttjb_s8f1r2 = Repo.insert! %Role{scenario_faction_id: tttjb_s8f1.id, amount: 3, sort_order: 2, name: "Ents"}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f1r2.id, figure_id: ent.id}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f1r2.id, figure_id: ash_tree_giant.id}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f1r2.id, figure_id: birch_tree_giant.id}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f1r2.id, figure_id: linden_tree_giant.id}

    tttjb_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s8.id, faction: :isengard, suggested_points: 575, actual_points: 0, sort_order: 2}

    tttjb_s8f2r1 = Repo.insert! %Role{scenario_faction_id: tttjb_s8f2.id, amount: 1, sort_order: 1, name: "Uruk-hai Captain with shield"}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f2r1.id, figure_id: uruk_hai_captain_shield.id}

    tttjb_s8f2r2 = Repo.insert! %Role{scenario_faction_id: tttjb_s8f2.id, amount: 1, sort_order: 2, name: "Orc Captain with shield"}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f2r1.id, figure_id: orc_captain.id}

    tttjb_s8f2r3 = Repo.insert! %Role{scenario_faction_id: tttjb_s8f2.id, amount: 1, sort_order: 3, name: "Isengard Troll"}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f2r1.id, figure_id: isengard_troll.id}

    tttjb_s8f2r4 = Repo.insert! %Role{scenario_faction_id: tttjb_s8f2.id, amount: 5, sort_order: 4, name: "Uruk-hai Warriors with pike"}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f2r1.id, figure_id: uruk_hai_w_pike.id}

    tttjb_s8f2r5 = Repo.insert! %Role{scenario_faction_id: tttjb_s8f2.id, amount: 5, sort_order: 5, name: "Uruk-hai Warriors with shield"}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f2r1.id, figure_id: uruk_hai_w_shield.id}

    tttjb_s8f2r6 = Repo.insert! %Role{scenario_faction_id: tttjb_s8f2.id, amount: 3, sort_order: 6, name: "Uruk-hai Warriors with crossbow"}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f2r1.id, figure_id: uruk_hai_w_crossbow.id}

    tttjb_s8f2r7 = Repo.insert! %Role{scenario_faction_id: tttjb_s8f2.id, amount: 3, sort_order: 7, name: "Uruk-hai Berserkers"}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f2r1.id, figure_id: uruk_hai_berserker.id}

    tttjb_s8f2r8 = Repo.insert! %Role{scenario_faction_id: tttjb_s8f2.id, amount: 3, sort_order: 8, name: "Feral Uruk-hai"}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f2r1.id, figure_id: uruk_hai_feral.id}

    tttjb_s8f2r9 = Repo.insert! %Role{scenario_faction_id: tttjb_s8f2.id, amount: 4, sort_order: 9, name: "Orcs with shield"}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f2r1.id, figure_id: orc_w_shield.id}

    tttjb_s8f2r10 = Repo.insert! %Role{scenario_faction_id: tttjb_s8f2.id, amount: 4, sort_order: 10, name: "Orcs with spear"}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f2r1.id, figure_id: orc_w_spear.id}

    tttjb_s8f2r11 = Repo.insert! %Role{scenario_faction_id: tttjb_s8f2.id, amount: 2, sort_order: 11, name: "Orcs with bow"}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f2r1.id, figure_id: orc_w_bow.id}

    tttjb_s8f2r12 = Repo.insert! %Role{scenario_faction_id: tttjb_s8f2.id, amount: 2, sort_order: 12, name: "Orcs with two-handed weapon"}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f2r1.id, figure_id: orc_w_2h.id}

    tttjb_s8f2r13 = Repo.insert! %Role{scenario_faction_id: tttjb_s8f2.id, amount: 1, sort_order: 13, name: "Uruk-hai Warrior with banner"}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f2r1.id, figure_id: uruk_hai_w_banner.id}

    tttjb_s8f2r14 = Repo.insert! %Role{scenario_faction_id: tttjb_s8f2.id, amount: 1, sort_order: 14, name: "Orc Warrior with banner"}
    Repo.insert! %RoleFigure{role_id: tttjb_s8f2r1.id, figure_id: orc_w_banner.id}

    #########################################################################
    # USER_SCENARIOS
    #########################################################################
    Repo.insert! %UserScenario{user_id: 1, scenario_id: site_s1.id, owned: 20, painted: 6}
  end
end

SbgInv.Data.generate
