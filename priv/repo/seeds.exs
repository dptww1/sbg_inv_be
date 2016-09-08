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

  def generate do
    _generate
  end

  defp _declare_role_figure(faction, amount, sort_order, name \\ "", figure_list) do
    role = Repo.insert! %Role{
      scenario_faction_id: faction.id,
      amount: amount,
      sort_order: sort_order,
      name: if(name != "", do: name, else: if(amount > 1, do: hd(figure_list).plural_name, else: hd(figure_list).name))
    }

    Enum.each figure_list, fn(fig) -> Repo.insert %RoleFigure{role_id: role.id, figure_id: fig.id} end
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
    # FIGURES: FELLOWSHIP
    #########################################################################

    aragorn       = Repo.insert! %Figure{name: "Aragorn"}
    aragorn_horse = Repo.insert! %Figure{name: "Aragorn on horse"}
    gimli         = Repo.insert! %Figure{name: "Gimli"}
    legolas       = Repo.insert! %Figure{name: "Legolas"}
    legolas_horse = Repo.insert! %Figure{name: "Legolas on horse"}

    #########################################################################
    # FIGURES: FREE PEOPLES
    #########################################################################

    cirdan              = Repo.insert! %Figure{name: "Círdan"}
    gandalf_grey        = Repo.insert! %Figure{name: "Gandalf the Grey"}
    gandalf_white       = Repo.insert! %Figure{name: "Gandalf the White"}
    gandalf_white_horse = Repo.insert! %Figure{name: "Gandalf the White on horse"}
    gwaihir             = Repo.insert! %Figure{name: "Gwaihir"}
    radagast            = Repo.insert! %Figure{name: "Radagast"}
    saruman             = Repo.insert! %Figure{name: "Saruman the White"}
    treebeard           = Repo.insert! %Figure{name: "Treebeard"}

    eagle = Repo.insert! %Figure{name: "Giant Eagle", plural_name: "Giant Eagles"}
    ent   = Repo.insert! %Figure{name: "Ent",         plural_name: "Ents"}

    #########################################################################
    # FIGURES: GONDOR
    #########################################################################

    beregond      = Repo.insert! %Figure{name: "Beregond"}
    boromir       = Repo.insert! %Figure{name: "Boromir"}
    damrod        = Repo.insert! %Figure{name: "Damrod"}
    denethor      = Repo.insert! %Figure{name: "Denethor"}
    cirion        = Repo.insert! %Figure{name: "Cirion"}
    faramir       = Repo.insert! %Figure{name: "Faramir"}
    madril        = Repo.insert! %Figure{name: "Madril"}
    pippin_gondor = Repo.insert! %Figure{name: "Pippin"}

    gondor_captain_mt = Repo.insert! %Figure{name: "Captain of Minas Tirith", plural_name: "Captains of Minas Tirith"}

    gondor_citadel_gd_spear  = Repo.insert! %Figure{name: "Citadel Guard with spear",                      plural_name: "Citadel Guards with spear"}
    gondor_citadel_gd_bow    = Repo.insert! %Figure{name: "Citadel Guard with longbow",                    plural_name: "Citadel Guards with longbow"}
    gondor_knight            = Repo.insert! %Figure{name: "Knight of Minas Tirith",                        plural_name: "Knights of Minas Tirith"}
    gondor_rog               = Repo.insert! %Figure{name: "Ranger of Gondor",                              plural_name: "Rangers of Gondor"}
    gondor_womt_banner       = Repo.insert! %Figure{name: "Warrior of Minas Tirith with banner",           plural_name: "Warriors of Minas Tirith with banner"}
    gondor_womt_bow          = Repo.insert! %Figure{name: "Warrior of Minas Tirith with bow",              plural_name: "Warriors of Minas Tirith with bow"}
    gondor_womt_shield       = Repo.insert! %Figure{name: "Warrior of Minas Tirith with shield",           plural_name: "Warriors of Minas Tirith with shield"}
    gondor_womt_spear_shield = Repo.insert! %Figure{name: "Warrior of Minas Tirith with spear and shield", plural_name: "Warriors of Minas Tirith with spear and shield"}

    avenger        = Repo.insert! %Figure{name: "Avenger Bolt Thrower",      plural_name: "Avenger Bolt Throwers"}
    avenger_crew   = Repo.insert! %Figure{name: "Avenger Bolt Thrower crew", plural_name: "Avenger Bolt Thrower crew"}
    trebuchet      = Repo.insert! %Figure{name: "Battlecry Trebuchet",       plural_name: "Battlecry Trebuchets"}
    trebuchet_crew = Repo.insert! %Figure{name: "Battlecry Trebuchet crew",  plural_name: "Battlecry Trebuchet crew"}

    #########################################################################
    # FIGURES: ISENGARD
    #########################################################################

    dunlending_chieftain    = Repo.insert! %Figure{name: "Dunlending Chieftain",         plural_name: "Dunlending Chieftains"}
    uruk_hai_captain_shield = Repo.insert! %Figure{name: "Uruk-hai Captain with shield", plural_name: "Uruk-hai Captains with shield"}

    dunlending_w            = Repo.insert! %Figure{name: "Dunlending",                           plural_name: "Dunlendings"}
    dunlending_w_banner     = Repo.insert! %Figure{name: "Dunlending with banner",               plural_name: "Dunlendings with banner"}
    dunlending_w_2h         = Repo.insert! %Figure{name: "Dunlending with two-handed weapon",    plural_name: "Dunlendings with two-handed weapon"}
    uruk_hai_berserker      = Repo.insert! %Figure{name: "Uruk-hai Berserker",                   plural_name: "Uruk-hai Berserkers"}
    uruk_hai_feral          = Repo.insert! %Figure{name: "Feral Uruk-hai",                       plural_name: "Feral Uruk-hai"}
    uruk_hai_s              = Repo.insert! %Figure{name: "Uruk-hai Scout",                       plural_name: "Uruk-hai Scouts"}
    uruk_hai_s_sword_shield = Repo.insert! %Figure{name: "Uruk-hai Scout with sword and shield", plural_name: "Uruk-hai Scouts with sword and shield"}
    uruk_hai_s_bow          = Repo.insert! %Figure{name: "Uruk-hai Scout with bow",              plural_name: "Uruk-hai Scouts with bow"}
    uruk_hai_shaman         = Repo.insert! %Figure{name: "Uruk-hai Shaman",                      plural_name: "Uruk-hai Shamans"}
    uruk_hai_w_banner       = Repo.insert! %Figure{name: "Uruk-hai Warrior with banner",         plural_name: "Uruk-hai Warriors with banner"}
    uruk_hai_w_crossbow     = Repo.insert! %Figure{name: "Uruk-hai Warrior with crossbow",       plural_name: "Uruk-hai Warriors with crossbow"}
    uruk_hai_w_pike         = Repo.insert! %Figure{name: "Uruk-hai Warrior with pike",           plural_name: "Uruk-hai Warriors with pike"}
    uruk_hai_w_shield       = Repo.insert! %Figure{name: "Uruk-hai Warrior with shield",         plural_name: "Uruk-hai Warriors with shield"}

    isengard_troll = Repo.insert! %Figure{name: "Isengard Troll"}

    uruk_hai_demo_team     = Repo.insert! %Figure{name: "Uruk-hai Demolition Team",      plural_name: "Uruk-hai Demolition Team"}
    uruk_hai_ballista      = Repo.insert! %Figure{name: "Uruk-hai Siege Ballista",       plural_name: "Uruk-hai Siege Ballistas"}
    uruk_hai_ballista_crew = Repo.insert! %Figure{name: "Uruk-hai Siege Ballista crew",  plural_name: "Uruk-hai Siege Ballista crew"}

    #########################################################################
    # FIGURES: LOTHLORIEN
    #########################################################################

    celeborn       = Repo.insert! %Figure{name: "Celeborn"}
    galadriel_lotg = Repo.insert! %Figure{name: "Galadriel, Lady of the Galadhrim"}
    haldir         = Repo.insert! %Figure{name: "Haldir"}

    wood_elf_w_bow   = Repo.insert! %Figure{name: "Wood Elf Warrior with Elf bow",     plural_name: "Wood Elf Warriors with Elf bow"}
    wood_elf_w_blade = Repo.insert! %Figure{name: "Wood Elf Warrior with Elven blade", plural_name: "Wood Elf Warriors with Elven blade"}

    #########################################################################
    # FIGURES: MIRKWOOD
    #########################################################################

    thranduil = Repo.insert! %Figure{name: "Thranduil" }

    wood_elf_sentinel = Repo.insert! %Figure{name: "Wood Elf Sentinel", plural_name: "Wood Elf Sentinels"}
    wood_elf_w_banner = Repo.insert! %Figure{name: "Wood Elf Warrior with banner",                          plural_name: "Wood Elf Warriors with banner"}
    wood_elf_w_blade  = Repo.insert! %Figure{name: "Wood Elf Warrior with Elven blade and throwing dagger", plural_name: "Wood Elf Warriors with Elven blade and throwing dagger"}
    wood_elf_w_banner = Repo.insert! %Figure{name: "Wood Elf Warrior with banner",                          plural_name: "Wood Elf Warriors with banner"}
    wood_elf_w_bow    = Repo.insert! %Figure{name: "Wood Elf Warrior with bow",                             plural_name: "Wood Elf Warriors with bow"}
    wood_elf_w_spear  = Repo.insert! %Figure{name: "Wood Elf Warrior with spear",                           plural_name: "Wood Elf Warriors with spear"}

    #########################################################################
    # FIGURES: MORDOR
    #########################################################################

    gothmog          = Repo.insert! %Figure{name: "Gothmog"}
    witch_king_horse = Repo.insert! %Figure{name: "Witch-king of Angmar on horse"}

    orc_captain      = Repo.insert! %Figure{name: "Orc Captain",         plural_name: "Orc Captains"}
    orc_captain_warg = Repo.insert! %Figure{name: "Orc Captain on Warg", plural_name: "Orc Captains on Warg"}
    orc_shaman       = Repo.insert! %Figure{name: "Orc Shaman",          plural_name: "Orc Shamans"}
    ringwraith       = Repo.insert! %Figure{name: "Ringwraith",          plural_name: "Ringwraiths"}
    troll_chieftain  = Repo.insert! %Figure{name: "Troll Chieftain",     plural_name: "Troll Chieftain"}

    m_uruk_hai_shield       = Repo.insert! %Figure{name: "Mordor Uruk-hai with shield",        plural_name: "Mordor Uruk-hai with shield"}
    m_uruk_hai_2h           = Repo.insert! %Figure{name: "Mordor Uruk-hai with two-handed weapon", plural_name: "Mordor Uruk-hai with two-handed weapon"}
    mordor_troll            = Repo.insert! %Figure{name: "Mordor Troll",                       plural_name: "Mordor Trolls"}
    orc_tracker             = Repo.insert! %Figure{name: "Orc Tracker",                        plural_name: "Orc Trackers"}
    orc_m_shield_spear      = Repo.insert! %Figure{name: "Morannon Orc with shield and spear", plural_name: "Morannon Orcs with shield and spear"}
    orc_w_banner            = Repo.insert! %Figure{name: "Orc with banner",                    plural_name: "Orcs with banner"}
    orc_w_bow               = Repo.insert! %Figure{name: "Orc with Orc bow",                   plural_name: "Orcs with Orc bow"}
    orc_w_shield            = Repo.insert! %Figure{name: "Orc with shield",                    plural_name: "Orcs with shield"}
    orc_w_spear             = Repo.insert! %Figure{name: "Orc with spear",                     plural_name: "Orcs with spear"}
    orc_w_2h                = Repo.insert! %Figure{name: "Orc with two-handed weapon",         plural_name: "Orcs with two-handed weapon"}
    warg_rider_bow          = Repo.insert! %Figure{name: "Warg Rider with bow",                plural_name: "Warg Riders with bow"}
    warg_rider_shield       = Repo.insert! %Figure{name: "Warg Rider with shield",             plural_name: "Warg Riders with shield"}
    warg_rider_shield_spear = Repo.insert! %Figure{name: "Warg Rider with shield and throwing spear", plural_name: "Warg Riders with shield and throwing spear"}
    warg_rider_spear        = Repo.insert! %Figure{name: "Warg Rider with spear",              plural_name: "Warg Riders with spear"}

    mordor_siege_bow     = Repo.insert! %Figure{name: "Mordor Siege Bow",          plural_name: "Mordor Siege Bows"}
    mordor_siege_bow_orc = Repo.insert! %Figure{name: "Mordor Siege Bow Orc crew", plural_name: "Mordor Siege Bow Orc crew" }
    war_catapult         = Repo.insert! %Figure{name: "War Catapult",              plural_name: "War Catapults"}
    war_catapult_orc     = Repo.insert! %Figure{name: "War Catapult Orc crew",     plural_name: "War Catapult Orc crew" }
    war_catapult_troll   = Repo.insert! %Figure{name: "War Catapult Troll",        plural_name: "War Catapult Trolls"}

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

    eomer_horse   = Repo.insert! %Figure{name: "Eomer on horse"}
    eorl_horse    = Repo.insert! %Figure{name: "Eorl the Young on horse"}
    gamling       = Repo.insert! %Figure{name: "Gamling"}
    gamling_horse = Repo.insert! %Figure{name: "Gamling on horse with banner"}
    theoden       = Repo.insert! %Figure{name: "Théoden"}
    theoden_horse = Repo.insert! %Figure{name: "Théoden on horse"}

    rohan_captain_horse = Repo.insert! %Figure{name: "Captain of Rohan on horse", plural_name: "Captains of Rohan on horse"}

    rohan_gd              = Repo.insert! %Figure{name: "Rohan Royal Guard",                               plural_name: "Rohan Royal Guards"}
    rohan_gd_horse_spear  = Repo.insert! %Figure{name: "Rohan Royal Guard with throwing spear on horse",  plural_name: "Rohan Royal Guards with throwing spear on horse"}
    rohan_gd_horse_banner = Repo.insert! %Figure{name: "Rohan Royal Guard with banner",                   plural_name: "Rohan Royal Guards with banner"}
    rohan_rider           = Repo.insert! %Figure{name: "Rider of Rohan",                                  plural_name: "Riders of Rohan"}
    rohan_rider_banner    = Repo.insert! %Figure{name: "Rider of Rohan with banner",                      plural_name: "Riders of Rohan with banner"}
    rohan_rider_spear     = Repo.insert! %Figure{name: "Rider of Rohan with throwing spear",              plural_name: "Riders of Rohan with throwing spear"}
    rohan_w_banner        = Repo.insert! %Figure{name: "Warrior of Rohan with banner",                    plural_name: "Warriors of Rohan with banner"}
    rohan_w_bow           = Repo.insert! %Figure{name: "Warrior of Rohan with bow",                       plural_name: "Warriors of Rohan with bow"}
    rohan_w_spear_shield  = Repo.insert! %Figure{name: "Warrior of Rohan with throwing spear and shield", plural_name: "Warriors of Rohan with throwing spear and shield"}

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
    _declare_role_figure(site_s1f1, 1, 1, [ cirion ])
    _declare_role_figure(site_s1f1, 4, 2, [ gondor_womt_spear_shield ])
    _declare_role_figure(site_s1f1, 4, 3, [ gondor_womt_shield ])
    _declare_role_figure(site_s1f1, 4, 4, [ gondor_womt_bow ])
    _declare_role_figure(site_s1f1, 6, 5, [ gondor_rog ])

    site_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s1.id, faction: :easterlings, suggested_points: 200, actual_points: 220, sort_order: 2}
    _declare_role_figure(site_s1f2, 1, 1, [ khamul ])
    _declare_role_figure(site_s1f2, 4, 2, [ easterling_w_shield ])
    _declare_role_figure(site_s1f2, 4, 3, [ easterling_w_bow ])
    _declare_role_figure(site_s1f2, 2, 4, [ easterling_w_shield_spear ])

    #========================================================================
    site_s2 = Repo.insert! %Scenario{
      name: "Pursuit Through Ithilien",
      blurb: "Easterlings pursue Cirion after the fall of Amon Barad.",
      date_age: 3, date_year: 2998, date_month: -3, date_day: 0, is_canonical: true, size: 28
   }

    Repo.insert! %ScenarioResource{scenario_id: site_s2.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 2, page: 16}
    Repo.insert! %ScenarioResource{scenario_id: site_s2.id, resource_type: :web_replay, title: "Dave T", url: "http://davetownsend.org/Battles/LotR-20160727/", sort_order: 1}

    site_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s2.id, faction: :gondor, suggested_points: 275, actual_points: 279, sort_order: 1}
    _declare_role_figure(site_s2f1, 1, 1, [ cirion ])
    _declare_role_figure(site_s2f1, 1, 2, [ murin ])
    _declare_role_figure(site_s2f1, 1, 3, [ drar ])
    _declare_role_figure(site_s2f1, 2, 4, [ gondor_womt_spear_shield ])
    _declare_role_figure(site_s2f1, 2, 5, [ gondor_womt_shield ])
    _declare_role_figure(site_s2f1, 2, 6, [ gondor_womt_bow ])
    _declare_role_figure(site_s2f1, 3, 7, [ gondor_rog ])

    site_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s2.id, faction: :easterlings, suggested_points: 225, actual_points: 197, sort_order: 2}
    _declare_role_figure(site_s2f2, 1, 1, [ easterling_captain ])
    _declare_role_figure(site_s2f2, 4, 2, [ easterling_w_shield ])
    _declare_role_figure(site_s2f2, 4, 3, [ easterling_w_bow ])
    _declare_role_figure(site_s2f2, 2, 4, [ easterling_w_shield_spear ])
    _declare_role_figure(site_s2f2, 5, 5, [ easterling_kataphrakt ])

    #========================================================================
    site_s3 = Repo.insert! %Scenario{
      name: "Gathering Information",
      blurb: "Cirion's forces try to capture a Khandish leader from a fort.",
      date_age: 3, date_year: 2998, date_month: -2, date_day: 0, is_canonical: true, size: 47
   }

    Repo.insert! %ScenarioResource{scenario_id: site_s3.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 3, page: 28}

    site_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s3.id, faction: :gondor, suggested_points: 350, actual_points: 329, sort_order: 1}
    _declare_role_figure(site_s3f1, 1, 1, [ cirion ])
    _declare_role_figure(site_s3f1, 1, 2, [ murin ])
    _declare_role_figure(site_s3f1, 1, 3, [ drar ])
    _declare_role_figure(site_s3f1, 4, 4, [ gondor_womt_spear_shield ])
    _declare_role_figure(site_s3f1, 4, 5, [ gondor_womt_shield ])
    _declare_role_figure(site_s3f1, 4, 6, [ gondor_womt_bow ])
    _declare_role_figure(site_s3f1, 3, 7, [ gondor_rog ])

    site_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s3.id, faction: :easterlings, suggested_points: 350, actual_points: 420, sort_order: 2}
    _declare_role_figure(site_s3f2, 2, 1, [ khandish_chieftain ])
    _declare_role_figure(site_s3f2, 4, 2, [ khandish_w_bow ])
    _declare_role_figure(site_s3f2, 8, 3, [ khandish_w_axe ])
    _declare_role_figure(site_s3f2, 5, 4, [ khandish_horseman ])
    _declare_role_figure(site_s3f2, 3, 5, [ easterling_w_shield ])
    _declare_role_figure(site_s3f2, 2, 6, [ easterling_w_shield_spear ])
    _declare_role_figure(site_s3f2, 4, 7, [ easterling_w_bow ])
    _declare_role_figure(site_s3f2, 1, 8, [ easterling_w_banner ])

    #========================================================================
    site_s4 = Repo.insert! %Scenario{
      name: "Turning the Tide",
      blurb: "Cirion surprise attacks an Easterling camp at night.",
      date_age: 3, date_year: 2998, date_month: -1, date_day: 0, is_canonical: true, size: 121
   }

    Repo.insert! %ScenarioResource{scenario_id: site_s4.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 4, page: 30}

    site_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s4.id, faction: :gondor, suggested_points: 900, actual_points: 849, sort_order: 1}
    _declare_role_figure(site_s4f1,  1, 1, [ cirion ])
    _declare_role_figure(site_s4f1,  1, 2, [ murin ])
    _declare_role_figure(site_s4f1,  1, 3, [ drar ])
    _declare_role_figure(site_s4f1,  1, 4, [ madril ])
    _declare_role_figure(site_s4f1,  1, 5, [ faramir ])
    _declare_role_figure(site_s4f1,  1, 6, [ gondor_captain_mt ])
    _declare_role_figure(site_s4f1,  3, 7, [ gondor_citadel_gd_spear ])
    _declare_role_figure(site_s4f1,  3, 8, [ gondor_citadel_gd_bow ])
    _declare_role_figure(site_s4f1, 12, 9, [ gondor_womt_spear_shield ])
    _declare_role_figure(site_s4f1, 11, 10, [ gondor_womt_shield ])
    _declare_role_figure(site_s4f1, 12, 11, [ gondor_womt_bow ])
    _declare_role_figure(site_s4f1,  1, 12, [ gondor_womt_banner ])
    _declare_role_figure(site_s4f1,  9, 13, [ gondor_rog ])

    site_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s4.id, faction: :easterlings, suggested_points: 600, actual_points: 813, sort_order: 2}
    _declare_role_figure(site_s4f2,  1, 1, [ khamul ])
    _declare_role_figure(site_s4f2,  1, 2, [ easterling_captain ])
    _declare_role_figure(site_s4f2,  1, 3, [ khandish_chieftain ])
    _declare_role_figure(site_s4f2, 11, 4, [ easterling_w_shield ])
    _declare_role_figure(site_s4f2, 12, 5, [ easterling_w_bow ])
    _declare_role_figure(site_s4f2,  9, 6, [ easterling_w_shield_spear ])
    _declare_role_figure(site_s4f2,  1, 7, [ easterling_w_banner ])
    _declare_role_figure(site_s4f2, 12, 8, [ khandish_w_axe ])
    _declare_role_figure(site_s4f2,  6, 9, [ khandish_w_bow ])
    _declare_role_figure(site_s4f2,  5, 10, [ khandish_horseman ])
    _declare_role_figure(site_s4f2,  5, 11, [ easterling_kataphrakt ])

    #========================================================================
    site_s5 = Repo.insert! %Scenario{
      name: "Reprisals",
      blurb: "Dáin Ironfoot leads a dwarven raid against the Easterlings.",
      date_age: 3, date_year: 3001, date_month: 0, date_day: 0, is_canonical: true, size: 71
   }

    Repo.insert! %ScenarioResource{scenario_id: site_s5.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 5, page: 36}

    site_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s5.id, faction: :dwarves, suggested_points: 500, actual_points: 460, sort_order: 1}
    _declare_role_figure(site_s5f1,  1, 1, [ dain ])
    _declare_role_figure(site_s5f1,  1, 2, [ dwarf_captain ])
    _declare_role_figure(site_s5f1,  6, 3, [ dwarf_khazad_gd ])
    _declare_role_figure(site_s5f1,  9, 4, [ dwarf_w_bow ])
    _declare_role_figure(site_s5f1,  7, 5, [ dwarf_w_shield ])
    _declare_role_figure(site_s5f1,  4, 6, [ dwarf_w_axe ])
    _declare_role_figure(site_s5f1,  1, 7, [ dwarf_w_banner ])

    site_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s5.id, faction: :easterlings, suggested_points: 550, actual_points: 511, sort_order: 2}
    _declare_role_figure(site_s5f2,  2, 1, [ easterling_captain ])
    _declare_role_figure(site_s5f2, 11, 2, [ easterling_w_shield ])
    _declare_role_figure(site_s5f2, 12, 3, [ easterling_w_bow ])
    _declare_role_figure(site_s5f2,  6, 4, [ easterling_w_shield_spear ])
    _declare_role_figure(site_s5f2,  1, 6, [ easterling_w_banner ])
    _declare_role_figure(site_s5f2, 10, 5, [ easterling_kataphrakt ])

    #========================================================================
    site_s6 = Repo.insert! %Scenario{
      name: "Strange Circumstances",
      blurb: "Cirion joins his Khandish captors to fight off an Orc raid.",
      date_age: 3, date_year: 3002, date_month: 0, date_day: 0, is_canonical: true, size: 101
   }

    Repo.insert! %ScenarioResource{scenario_id: site_s6.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 6, page: 38}

    site_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s6.id, faction: :easterlings, suggested_points: 500, actual_points: 700, sort_order: 1}
    _declare_role_figure(site_s6f1,  1, 1, [ cirion ])
    _declare_role_figure(site_s6f1,  1, 2, [ khandish_king_chariot ])
    _declare_role_figure(site_s6f1,  2, 3, [ khandish_chieftain_horse ])
    _declare_role_figure(site_s6f1,  3, 4, [ gondor_rog ])
    _declare_role_figure(site_s6f1,  8, 5, [ khandish_w_bow ])
    _declare_role_figure(site_s6f1, 16, 6, [ khandish_w_axe ])
    _declare_role_figure(site_s6f1, 12, 7, [ khandish_horseman ])

    site_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s6.id, faction: :mordor, suggested_points: 750, actual_points: 796, sort_order: 2}
    _declare_role_figure(site_s6f2,  3, 1, [ orc_captain ])
    _declare_role_figure(site_s6f2,  1, 2, [ orc_captain_warg ])
    _declare_role_figure(site_s6f2, 10, 3, [ orc_w_shield ])
    _declare_role_figure(site_s6f2, 12, 4, [ orc_w_spear ])
    _declare_role_figure(site_s6f2,  6, 5, [ orc_w_2h ])
    _declare_role_figure(site_s6f2,  6, 6, [ orc_w_bow ])
    _declare_role_figure(site_s6f2,  2, 7, [ orc_w_banner ])
    _declare_role_figure(site_s6f2,  4, 8, [ warg_rider_spear ])
    _declare_role_figure(site_s6f2,  4, 9, [ warg_rider_bow ])
    _declare_role_figure(site_s6f2,  4, 10, [ warg_rider_shield ])
    _declare_role_figure(site_s6f2,  1, 11, [ war_catapult ])
    _declare_role_figure(site_s6f2,  1, 12, [ war_catapult_troll ])

    #========================================================================
    site_s7 = Repo.insert! %Scenario{
      name: "The Field of Celebrant",
      blurb: "Eorl the Young saves Gondor from the Khandish and their Orc allies.",
      date_age: 3, date_year: 2510, date_month: 0, date_day: 0, is_canonical: true, size: 107
   }

    Repo.insert! %ScenarioResource{scenario_id: site_s7.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 7, page: 40}

    site_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s7.id, faction: :rohan, suggested_points: 650, actual_points: 635, sort_order: 1}
    _declare_role_figure(site_s7f1,  1, 1, [ eorl_horse ])
    _declare_role_figure(site_s7f1,  2, 2, [ rohan_captain_horse ])
    _declare_role_figure(site_s7f1,  7, 3, [ rohan_gd_horse_spear ])
    _declare_role_figure(site_s7f1, 12, 4, [ rohan_rider ])
    _declare_role_figure(site_s7f1,  6, 5, [ rohan_rider_spear ])
    _declare_role_figure(site_s7f1,  1, 6, [ rohan_gd_horse_banner ])

    site_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s7.id, faction: :easterlings, suggested_points: 800, actual_points: 949, sort_order: 2}
    _declare_role_figure(site_s7f2,  1, 1, [ khandish_king_chariot ])
    _declare_role_figure(site_s7f2,  1, 2, [ khandish_chieftain ])
    _declare_role_figure(site_s7f2,  1, 3, [ khandish_chieftain_horse ])
    _declare_role_figure(site_s7f2,  1, 4, [ orc_captain ])
    _declare_role_figure(site_s7f2,  8, 5, [ khandish_w_bow ])
    _declare_role_figure(site_s7f2, 16, 6, [ khandish_w_axe ])
    _declare_role_figure(site_s7f2, 12, 7, [ khandish_horseman ])
    _declare_role_figure(site_s7f2,  2, 8, [ khandish_charioteer ])
    _declare_role_figure(site_s7f2, 11, 9, [ orc_w_shield ])
    _declare_role_figure(site_s7f2, 12, 10, [ orc_w_spear ])
    _declare_role_figure(site_s7f2,  6, 11, [ orc_w_2h ])
    _declare_role_figure(site_s7f2,  6, 12, [ orc_w_bow ])
    _declare_role_figure(site_s7f2,  1, 13, [ orc_w_banner ])

    #========================================================================
    site_s8 = Repo.insert! %Scenario{
      name: "Hunter & Hunted",
      blurb: "Easterling raiders under Khamûl encounter the defenders of Fangorn.",
      date_age: 3, date_year: 2520, date_month: 0, date_day: 0, is_canonical: true, size: 28
   }

    Repo.insert! %ScenarioResource{scenario_id: site_s8.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 8, page: 46}

    site_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s8.id, faction: :free_peoples, suggested_points: 400, actual_points: 495, sort_order: 1}
    _declare_role_figure(site_s8f1,  1, 1, [ treebeard ])
    _declare_role_figure(site_s8f1,  1, 2, [ gwaihir ])
    _declare_role_figure(site_s8f1,  2, 3, [ eagle ])

    site_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s8.id, faction: :easterlings, suggested_points: 450, actual_points: 430, sort_order: 2}
    _declare_role_figure(site_s8f2,  1, 1, [ khamul_horse ])
    _declare_role_figure(site_s8f2,  1, 2, [ khandish_chieftain ])
    _declare_role_figure(site_s8f2, 10, 3, [ easterling_kataphrakt ])
    _declare_role_figure(site_s8f2,  4, 4, [ khandish_w_bow ])
    _declare_role_figure(site_s8f2,  8, 5, [ khandish_w_axe ])

    #########################################################################
    # SIEGE OF GONDOR
    #########################################################################

    sog_s1 = Repo.insert! %Scenario{
      name: "Prologue: Osgiliath",
      blurb: "Sauron launches his army, led by Gothmog, against a Gondorian force led by Boromir and Faramir",
      date_age: 3, date_year: 3018, date_month: 6, date_day: 20, is_canonical: true, size: 110
    }

    Repo.insert! %ScenarioResource{scenario_id: sog_s1.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 1, page: 18}

    sog_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: sog_s1.id, faction: :gondor, suggested_points: 400, actual_points: 0, sort_order: 1}
    _declare_role_figure(sog_s1f1, 1, 1, [ boromir ])
    _declare_role_figure(sog_s1f1, 1, 2, [ faramir ])
    _declare_role_figure(sog_s1f1, 1, 3, [ beregond ])
    _declare_role_figure(sog_s1f1, 4, 4, [ gondor_citadel_gd_spear ])
    _declare_role_figure(sog_s1f1, 4, 5, [ gondor_citadel_gd_spear ])
    _declare_role_figure(sog_s1f1, 8, 6, [ gondor_womt_bow ])
    _declare_role_figure(sog_s1f1, 8, 7, [ gondor_womt_spear_shield ])
    _declare_role_figure(sog_s1f1, 8, 8, [ gondor_womt_shield ])
    _declare_role_figure(sog_s1f1, 8, 9, [ gondor_womt_banner ])
    _declare_role_figure(sog_s1f1, 8, 10, [ gondor_knight ])

    sog_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: sog_s1.id, faction: :mordor, suggested_points: 400, actual_points: 0, sort_order: 2}
    _declare_role_figure(sog_s1f2, 1, 1, [ gothmog ])
    _declare_role_figure(sog_s1f2, 2, 2, [ orc_shaman ])
    _declare_role_figure(sog_s1f2, 1, 3, [ orc_captain ])
    _declare_role_figure(sog_s1f2, 12, 4, [ orc_m_shield_spear ])
    _declare_role_figure(sog_s1f2, 8, 5, [ orc_w_shield ])
    _declare_role_figure(sog_s1f2, 8, 6, [ orc_w_spear ])
    _declare_role_figure(sog_s1f2, 4, 7, [ orc_w_bow ])
    _declare_role_figure(sog_s1f2, 4, 8, [ orc_w_2h ])
    _declare_role_figure(sog_s1f2, 5, 9, [ warg_rider_shield_spear ])
    _declare_role_figure(sog_s1f2, 5, 10, [ warg_rider_bow ])
    _declare_role_figure(sog_s1f2, 4, 11, [ m_uruk_hai_shield ])
    _declare_role_figure(sog_s1f2, 4, 12, [ m_uruk_hai_2h ])
    _declare_role_figure(sog_s1f2, 4, 13, [ orc_tracker ])

    #========================================================================
    sog_s2 = Repo.insert! %Scenario{
      name: "First Assault on Cair Andros",
      blurb: "Faramir defends the walls of Cair Andros against the Orcs of Mordor.",
      date_age: 3, date_year: 3018, date_month: 3, date_day: 9, is_canonical: true, size: 100
    }

    Repo.insert %ScenarioResource{scenario_id: sog_s2.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 2, page: 32}

    sog_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: sog_s2.id, faction: :gondor, suggested_points: 250, actual_points: 0, sort_order: 1}
    _declare_role_figure(sog_s2f1, 1, 1, "Faramir, Captain of Gondor", [ faramir ])
    _declare_role_figure(sog_s2f1, 1, 2, "Damrod, Captain of the Rangers of Gondor", [ beregond ])
    _declare_role_figure(sog_s2f1, 4, 3, [ gondor_rog ])
    _declare_role_figure(sog_s2f1, 6, 4, [ gondor_womt_bow ])
    _declare_role_figure(sog_s2f1, 6, 5, [ gondor_womt_spear_shield ])
    _declare_role_figure(sog_s2f1, 4, 6, [ gondor_womt_shield ])
    _declare_role_figure(sog_s2f1, 2, 7, [ gondor_womt_banner ])

    sog_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: sog_s2.id, faction: :mordor, suggested_points: 750, actual_points: 0, sort_order: 2}
    _declare_role_figure(sog_s2f2,  2, 1, [ orc_shaman ])
    _declare_role_figure(sog_s2f2,  2, 2, [ orc_captain ])
    _declare_role_figure(sog_s2f2, 24, 3, [ orc_m_shield_spear ])
    _declare_role_figure(sog_s2f2, 14, 4, [ orc_w_shield ])
    _declare_role_figure(sog_s2f2, 12, 5, [ orc_w_spear ])
    _declare_role_figure(sog_s2f2, 12, 6, [ orc_w_bow ])
    _declare_role_figure(sog_s2f2,  8, 7, [ orc_w_2h ])
    _declare_role_figure(sog_s2f2,  2, 8, [ orc_w_banner ])

    #========================================================================
    sog_s3 = Repo.insert! %Scenario{
      name: "Second Assault on Cair Andros",
      blurb: "Gothmog leads another assault on Cair Andros.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 11, is_canonical: true, size: 69
   }

    Repo.insert! %ScenarioResource{scenario_id: sog_s3.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 3, page: 40}

    sog_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: sog_s3.id, faction: :gondor, suggested_points: 150, actual_points: 0, sort_order: 1}
    _declare_role_figure(sog_s3f1, 1, 1, [ gondor_captain_mt ])
    _declare_role_figure(sog_s3f1, 4, 2, [ gondor_rog ])
    _declare_role_figure(sog_s3f1, 4, 3, [ gondor_womt_bow ])
    _declare_role_figure(sog_s3f1, 4, 4, [ gondor_womt_spear_shield ])
    _declare_role_figure(sog_s3f1, 3, 5, [ gondor_womt_shield ])
    _declare_role_figure(sog_s3f1, 1, 6, [ gondor_womt_banner ])

    sog_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: sog_s3.id, faction: :mordor, suggested_points: 600, actual_points: 0, sort_order: 2}
    _declare_role_figure(sog_s3f2,  1,  1, [ gothmog ])
    _declare_role_figure(sog_s3f2, 11,  2, [ orc_w_shield ])
    _declare_role_figure(sog_s3f2,  9,  3, [ orc_w_spear ])
    _declare_role_figure(sog_s3f2,  8,  4, [ orc_w_bow ])
    _declare_role_figure(sog_s3f2,  8,  5, [ orc_w_2h ])
    _declare_role_figure(sog_s3f2,  1,  6, [ orc_w_banner ])
    _declare_role_figure(sog_s3f2,  1,  7, [ war_catapult ])
    _declare_role_figure(sog_s3f2,  3,  8, [ war_catapult_orc ])
    _declare_role_figure(sog_s3f2,  2,  9, [ mordor_siege_bow ])
    _declare_role_figure(sog_s3f2,  4, 10, [ mordor_siege_bow_orc ])
    _declare_role_figure(sog_s3f2,  4, 11, [ orc_tracker ])

    #========================================================================
    sog_s4 = Repo.insert! %Scenario{
      name: "The Rammas",
      blurb: "Gothmog pursues Faramir out of Osgiliath to the edge of the Pelennor Fields.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 12, is_canonical: true, size: 87
   }

    Repo.insert! %ScenarioResource{scenario_id: sog_s4.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 4, page: 46}

    sog_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: sog_s4.id, faction: :gondor, suggested_points: 500, actual_points: 0, sort_order: 1}
    _declare_role_figure(sog_s4f1,  1,  1, [ faramir ])
    _declare_role_figure(sog_s4f1,  1,  2, [ damrod ])
    _declare_role_figure(sog_s4f1,  1,  3, [ gondor_captain_mt ])
    _declare_role_figure(sog_s4f1,  4,  4, [ gondor_rog ])
    _declare_role_figure(sog_s4f1,  4,  5, [ gondor_womt_bow ])
    _declare_role_figure(sog_s4f1,  4,  6, [ gondor_womt_spear_shield ])
    _declare_role_figure(sog_s4f1,  3,  7, [ gondor_womt_shield ])
    _declare_role_figure(sog_s4f1,  1,  8, [ gondor_womt_banner ])
    _declare_role_figure(sog_s4f1, 10,  9, [ gondor_knight ])
    _declare_role_figure(sog_s4f1,  1, 10, [ avenger ])
    _declare_role_figure(sog_s4f1,  2, 11, [ avenger_crew ])
    _declare_role_figure(sog_s4f1,  1, 12, [ trebuchet ])
    _declare_role_figure(sog_s4f1,  3, 13, [ trebuchet_crew])

    sog_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: sog_s4.id, faction: :mordor, suggested_points: 500, actual_points: 0, sort_order: 2}
    _declare_role_figure(sog_s4f2,  1,  1, [ gothmog ])
    _declare_role_figure(sog_s4f2,  2,  2, [ orc_captain ])
    _declare_role_figure(sog_s4f2,  2,  3, [ orc_shaman ])
    _declare_role_figure(sog_s4f2, 12,  4, [ orc_m_shield_spear ])
    _declare_role_figure(sog_s4f2,  8,  5, [ orc_w_spear ])
    _declare_role_figure(sog_s4f2,  4,  6, [ orc_w_bow ])
    _declare_role_figure(sog_s4f2,  4,  7, [ orc_w_2h ])
    _declare_role_figure(sog_s4f2,  4,  8, [ orc_w_shield ])
    _declare_role_figure(sog_s4f2,  4,  9, [ orc_w_banner ])
    _declare_role_figure(sog_s4f2,  2, 10, [ mordor_siege_bow ])
    _declare_role_figure(sog_s4f2,  4, 11, [ mordor_siege_bow_orc ])
    _declare_role_figure(sog_s4f2,  2, 12, [ warg_rider_shield_spear ])
    _declare_role_figure(sog_s4f2,  2, 13, [ warg_rider_bow ])

    #========================================================================
    sog_s5 = Repo.insert! %Scenario{
      name: "The Siege of Minas Tirith",
      blurb: "Gandalf the White defends the walls of Minas Tirith from the forces of Mordor under Gothmog.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 14, is_canonical: true, size: 112
   }

    Repo.insert! %ScenarioResource{scenario_id: sog_s5.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 5, page: 48}

    sog_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: sog_s5.id, faction: :gondor, suggested_points:  750, actual_points: 0, sort_order: 1}
    _declare_role_figure(sog_s5f1, 1,  1, [ gandalf_white ])
    _declare_role_figure(sog_s5f1, 1,  2, [ pippin_gondor ])
    _declare_role_figure(sog_s5f1, 1,  3, [ beregond ])
    _declare_role_figure(sog_s5f1, 4,  4, [ gondor_citadel_gd_spear ])
    _declare_role_figure(sog_s5f1, 4,  5, [ gondor_citadel_gd_bow ])
    _declare_role_figure(sog_s5f1, 1,  6, [ gondor_womt_shield ])
    _declare_role_figure(sog_s5f1, 4,  7, [ gondor_womt_spear_shield ])
    _declare_role_figure(sog_s5f1, 4,  8, [ gondor_womt_bow ])
    _declare_role_figure(sog_s5f1, 3,  9, [ gondor_womt_banner ])
    _declare_role_figure(sog_s5f1, 2, 10, [ trebuchet ])
    _declare_role_figure(sog_s5f1, 6, 11, [ trebuchet_crew ])
    _declare_role_figure(sog_s5f1, 2, 12, [ avenger ])
    _declare_role_figure(sog_s5f1, 4, 13, [ avenger_crew ])

    sog_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: sog_s5.id, faction: :mordor, suggested_points: 1000, actual_points: 0, sort_order: 2}
    _declare_role_figure(sog_s5f2,  1,  1, [ witch_king_horse ])
    _declare_role_figure(sog_s5f2,  1,  2, [ gothmog ])
    _declare_role_figure(sog_s5f2,  1,  3, [ orc_shaman ])
    _declare_role_figure(sog_s5f2, 16,  4, [ orc_m_shield_spear ])
    _declare_role_figure(sog_s5f2,  5,  5, [ orc_w_shield ])
    _declare_role_figure(sog_s5f2,  8,  6, [ orc_w_spear ])
    _declare_role_figure(sog_s5f2,  4,  7, [ orc_w_bow ])
    _declare_role_figure(sog_s5f2,  4,  8, [ orc_w_2h ])
    _declare_role_figure(sog_s5f2,  1,  9, [ orc_w_banner ])
    _declare_role_figure(sog_s5f2,  2, 10, [ mordor_troll ])
    _declare_role_figure(sog_s5f2,  1, 11, [ war_catapult ])
    _declare_role_figure(sog_s5f2,  3, 12, [ war_catapult_orc ])
    _declare_role_figure(sog_s5f2,  1, 13, [ war_catapult_troll ])
    _declare_role_figure(sog_s5f2,  2, 14, [ mordor_siege_bow ])
    _declare_role_figure(sog_s5f2,  4, 15, [ mordor_siege_bow_orc ])
    _declare_role_figure(sog_s5f2,  4, 16, [ orc_tracker ])

    #========================================================================
    sog_s6 = Repo.insert! %Scenario{
      name: "The Pyre of Denethor",
      blurb: "Gandalf the White rescues Faramir from the insanity of Denethor.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, is_canonical: true, size: 84
   }

    Repo.insert! %ScenarioResource{scenario_id: sog_s6.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 5, page: 52}

    sog_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: sog_s6.id, faction: :gondor, suggested_points:  750, actual_points: 0, sort_order: 1}
    _declare_role_figure(sog_s6f1, 1, 1, [ gandalf_white ])
    _declare_role_figure(sog_s6f1, 1, 2, [ pippin_gondor ])
    _declare_role_figure(sog_s6f1, 1, 3, [ beregond ])
    _declare_role_figure(sog_s6f1, 4, 4, [ gondor_citadel_gd_spear ])
    _declare_role_figure(sog_s6f1, 4, 5, [ gondor_citadel_gd_bow ])
    _declare_role_figure(sog_s6f1, 8, 6, [ gondor_womt_bow ])
    _declare_role_figure(sog_s6f1, 8, 7, [ gondor_womt_spear_shield ])
    _declare_role_figure(sog_s6f1, 6, 8, [ gondor_womt_shield ])
    _declare_role_figure(sog_s6f1, 2, 9, [ gondor_womt_banner ])

    sog_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: sog_s6.id, faction: :mordor, suggested_points: 1000, actual_points: 0, sort_order: 2}
    _declare_role_figure(sog_s6f2,  1,  1, [ denethor ])
    _declare_role_figure(sog_s6f2,  1,  2, [ orc_captain ])
    _declare_role_figure(sog_s6f2,  1,  3, [ orc_shaman ])
    _declare_role_figure(sog_s6f2, 16,  4, [ orc_m_shield_spear ])
    _declare_role_figure(sog_s6f2,  6,  5, [ orc_w_shield ])
    _declare_role_figure(sog_s6f2,  8,  6, [ orc_w_spear ])
    _declare_role_figure(sog_s6f2,  4,  7, [ orc_w_bow ])
    _declare_role_figure(sog_s6f2,  4,  8, [ orc_w_2h ])
    _declare_role_figure(sog_s6f2,  2,  9, [ orc_w_banner ])
    _declare_role_figure(sog_s6f2,  6, 10, [ gondor_womt_shield ])

    #========================================================================
    sog_s7 = Repo.insert! %Scenario{
      name: "The Defenses Must Hold!",
      blurb: "Theoden and friends hold out at Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, is_canonical: true, size: 109
   }

    Repo.insert! %ScenarioResource{scenario_id: sog_s7.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 6, page: 58}

    sog_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: sog_s7.id, faction: :gondor, suggested_points: 250, actual_points: 0, sort_order: 1}
    _declare_role_figure(sog_s7f1, 1,  1, [ aragorn ])
    _declare_role_figure(sog_s7f1, 1,  2, [ gimli ])
    _declare_role_figure(sog_s7f1, 1,  3, [ legolas ])
    _declare_role_figure(sog_s7f1, 1,  4, [ haldir ])
    _declare_role_figure(sog_s7f1, 1,  5, [ theoden ])
    _declare_role_figure(sog_s7f1, 1,  6, [ gamling ])
    _declare_role_figure(sog_s7f1, 2,  7, [ rohan_gd ])
    _declare_role_figure(sog_s7f1, 2,  8, [ rohan_w_spear_shield ])
    _declare_role_figure(sog_s7f1, 4,  9, [ rohan_w_bow ])
    _declare_role_figure(sog_s7f1, 2, 10, [ rohan_w_banner ])
    _declare_role_figure(sog_s7f1, 4, 11, [ wood_elf_w_bow ])
    _declare_role_figure(sog_s7f1, 3, 12, [ wood_elf_w_blade ])
    _declare_role_figure(sog_s7f1, 1, 13, [ wood_elf_w_banner ])

    sog_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: sog_s7.id, faction: :mordor, suggested_points: 375, actual_points: 0, sort_order: 2}
    _declare_role_figure(sog_s7f2,  4,  1, [ uruk_hai_captain_shield ])
    _declare_role_figure(sog_s7f2,  1,  2, [ uruk_hai_shaman ])
    _declare_role_figure(sog_s7f2,  1,  3, [ dunlending_chieftain ])
    _declare_role_figure(sog_s7f2, 27,  4, [ uruk_hai_w_shield ])
    _declare_role_figure(sog_s7f2, 10,  5, [ uruk_hai_w_crossbow ])
    _declare_role_figure(sog_s7f2,  3,  6, [ uruk_hai_w_banner ])
    _declare_role_figure(sog_s7f2, 15,  7, [ uruk_hai_berserker ])
    _declare_role_figure(sog_s7f2,  4,  8, [ dunlending_w ])
    _declare_role_figure(sog_s7f2,  5,  9, [ dunlending_w_2h ])
    _declare_role_figure(sog_s7f2,  1, 10, [ dunlending_w_banner ])
    _declare_role_figure(sog_s7f2,  2, 11, [ uruk_hai_ballista ])
    _declare_role_figure(sog_s7f2,  6, 12, [ uruk_hai_ballista_crew ])
    _declare_role_figure(sog_s7f2,  3, 13, [ uruk_hai_demo_team ])

    #========================================================================
    sog_s8 = Repo.insert! %Scenario{
      name: "Forth Eorlingas!",
      blurb: "Theoden leads a mounted charge out from Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 4, is_canonical: true, size: 105
   }

    Repo.insert! %ScenarioResource{scenario_id: sog_s8.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 7, page: 62}

    sog_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: sog_s8.id, faction: :gondor, suggested_points: 800, actual_points: 0, sort_order: 1}
    _declare_role_figure(sog_s8f1,  1,  1, [ aragorn_horse ])
    _declare_role_figure(sog_s8f1,  1,  2, [ legolas_horse ])
    _declare_role_figure(sog_s8f1,  1,  3, [ theoden_horse ])
    _declare_role_figure(sog_s8f1,  1,  4, [ gamling_horse ])
    _declare_role_figure(sog_s8f1,  1,  5, [ gandalf_white_horse ])
    _declare_role_figure(sog_s8f1,  1,  6, [ eomer_horse ])
    _declare_role_figure(sog_s8f1,  5,  7, [ rohan_gd_horse_spear ])
    _declare_role_figure(sog_s8f1,  1,  8, [ rohan_gd_horse_banner ])
    _declare_role_figure(sog_s8f1, 17,  9, [ rohan_rider, rohan_rider_spear ])
    _declare_role_figure(sog_s8f1,  1, 10, [ rohan_rider_banner ])

    sog_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: sog_s8.id, faction: :mordor, suggested_points: 800, actual_points: 0, sort_order: 2}
    _declare_role_figure(sog_s8f2,  4,  1, [ uruk_hai_captain_shield ])
    _declare_role_figure(sog_s8f2,  1,  2, [ uruk_hai_shaman ])
    _declare_role_figure(sog_s8f2, 18,  3, [ uruk_hai_w_shield ])
    _declare_role_figure(sog_s8f2,  2,  4, [ uruk_hai_w_banner ])
    _declare_role_figure(sog_s8f2, 15,  5, [ uruk_hai_w_crossbow ])
    _declare_role_figure(sog_s8f2, 20,  6, [ uruk_hai_w_pike ])
    _declare_role_figure(sog_s8f2, 15,  7, [ uruk_hai_berserker ])

    #########################################################################
    # THE FALL OF THE NECROMANCER
    #########################################################################

    #========================================================================
    fotn_s1 = Repo.insert! %Scenario{
      name: "Dol Guldur Awakens",
      blurb: "Thranduil leads a warband against the creatures of Mirkwood.",
      date_age: 3, date_year: 2060, date_month: 0, date_day: 0, is_canonical: true, size: 22
   }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s1.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 1, page: 8}
    Repo.insert! %ScenarioResource{scenario_id: fotn_s1.id, resource_type: 1, url: "https://www.youtube.com/watch?v=0_dCdLngsKs&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1}

    fotn_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s1.id, faction: :mirkwood, suggested_points: 200, actual_points: 273, sort_order: 1}
    _declare_role_figure(fotn_s1f1, 1, 1, [ thranduil ])
    _declare_role_figure(fotn_s1f1, 3, 2, [ wood_elf_sentinel ])
    _declare_role_figure(fotn_s1f1, 4, 3, [ wood_elf_w_blade ])
    _declare_role_figure(fotn_s1f1, 4, 4, [ wood_elf_w_bow ])
    _declare_role_figure(fotn_s1f1, 4, 5, [ wood_elf_w_spear ])

    fotn_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s1.id, faction: :dol_guldur, suggested_points: 200, actual_points: 150, sort_order: 2}
    _declare_role_figure(fotn_s1f2, 4, 1, [ giant_spider ])
    _declare_role_figure(fotn_s1f2, 2, 2, [ bat_swarm ])

    #========================================================================
    fotn_s2 = Repo.insert! %Scenario{
      name: "In the Nick of Time",
      blurb: "Elrond joins Thranduil against an attack from Dol Guldur lead by Khamûl.",
      date_age: 3,  date_year: 2061, date_month: 0, date_day: 0, is_canonical: true, size: 65
   }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s2.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 2, page: 10}
    Repo.insert! %ScenarioResource{scenario_id: fotn_s2.id, resource_type: 1, url: "https://www.youtube.com/watch?v=AMrP8abPj0Q&index=2&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1}

    fotn_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s2.id, faction: :mirkwood, suggested_points: 600, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotn_s2f1, 1, 1, [ thranduil ])
    _declare_role_figure(fotn_s2f1, 1, 2, [ elrond ])
    _declare_role_figure(fotn_s2f1, 1, 3, [ legolas ])
    _declare_role_figure(fotn_s2f1, 3, 4, [ wood_elf_sentinel ])
    _declare_role_figure(fotn_s2f1, 3, 5, [ wood_elf_w_blade ])
    _declare_role_figure(fotn_s2f1, 4, 6, [ wood_elf_w_bow ])
    _declare_role_figure(fotn_s2f1, 4, 7, [ wood_elf_w_spear ])
    _declare_role_figure(fotn_s2f1, 1, 8, [ wood_elf_w_banner ])
    _declare_role_figure(fotn_s2f1, 4, 9, [ high_elf_w_blade ])
    _declare_role_figure(fotn_s2f1, 4, 10, [ high_elf_w_bow ])
    _declare_role_figure(fotn_s2f1, 2, 11, [ high_elf_w_spear_shield ])
    _declare_role_figure(fotn_s2f1, 1, 12, [ high_elf_w_banner ])

    fotn_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s2.id, faction: :dol_guldur, suggested_points: 600, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotn_s2f2, 1, 1, [ khamul ])
    _declare_role_figure(fotn_s2f2, 1, 2, [ warg_chieftain ])
    _declare_role_figure(fotn_s2f2, 1, 3, [ orc_captain ])
    _declare_role_figure(fotn_s2f2, 7, 4, [ orc_w_shield ])
    _declare_role_figure(fotn_s2f2, 8, 5, [ orc_w_spear ])
    _declare_role_figure(fotn_s2f2, 4, 6, [ orc_w_2h ])
    _declare_role_figure(fotn_s2f2, 4, 7, [ orc_w_bow ])
    _declare_role_figure(fotn_s2f2, 1, 8, [ orc_w_banner ])
    _declare_role_figure(fotn_s2f2, 3, 9, [ warg ])
    _declare_role_figure(fotn_s2f2, 4, 10, [ giant_spider ])
    _declare_role_figure(fotn_s2f2, 2, 11, [ bat_swarm ])

    #========================================================================
    fotn_s3 = Repo.insert! %Scenario{
      name: "A Walk Through Dark Places",
      blurb: "A Rivendell band tries to protect Arwen and Círdan from the minions of Dol Guldur.",
      date_age: 3, date_year: 2062, date_month: 0, date_day: 0, is_canonical: true, size: 23
   }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s3.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 3, page: 12}
    Repo.insert! %ScenarioResource{scenario_id: fotn_s3.id, resource_type: 1, url: "https://www.youtube.com/watch?v=YN8X_azJfO8&index=3&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1}

    fotn_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s3.id, faction: :rivendell, suggested_points: 550, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotn_s3f1, 1, 1, [ cirdan ])
    _declare_role_figure(fotn_s3f1, 1, 2, [ arwen, arwen2 ])
    _declare_role_figure(fotn_s3f1, 1, 3, [ erestor ])
    _declare_role_figure(fotn_s3f1, 1, 4, [ glorfindel_lotw ])
    _declare_role_figure(fotn_s3f1, 1, 5, [ high_elf_captain ])
    _declare_role_figure(fotn_s3f1, 4, 6, [ high_elf_w_bow ])
    _declare_role_figure(fotn_s3f1, 3, 7, [ high_elf_w_blade ])
    _declare_role_figure(fotn_s3f1, 1, 8, [ high_elf_w_banner ])

    fotn_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s3.id, faction: :dol_guldur, suggested_points: 300, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotn_s3f2, 4, 1, [ castellan ])
    _declare_role_figure(fotn_s3f2, 2, 2, [ bat_swarm ])
    _declare_role_figure(fotn_s3f2, 4, 3, [ warg ])

    #========================================================================
    fotn_s4 = Repo.insert! %Scenario{
      name: "Meddle Not in the Affairs of Wizards",
      blurb: "The Istari faces the minions of Dol Guldur.",
      date_age: 3, date_year: 2062, date_month: -1, date_day: 0, is_canonical: true, size: 17
   }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s4.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 4, page: 14}
    Repo.insert! %ScenarioResource{scenario_id: fotn_s4.id, resource_type: 1, url: "https://www.youtube.com/watch?v=UbIM0XE6jT8&index=4&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1}

    fotn_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s4.id, faction: :white_council, suggested_points: 500, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotn_s4f1, 1, 1, [ gandalf_grey ])
    _declare_role_figure(fotn_s4f1, 1, 2, [ radagast ])
    _declare_role_figure(fotn_s4f1, 1, 3, [ saruman ])

    fotn_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s4.id, faction: :dol_guldur,     suggested_points: 400, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotn_s4f2, 4, 1, [ castellan ])
    _declare_role_figure(fotn_s4f2, 1, 2, [ orc_captain ])
    _declare_role_figure(fotn_s4f2, 2, 3, [ warg_rider_spear ])
    _declare_role_figure(fotn_s4f2, 2, 4, [ warg_rider_bow ])
    _declare_role_figure(fotn_s4f2, 2, 5, [ warg_rider_shield ])
    _declare_role_figure(fotn_s4f2, 3, 6, [ warg ])

    #========================================================================
    fotn_s5 = Repo.insert! %Scenario{
      name: "The Lair of the Spider Queen",
      blurb: "Lothlorien attacks the beasts of Mirkwood",
      date_age: 3, date_year: 2063, date_month: 0, date_day: 0, is_canonical: true, size: 41
   }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s5.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 5, page: 16}
    Repo.insert! %ScenarioResource{scenario_id: fotn_s5.id, resource_type: :video_replay, url: "https://www.youtube.com/watch?v=eyHTP-Vjhd8&index=5&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1}

    fotn_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s5.id, faction: :lothlorien, suggested_points: 450, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotn_s5f1, 1, 1, [ galadriel_lotg ])
    _declare_role_figure(fotn_s5f1, 1, 2, [ celeborn ])
    _declare_role_figure(fotn_s5f1, 2, 3, [ wood_elf_sentinel ])
    _declare_role_figure(fotn_s5f1, 8, 4, [ wood_elf_w_blade ])
    _declare_role_figure(fotn_s5f1, 8, 5, [ wood_elf_w_bow ])
    _declare_role_figure(fotn_s5f1, 8, 6, [ wood_elf_w_spear ])

    fotn_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s5.id, faction: :dol_guldur, suggested_points: 300, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotn_s5f2, 1, 1, [ spider_queen ])
    _declare_role_figure(fotn_s5f2, 4, 2, [ giant_spider ])
    _declare_role_figure(fotn_s5f2, 2, 3, [ bat_swarm ])
    _declare_role_figure(fotn_s5f2, 6, 4, [ warg ])

    #========================================================================
    fotn_s6 = Repo.insert! %Scenario{
      name: "In the Shadow of Dol Guldur",
      blurb: "Elrond's elves fight a Ringwraith-led Dol Guldur army.",
      date_age: 3, date_year: 2850, date_month: 0, date_day: 0, is_canonical: true, size: 91
   }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s6.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 6, page: 18}
    Repo.insert! %ScenarioResource{scenario_id: fotn_s6.id, resource_type: :video_replay, url: "https://www.youtube.com/watch?v=Cug7stLutRQ&index=6&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1}

    fotn_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s6.id, faction: :rivendell,  suggested_points: 700, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotn_s6f1, 1, 1, [ elrond ])
    _declare_role_figure(fotn_s6f1, 3, 2, [ wood_elf_sentinel ])
    _declare_role_figure(fotn_s6f1, 8, 3, [ high_elf_w_spear_shield ])
    _declare_role_figure(fotn_s6f1, 8, 4, [ high_elf_w_blade ])
    _declare_role_figure(fotn_s6f1, 8, 5, [ high_elf_w_bow ])
    _declare_role_figure(fotn_s6f1, 1, 6, [ high_elf_w_banner ])
    _declare_role_figure(fotn_s6f1, 8, 7, [ wood_elf_w_spear ])
    _declare_role_figure(fotn_s6f1, 7, 8, [ wood_elf_w_blade ])
    _declare_role_figure(fotn_s6f1, 8, 9, [ wood_elf_w_bow ])
    _declare_role_figure(fotn_s6f1, 1, 10, [ wood_elf_w_banner ])

    fotn_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s6.id, faction: :dol_guldur, suggested_points: 800, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotn_s6f2, 1, 1, [ ringwraith ])
    _declare_role_figure(fotn_s6f2, 1, 2, [ warg_chieftain ])
    _declare_role_figure(fotn_s6f2, 1, 3, [ orc_captain ])
    _declare_role_figure(fotn_s6f2, 1, 4, [ castellan ])
    _declare_role_figure(fotn_s6f2, 7, 5, [ orc_w_shield ])
    _declare_role_figure(fotn_s6f2, 8, 6, [ orc_w_spear ])
    _declare_role_figure(fotn_s6f2, 4, 7, [ orc_w_2h ])
    _declare_role_figure(fotn_s6f2, 4, 8, [ orc_w_bow ])
    _declare_role_figure(fotn_s6f2, 1, 9, [ orc_w_banner ])

    #========================================================================
    fotn_s7 = Repo.insert! %Scenario{
      name: "The Fall of the Necromancer",
      blurb: "The White Council battles the Necromancer himself at Dol Guldur.",
      date_age: 3, date_year: 2851, date_month: 0, date_day: 0, is_canonical: true, size: 29
   }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s7.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 7, page: 20}
    Repo.insert! %ScenarioResource{scenario_id: fotn_s7.id, resource_type: :video_replay, url: "https://www.youtube.com/watch?v=2J5px0_J2wQ&index=7&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", title: "Mid-Sussex Wargamers", sort_order: 1}

    fotn_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s7.id, faction: :rivendell,  suggested_points: 1500, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotn_s7f1, 1, 1, [ gandalf_grey ])
    _declare_role_figure(fotn_s7f1, 1, 2, [ saruman ])
    _declare_role_figure(fotn_s7f1, 1, 3, [ radagast ])
    _declare_role_figure(fotn_s7f1, 1, 4, [ arwen, arwen2])
    _declare_role_figure(fotn_s7f1, 1, 5, [ cirdan ])
    _declare_role_figure(fotn_s7f1, 1, 6, [ glorfindel_lotw ])
    _declare_role_figure(fotn_s7f1, 1, 7, [ erestor ])
    _declare_role_figure(fotn_s7f1, 1, 8, [ elrond ])
    _declare_role_figure(fotn_s7f1, 1, 9, [ galadriel_lotg ])
    _declare_role_figure(fotn_s7f1, 1, 10, [ celeborn ])
    _declare_role_figure(fotn_s7f1, 1, 11, [ thranduil ])
    _declare_role_figure(fotn_s7f1, 1, 12, [ legolas ])

    fotn_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s7.id, faction: :dol_guldur, suggested_points: 1400, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotn_s7f2, 1, 1, [ necromancer ])
    _declare_role_figure(fotn_s7f2, 1, 2, [ khamul ])
    _declare_role_figure(fotn_s7f2, 5, 3, [ ringwraith ])
    _declare_role_figure(fotn_s7f2, 4, 4, [ castellan ])
    _declare_role_figure(fotn_s7f2, 1, 5, [ troll_chieftain ])
    _declare_role_figure(fotn_s7f2, 1, 6, [ mordor_troll ])
    _declare_role_figure(fotn_s7f2, 4, 6, [ giant_spider ])

    #########################################################################
    # THE TWO TOWERS JOURNEYBOOK
    #########################################################################
    tttjb_s1 = Repo.insert! %Scenario{
      name: "Let's Hunt Some Orc",
      blurb: "Aragorn, Legolas, and Gimli encounter the rear guard of the Uruk-hai which have captured Merry and Pippin.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 27, is_canonical: true, size: 18
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s1.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 1, page: 14}

    tttjb_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s1.id, faction: :fellowship, suggested_points: 450, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s1f1, 1, 1, [ aragorn ])
    _declare_role_figure(tttjb_s1f1, 1, 2, [ legolas ])
    _declare_role_figure(tttjb_s1f1, 1, 3, [ gimli ])

    tttjb_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s1.id, faction: :isengard, suggested_points: 175, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s1f2, 8, 1, [ uruk_hai_s ])
    _declare_role_figure(tttjb_s1f2, 4, 2, [ uruk_hai_s_sword_shield ])
    _declare_role_figure(tttjb_s1f2, 3, 3, [ uruk_hai_s_bow ])

    #========================================================================
    tttjb_s8 = Repo.insert! %Scenario{
      name: "The Last March of the Ents",
      blurb: "The Ents storm Isengard",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, is_canonical: true, size: 40
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s8.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 8, page: 38}
    Repo.insert! %ScenarioResource{scenario_id: tttjb_s8.id, resource_type: :web_replay, title: "Dave T", url: "http://www.davetownsend.org/Battles/LotR-20150922/", sort_order: 1}
    Repo.insert! %ScenarioResource{scenario_id: tttjb_s8.id, resource_type: :web_replay, title: "Dave T", url: "http://www.davetownsend.org/Battles/LotR-20151011/", sort_order: 2}

    tttjb_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s8.id, faction: :free_peoples, suggested_points: 550, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s8f1, 1, 1, [ treebeard ])
    _declare_role_figure(tttjb_s8f1, 3, 2, [ ent, ash_tree_giant, birch_tree_giant, linden_tree_giant ])

    tttjb_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s8.id, faction: :isengard, suggested_points: 575, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s8f2, 1, 1, [ uruk_hai_captain_shield ])
    _declare_role_figure(tttjb_s8f2, 1, 2, [ orc_captain ])
    _declare_role_figure(tttjb_s8f2, 1, 3, [ isengard_troll ])
    _declare_role_figure(tttjb_s8f2, 5, 4, [ uruk_hai_w_pike ])
    _declare_role_figure(tttjb_s8f2, 5, 5, [ uruk_hai_w_shield ])
    _declare_role_figure(tttjb_s8f2, 3, 6, [ uruk_hai_w_crossbow ])
    _declare_role_figure(tttjb_s8f2, 3, 7, [ uruk_hai_berserker ])
    _declare_role_figure(tttjb_s8f2, 3, 8, [ uruk_hai_feral ])
    _declare_role_figure(tttjb_s8f2, 4, 9, [ orc_w_shield ])
    _declare_role_figure(tttjb_s8f2, 4, 10, [ orc_w_spear ])
    _declare_role_figure(tttjb_s8f2, 2, 11, [ orc_w_bow ])
    _declare_role_figure(tttjb_s8f2, 2, 12, [ orc_w_2h ])
    _declare_role_figure(tttjb_s8f2, 1, 13, [ uruk_hai_w_banner ])
    _declare_role_figure(tttjb_s8f2, 1, 14, [ orc_w_banner ])
  end
end

SbgInv.Data.generate
