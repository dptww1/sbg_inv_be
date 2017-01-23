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
  alias SbgInv.FactionFigure
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

  #========================================================================
  defp _declare_figure(name, plural_name, type, unique, factions) do
    fig = Repo.insert! %Figure{name: name, plural_name: plural_name, type: type, unique: unique}
    Enum.each factions, fn(faction) -> Repo.insert %FactionFigure{faction_id: faction, figure: fig} end
    fig
  end

  #========================================================================
  defp _declare_unique(name, factions \\ []) do
    _declare_figure(name, nil, :hero, true, factions)
    #Repo.insert! %Figure{name: name, type: :hero, unique: true}
  end

  #========================================================================
  defp _declare_hero(name, plural_name, factions \\ []) do
    _declare_figure(name, plural_name, :hero, false, factions)
    #Repo.insert! %Figure{name: name, plural_name: plural_name, type: :hero}
  end

  #========================================================================
  defp _declare_warrior(name, plural_name, factions \\ []) do
    _declare_figure(name, plural_name, :warrior, false, factions)
    #Repo.insert! %Figure{name: name, plural_name: plural_name, type: :warrior}
  end

  #========================================================================
  defp _declare_monster(name, plural_name, factions \\ []) do
    _declare_figure(name, plural_name, :monster, false, factions)
    #Repo.insert! %Figure{name: name, plural_name: plural_name, type: :monster}
  end

  #========================================================================
  defp _declare_unique_monster(name, factions \\ []) do
    _declare_figure(name, nil, :monster, true, factions)
    #Repo.insert! %Figure{name: name, type: :monster, unique: true}
  end

  #========================================================================
  defp _declare_siege(name, plural_name, factions \\ []) do
    _declare_figure(name, plural_name, :sieger, false, factions)
    #Repo.insert! %Figure{name: name, plural_name: plural_name, type: :sieger}
  end

  #========================================================================
  defp _declare_magazine_replay(scenario_id, book, issue, title, page, sort_order) do
    Repo.insert! %ScenarioResource{scenario_id: scenario_id, resource_type: :magazine_replay, book: book, issue: issue, page: page, title: title, sort_order: sort_order}
  end

  #========================================================================
  defp _declare_podcast(scenario_id, url, title, sort_order) do
    Repo.insert! %ScenarioResource{scenario_id: scenario_id, resource_type: :podcast, url: url, title: title, sort_order: sort_order}
  end

  #========================================================================
  defp _declare_video_replay(scenario_id, url, title, sort_order) do
    Repo.insert! %ScenarioResource{scenario_id: scenario_id, resource_type: :video_replay, url: url, title: title, sort_order: sort_order}
  end

  #========================================================================
  defp _declare_web_replay(scenario_id, url, title, sort_order) do
    Repo.insert! %ScenarioResource{scenario_id: scenario_id, resource_type: :web_replay, url: url, title: title, sort_order: sort_order}
  end

  #========================================================================
  defp _declare_role_figure(faction, amount, sort_order, name \\ "", figure_list) do
    role = Repo.insert! %Role{
      scenario_faction_id: faction.id,
      amount: amount,
      sort_order: sort_order,
      name: if(name != "", do: name, else: if(amount > 1, do: hd(figure_list).plural_name, else: hd(figure_list).name))
    }

    Enum.each figure_list, fn(fig) -> Repo.insert %RoleFigure{role_id: role.id, figure_id: fig.id} end
  end

  #========================================================================
  defp _generate do
    IO.puts "Generating data"

    #########################################################################
    # FIGURES: SHADOW & FLAME
    #########################################################################

    birch_tree_giant  = _declare_monster("Birch Tree Giant",  "Birch Tree Giants")
    linden_tree_giant = _declare_monster("Linden Tree Giant", "Linden Tree Giants")
    ash_tree_giant    = _declare_monster("Ash Tree Giant",    "Ash Tree Giants")

    #########################################################################
    # FIGURES: ANGMAR
    #########################################################################

    buhrdur        = _declare_unique("Bûhrdur",             [ :angmar ])
    dwimmerlaik    = _declare_unique("Dwimmerlaik",         [ :angmar ])
    gulavhar       = _declare_unique("Gûlavhar",            [ :angmar ])
    warg_chieftain = _declare_unique("Wild Warg Chieftain", [ :moria ])

    barrow_wight = _declare_warrior("Barrow Wight", "Barrow Wights", [ :angmar ])
    shade        = _declare_warrior("Shade",        "Shades",        [ :angmar ])
    spectre      = _declare_warrior("Spectre",      "Spectres",      [ :angmar, :minas_morgul ])
    warg         = _declare_warrior("Wild Warg",    "Wild Wargs", [ :moria ])

    #########################################################################
    # FIGURES: ARMY OF THROR
    #########################################################################

    thror         = _declare_unique("Thror",             [ :army_thror ])
    thrain        = _declare_unique("Thrain",            [ :army_thror ])
    thrain_broken = _declare_unique("Thrain the Broken", [ :wanderers ])

    erebor_captain      = _declare_hero("Erebor Captain",      "Erebor Captains",      [ :army_thror ])
    grim_hammer_captain = _declare_hero("Grim Hammer Captain", "Grim Hammer Captains", [ :army_thror ])

    erebor_w_banner      = _declare_warrior("Warrior of Erebor with banner",   "Warriors of Erebor with banner",   [ :army_thror ])
    erebor_w_shield      = _declare_warrior("Warrior of Erebor with shield",   "Warriors of Erebor with shield",   [ :army_thror ])
    erebor_w_spear       = _declare_warrior("Warrior of Erebor with spear",    "Warriors of Erebor with spear",    [ :army_thror ])
    grim_hammer_w_banner = _declare_warrior("Grim Hammer Warrior with banner", "Grim Hammer Warriors with banner", [ :army_thror ])
    grim_hammer_w        = _declare_warrior("Grim Hammer Warrior",             "Grim Hammer Warriors",             [ :army_thror ])

    #########################################################################
    # FIGURES: ARNOR
    #########################################################################

    arathorn = _declare_unique("Arathorn",                    [ :arnor ])
    arvedui  = _declare_unique("Arvedui, Last King of Arnor", [ :arnor ])
    halbarad = _declare_unique("Halbarad",                    [ :arnor ])
    malbeth  = _declare_unique("Malbeth the Seer",            [ :arnor ])

    arnor_captain = _declare_hero("Captain of Arnor", "Captains of Arnor", [ :arnor ])

    arnor_w            = _declare_warrior("Warrior of Arnor",               "Warriors of Arnor",               [ :arnor ])
    dunedain           = _declare_warrior("Dúnedan",                        "Dúnedain",                        [ :arnor ])
    ranger_north       = _declare_warrior("Ranger of the North",            "Rangers of the North",            [ :arnor ])
    ranger_north_spear = _declare_warrior("Ranger of the North with spear", "Rangers of the North with spear", [ :arnor ])

    #########################################################################
    # FIGURES: AZOG'S HUNTERS/AZOG'S LEGION
    #########################################################################

    azog_warg   = _declare_unique("Azog on White warg", [ :azogs_legion, :azogs_hunters ])
    azog        = _declare_unique("Azog",               [ :azogs_legion, :azogs_hunters ])
    bolg        = _declare_unique("Bolg",               [ :azogs_legion, :azogs_hunters ])
    bolg_warg   = _declare_unique("Bolg on warg",       [ :azogs_legion, :azogs_hunters ])
    fimbul      = _declare_unique("Fimbul",             [ :azogs_hunters ])
    fimbul_warg = _declare_unique("Fimbul on warg",     [ :azogs_hunters ])
    narzug_warg = _declare_unique("Narzug on warg",     [ :azogs_hunters ])
    narzug      = _declare_unique("Narzug",             [ :azogs_hunters ])
    yazneg      = _declare_unique("Yazneg",             [ :azogs_hunters ])

    goblin_mercenary_captain = _declare_hero("Goblin Mercenary Captain",        "Goblin Mercenary Captains",        [ :azogs_legion ])
    gundabad_orc_captain     = _declare_hero("Gundabad Orc Captain",            "Gundabad Orc Captains",            [ :azogs_legion, :dol_guldur ])
    hunter_orc_captain       = _declare_hero("Hunter Orc Captain",              "Hunter Orc Captains",              [ :azogs_hunters, :dol_guldur ])
    hunter_orc_captain_warg  = _declare_hero("Hunter Orc Captain on Fell Warg", "Hunter Orc Captains on Fell Warg", [ :azogs_hunters, :dol_guldur ])

    fell_warg           = _declare_warrior("Fell Warg",                "Fell Wargs",                [ :azogs_hunters, :dol_guldur, :mirkwood ])
    goblin_mercenary    = _declare_warrior("Goblin Mercenary",         "Goblin Mercenaries",        [ :azogs_legion ])
    gundabad_berserker  = _declare_warrior("Gundabad Berserker",       "Gundabad Berserkers",       [ :azogs_legion ])
    gundabad_orc_shield = _declare_warrior("Gundabad Orc with shield", "Gundabad Orcs with shield", [ :azogs_legion, :dol_guldur ])
    gundabad_orc_spear  = _declare_warrior("Gundabad Orc with spear",  "Gundabad Orcs with spear",  [ :azogs_legion, :dol_guldur ])
    hunter_orc          = _declare_warrior("Hunter Orc",               "Hunter Orcs",               [ :azogs_hunters, :dol_guldur ])
    hunter_orc_warg     = _declare_warrior("Hunter Orc on warg",       "Hunter Orcs on warg",       [ :azogs_hunters, :dol_guldur ])
    war_bat             = _declare_warrior("War Bat",                  "War Bats",                  [ :azogs_legion ])

    catapult_troll = _declare_monster("Catapult Troll", "Catapult Trolls", [ :azogs_legion ])
    gundabad_ogre  = _declare_monster("Gundabad Ogre",  "Gundabad Ogres",  [ :azogs_legion ])
    gundabad_troll = _declare_monster("Gundabad Troll", "Gundabad Trolls", [ :azogs_legion ])
    troll_brute    = _declare_monster("Troll Brute",    "Troll Brutes",    [ :azogs_legion ])

    #########################################################################
    # FIGURES: DALE
    #########################################################################

    girion = _declare_unique("Girion, Lord of Dale", [ :dale ])

    dale_captain = _declare_hero("Captain of Dale", "Captains of Dale", [ :dale ])

    dale_w = _declare_warrior("Man of Dale", "Men of Dale", [ :dale ])

    #########################################################################
    # FIGURES: DESOLATOR OF THE NORTH
    #########################################################################

    smaug = _declare_unique_monster("Smaug", [ :desolator_north ])

    #########################################################################
    # FIGURES: DWARVES
    #########################################################################

    balin  = _declare_unique("Dwarf Lord Balin",     [ :durins_folk ])
    dain   = _declare_unique("Dwarf Lord Dáin",      [ :durins_folk ])
    drar   = _declare_unique("Drar",                 [ :durins_folk ])
    durin  = _declare_unique("Durin",                [ :durins_folk ])
    floi   = _declare_unique("Flói Stonehand",       [ :durins_folk ])
    mardin = _declare_unique("Mardin",               [ :durins_folk ])
    murin  = _declare_unique("Murin",                [ :durins_folk ])

    dwarf_king    = _declare_hero("Dwarf King",                        "Dwarf Kings",                        [ :durins_folk ])
    dwarf_king_2h = _declare_hero("Dwarf King with two-handed weapon", "Dwarf Kings with two-handed weapon", [ :durins_folk ])
    dwarf_captain        = _declare_hero("Dwarf Captain",              "Dwarf Captains",                     [ :durins_folk ])
    dwarf_captain_shield = _declare_hero("Dwarf Captain with shield",  "Dwarf Captains with shield",         [ :durins_folk ])
    dwarf_shieldbearer = _declare_hero("Dwarf Shieldbearer",           "Dwarf Shieldbearers",                [ :durins_folk ])
    kings_champion   = _declare_hero("King's Champion",                   "King's Champions",                [ :durins_folk ])
    kings_champion_h = _declare_hero("King's Champion Herald" ,           "King's Champion Heralds",         [ :durins_folk ])

    dwarf_iron_gd     = _declare_warrior("Iron Guard",                          "Iron Guards",                           [ :durins_folk ])
    dwarf_khazad_gd   = _declare_warrior("Khazad Guard",                        "Khazad Guards",                         [ :durins_folk ])
    dwarf_r_bow       = _declare_warrior("Dwarf Ranger with Dwarf longbow",     "Dwarf Rangers with Dwarf longbow",      [ :durins_folk ])
    dwarf_r_axe       = _declare_warrior("Dwarf Ranger with throwing axe",      "Dwarf Rangers with throwing axe",       [ :durins_folk ])
    dwarf_r_2h        = _declare_warrior("Dwarf Ranger with two-handed weapon", "Dwarf Rangers with two-handed weapons", [ :durins_folk ])
    dwarf_w_bow       = _declare_warrior("Dwarf Warrior with Dwarf bow",        "Dwarf Warriors with Dwarf bow",         [ :durins_folk ])
    dwarf_w_shield    = _declare_warrior("Dwarf Warrior with shield",           "Dwarf Warriors with shield",            [ :durins_folk ])
    dwarf_w_2h        = _declare_warrior("Dwarf Warrior with two-handed axe",   "Dwarf Warriors with two-handed axe",    [ :durins_folk ])
    dwarf_w_banner    = _declare_warrior("Dwarf Warrior with banner",           "Dwarf Warriors with banner",            [ :durins_folk ])
    dwarf_w_warhorn   = _declare_warrior("Dwarf Warrior with war horn",         "Dwarf Warriors with war horn",          [ :durins_folk ])
    vault_team_shield = _declare_warrior("Vault Warden Team Shieldman",         "Vault Warden Teams Shieldmen",          [ :durins_folk ])
    vault_team_spear  = _declare_warrior("Vault Warden Team Spearman",          "Vault Warden Team Spearmen",            [ :durins_folk ])

    dwarf_ballista      = _declare_siege("Dwarf Ballista", "Dwarf Ballistas",                [ :durins_folk ])
    dwarf_ballista_crew = _declare_siege("Dwarf Ballista Crewman", "Dwarf Ballista Crewmen", [ :durins_folk ])

    #########################################################################
    # FIGURES: DOL GULDUR
    #########################################################################

    dark_headsman    = _declare_unique("The Dark Headsman",          [ :dol_guldur ])
    dungeon_keeper   = _declare_unique("The Keeper of the Dungeons", [ :dol_guldur ])
    forsaken         = _declare_unique("The Forsaken",               [ :dol_guldur ])
    lingering_shadow = _declare_unique("The Lingering Shadow",       [ :dol_guldur ])
    necromancer      = _declare_unique("The Necromancer",            [ :dol_guldur ])
    spider_queen     = _declare_unique("Spider Queen",               [ :moria ])

    abyssal_knight   = _declare_hero("The Abyssal Knight", "Abyssal Knights", [ :dol_guldur ])
    slayer_of_men    = _declare_hero("The Slayer of Men",  "Slayers of Men",  [ :dol_guldur ])

    castellan       = _declare_warrior("Castellan of Dol Guldur", "Castellans of Dol Guldur")
    bat_swarm       = _declare_warrior("Bat Swarm",               "Bat Swarms", [ :moria ])
    giant_spider    = _declare_warrior("Giant Spider",            "Giant Spiders", [ :moria ])
    mirkwood_spider = _declare_warrior("Mirkwood Spider",         "Mirkwood Spiders", [ :mirkwood ])

    #########################################################################
    # FIGURES: EASTERLINGS
    #########################################################################

    amdur        = _declare_unique("Amdûr, Lord of Blades",              [              :easterlings ])
    khamul       = _declare_unique("Khamûl the Easterling",              [ :dol_guldur, :easterlings, :nazgul ])
    khamul_horse = _declare_unique("Khamûl the Easterling on horseback", [              :easterlings, :nazgul ])

    dragon_knight            = _declare_hero("Easterling Dragon Knight",    "Easterling Dragon Knights",    [ :easterlings ])
    easterling_captain       = _declare_hero("Easterling Captain",          "Easterling Captains",          [ :easterlings ])
    easterling_war_priest    = _declare_hero("Easterling War Priest",       "Easterling War Priests",       [ :easterlings ])
    khandish_chieftain       = _declare_hero("Khandish Chieftain",          "Khandish Chieftains",          [ :easterlings ])
    khandish_chieftain_horse = _declare_hero("Khandish Chieftain on horse", "Khandish Chieftains on horse", [ :easterlings ])
    khandish_king            = _declare_hero("Khandish King",               "Khandish Kings",               [ :easterlings ])
    khandish_king_chariot    = _declare_hero("Khandish King in chariot",    "Khandish Kings in chariot",    [ :easterlings ])

    easterling_w_shield        = _declare_warrior("Easterling Warrior with shield",           "Easterling Warriors with shield",           [ :easterlings ])
    easterling_w_bow           = _declare_warrior("Easterling Warrior with bow",              "Easterling Warriors with bow",              [ :easterlings ])
    easterling_w_shield_spear  = _declare_warrior("Easterling Warrior with shield and spear", "Easterling Warriors with shield and spear", [ :easterlings ])
    easterling_w_banner        = _declare_warrior("Easterling Warrior with banner",           "Easterling Warriors with banner",           [ :easterlings ])
    easterling_kataphrakt      = _declare_warrior("Easterling Kataphrakt",                    "Easterling Kataphrakts",                    [ :easterlings ])
    khandish_charioteer        = _declare_warrior("Khandish Charioteer with bow",             "Khandish Charioteers with bow",             [ :easterlings ])
    khandish_w_bow             = _declare_warrior("Khandish Warrior with bow",                "Khandish Warriors with bow",                [ :easterlings ])
    khandish_w_axe             = _declare_warrior("Khandish Warrior with two-handed axe",     "Khandish Warriors with two-handed axe",     [ :easterlings ])
    khandish_horseman          = _declare_warrior("Khandish Horseman",                        "Khandish Horsemen",                         [ :easterlings ])

    #########################################################################
    # FIGURES: FELLOWSHIP
    #########################################################################

    aragorn       = _declare_unique("Aragorn",          [ :arnor,       :fellowship, :minas_tirith ])
    aragorn_horse = _declare_unique("Aragorn on horse", [               :fellowship, :minas_tirith ])
    frodo         = _declare_unique("Frodo",            [               :fellowship, :shire ])
    frodo_pony    = _declare_unique("Frodo on pony",    [                            :shire ])
    gimli           = _declare_unique("Gimli (Fellowship)",            [ :durins_folk, :fellowship ])
    gimli_amonhen   = _declare_unique("Gimli (Amon Hen)",            [ :durins_folk, :fellowship ])
    gimli_breaking  = _declare_unique("Gimli (Breaking)",            [ :durins_folk, :fellowship ])
    gimli_helmsdeep = _declare_unique("Gimli (Amon Hen)",            [ :durins_folk, :fellowship ])
    gimli_hornburg  = _declare_unique("Gimli (Hornburg)",            [ :durins_folk, :fellowship ])
    gimli_hunter    = _declare_unique("Gimli (Hunter)",              [ :durins_folk, :fellowship ])
    gimli_pelennor  = _declare_unique("Gimli (Pelennor)",            [ :durins_folk, :fellowship ])
    gimli_uruk_hai  = _declare_unique("Gimli on dead Uruk-hai")
    gimli_all_foot = [ gimli, gimli_amonhen, gimli_breaking, gimli_helmsdeep, gimli_hornburg, gimli_hunter, gimli_pelennor ]

    legolas       = _declare_unique("Legolas",          [ :lothlorien,  :fellowship, :white_council, :thranduil ])
    legolas_horse = _declare_unique("Legolas on horse", [ :lothlorien,  :fellowship, :white_council, :thranduil ])
    merry         = _declare_unique("Merry",            [               :fellowship, :shire ])
    merry_pony    = _declare_unique("Merry on pony",    [                            :shire ])
    pippin        = _declare_unique("Pippin",           [               :fellowship, :shire ])
    pippin_pony   = _declare_unique("Pippin on pony",   [                            :shire ])
    sam           = _declare_unique("Sam",              [               :fellowship, :shire ])
    sam_pony      = _declare_unique("Sam on pony",      [                            :shire ])

    #########################################################################
    # FIGURES: FREE PEOPLES / WANDERERS IN THE WILD
    #########################################################################

    beorn               = _declare_unique("Beorn",                             [ :radagast ])
    cirdan              = _declare_unique("Círdan",                            [ :rivendell, :white_council ])
    gandalf_grey_bilbo       = _declare_unique("Gandalf the Grey (with Bilbo)",          [ :fellowship, :survivors, :thorins_co, :white_council ])
    gandalf_grey_fellowship  = _declare_unique("Gandalf the Grey (Fellowship)",          [ :fellowship, :survivors, :thorins_co, :white_council ])
    gandalf_grey_fellowship2 = _declare_unique("Gandalf the Grey (Fellowship, Plastic)", [ :fellowship, :survivors, :thorins_co, :white_council ])
    gandalf_grey_goblintown  = _declare_unique("Gandalf the Grey (Goblintown)",          [ :fellowship, :survivors, :thorins_co, :white_council ])
    gandalf_grey_hobbit      = _declare_unique("Gandalf the Grey (Hobbit)",              [ :fellowship, :survivors, :thorins_co, :white_council ])
    gandalf_grey_khazaddum   = _declare_unique("Gandalf the Grey (Khazad-dûm)",          [ :fellowship, :survivors, :thorins_co, :white_council ])
    gandalf_grey_mines       = _declare_unique("Gandalf the Grey (Mines of Moria)",      [ :fellowship, :survivors, :thorins_co, :white_council ])
    gandalf_grey_orthanc     = _declare_unique("Gandalf the Grey (Orthanc)",             [ :fellowship, :survivors, :thorins_co, :white_council ])
    gandalf_grey_rivendell   = _declare_unique("Gandalf the Grey (Rivendell)",           [ :fellowship, :survivors, :thorins_co, :white_council ])
    gandalf_grey_council     = _declare_unique("Gandalf the Grey (White Council)",       [ :fellowship, :survivors, :thorins_co, :white_council ])
    gandalf_grey_cart        = _declare_unique("Gandalf the Grey on cart",               [ :fellowship ])
    gandalf_grey_horse       = _declare_unique("Gandalf the Grey on horse",              [ :fellowship, :survivors, :thorins_co, :white_council ])

    gandalf_grey_foot_all = [ gandalf_grey_bilbo, gandalf_grey_fellowship, gandalf_grey_fellowship2, gandalf_grey_goblintown, gandalf_grey_hobbit,
                              gandalf_grey_khazaddum, gandalf_grey_mines, gandalf_grey_orthanc, gandalf_grey_rivendell, gandalf_grey_council       ]

    gandalf_white          = _declare_unique("Gandalf the White",                 [ :fellowship ])
    gandalf_white_bgime    = _declare_unique("Gandalf the White (BGiME)",         [ :fellowship ])
    gandalf_white_pelennor = _declare_unique("Gandalf the White (Pelennor)",      [ :fellowship ])
    gandalf_white_horse    = _declare_unique("Gandalf the White on Shadowfax",                 [ :fellowship ])
    gandalf_white_horse_mt = _declare_unique("Gandalf the White on Shadowfax (Minas Tirith)",  [ :fellowship ])
    ghan_buri_ghan      = _declare_unique("Ghân-buri-ghân",                    [ :wanderers ])
    goldberry           = _declare_unique("Goldberry",                         [ :wanderers ])
    gwaihir             = _declare_unique("Gwaihir",                           [ :radagast, :wanderers ])
    radagast_goblintown = _declare_unique("Radagast the Brown (Goblintown)",   [ :radagast, :white_council ])
    radagast_lotr       = _declare_unique("Radagast the Brown (LotR)",         [ :radagast, :white_council ])
    radagast_sebastian  = _declare_unique("Radagast the Brown with Sebastian", [ :radagast, :white_council ])
    radagast_eagle      = _declare_unique("Radagast the Brown on Great Eagle", [ :radagast ])
    radagast_sleigh     = _declare_unique("Radagast the Brown on sleigh",      [ :radagast ])
    saruman             = _declare_unique("Saruman (Two Towers)",              [ :isengard, :white_council ])
    saruman_council     = _declare_unique("Saruman (White Council)",           [ :isengard, :white_council ])
    saruman_orthanc     = _declare_unique("Saruman (Orthanc)",                 [ :isengard, :white_council ])
    saruman_palantir    = _declare_unique("Saruman with Palantir",             [ :isengard, :white_council ])
    saruman_vanquisher  = _declare_unique("Saruman (Vanquishers of the Necromancer", [ :isengard, :white_council ])
    saruman_white       = _declare_unique("Saruman the White",                 [ :isengard, :white_council ])
    saruman_horse       = _declare_unique("Saruman on horse",                  [ :isengard, :white_council ])

    saruman_foot_all = [ saruman, saruman_council, saruman_orthanc, saruman_palantir, saruman_vanquisher, saruman_white ]

    tom_bombadil        = _declare_unique("Tom Bombadil",                      [ :wanderers ])
    treebeard           = _declare_unique("Treebeard",                         [ :wanderers ])

    wose = _declare_warrior("Wose", "Woses", [ :wanderers ])

    eagle = _declare_monster("Giant Eagle", "Giant Eagles", [ :radagast, :wanderers ])
    ent   = _declare_monster("Ent",         "Ents",         [ :wanderers ])

    #########################################################################
    # FIGURES: GOBLINTOWN
    #########################################################################

    goblin_king   = _declare_unique("The Goblin King",   [ :goblintown ])
    goblin_scribe = _declare_unique("The Goblin Scribe", [ :goblintown ])
    grinnah       = _declare_unique("Grinnah",           [ :goblintown ])

    goblintown_captain = _declare_hero("Goblin Captain", "Goblin Captains", [ :goblintown ])

    goblintown_g = _declare_warrior("Goblin Warrior", "Goblin Warriors", [ :goblintown ])

    #########################################################################
    # FIGURES: GONDOR
    #########################################################################

    angbor              = _declare_unique("Angbor the Fearless", [ :fiefdoms ])
    beregond            = _declare_unique("Beregond", [ :minas_tirith ])
    boromir             = _declare_unique("Boromir", [ :fellowship, :minas_tirith ])
    boromir_wt_banner   = _declare_unique("Boromir of the White Tower with Banner", [ :minas_tirith ])
    boromir_wt_horse    = _declare_unique("Boromir of the White Tower on horse", [ :minas_tirith ])
    damrod              = _declare_unique("Damrod",   [ :minas_tirith ])
    denethor            = _declare_unique("Denethor", [ :minas_tirith ])
    duinhir             = _declare_unique("Duinhir",  [ :fiefdoms ])
    cirion              = _declare_unique("Cirion",   [ :minas_tirith ])
    faramir             = _declare_unique("Faramir",  [ :minas_tirith ])
    faramir_armor_horse = _declare_unique("Faramir, Captain of Gondor with heavy armour and horse", [ :minas_tirith ])
    forlong             = _declare_unique("Forlong the Fat",              [ :fiefdoms ])
    forlong_horse       = _declare_unique("Forlong the Fat on horse",     [ :fiefdoms ])
    imrahil             = _declare_unique("Prince Imrahil of Dol Amroth", [ :fiefdoms ])
    imrahil_horse       = _declare_unique("Prince Imrahil on horse",      [ :fiefdoms ])
    king_dead           = _declare_unique("King of the Dead",             [ :fiefdoms ])
    madril              = _declare_unique("Madril",                         [ :minas_tirith ])
    pippin_gondor       = _declare_unique("Peregrin, Guard of the Citadel", [ :minas_tirith ])

    king_of_men             = _declare_hero("King of Men",                      "Kings of Men",                      [ :minas_tirith ])
    knight_white_tower      = _declare_hero("Knight of the White Tower",        "Knights of the White Tower",        [ :minas_tirith ])
    gondor_captain_mt       = _declare_hero("Captain of Minas Tirith",          "Captains of Minas Tirith",          [ :minas_tirith ])
    gondor_captain_mt_horse = _declare_hero("Captain of Minas Tirith on horse", "Captains of Minas Tirith on horse", [ :minas_tirith ])
    gondor_captain_da       = _declare_hero("Captain of Dol Amroth",            "Captains of Dol Amroth",            [ :fiefdoms ])

    axemen_lossarnach            = _declare_warrior("Axeman of Lossarnach",                          "Axemen of Lossarnach",   [ :fiefdoms ])
    blackroot_vale_archer        = _declare_warrior("Blackroot Vale Archer",                         "Blackroot Vale Archers", [ :fiefdoms ])
    clansmen_lamedon             = _declare_warrior("Clansman of Lamedon",                           "Clansmen of Lamedon",    [ :fiefdoms ])
    fountain_court_gd            = _declare_warrior("Guard of the Fountain Court",                   "Guards of the Fountain Court", [ :minas_tirith ])
    dead_rider                   = _declare_warrior("Rider of the Dead",                             "Riders of the Dead",     [ :fiefdoms ])
    dead_w                       = _declare_warrior("Warrior of the Dead",                           "Warriors of the Dead",   [ :fiefdoms ])
    gondor_citadel_gd_spear      = _declare_warrior("Citadel Guard with spear",                      "Citadel Guards with spear",           [ :minas_tirith ])
    gondor_citadel_gd_bow        = _declare_warrior("Citadel Guard with longbow",                    "Citadel Guards with longbow",         [ :minas_tirith ])
    gondor_knight                = _declare_warrior("Knight of Minas Tirith",                        "Knights of Minas Tirith",             [ :minas_tirith ])
    gondor_knight_banner         = _declare_warrior("Knight of Minas Tirith with banner",            "Knights of Minas Tirith with banner", [ :minas_tirith ])
    gondor_knight_shield         = _declare_warrior("Knight of Minas Tirith with shield",            "Knights of Minas Tirith with shield", [ :minas_tirith ])
    gondor_knight_da_foot        = _declare_warrior("Foot Knight of Dol Amroth",                     "Foot Knights of Dol Amroth",             [ :fiefdoms ])
    gondor_knight_da_foot_banner = _declare_warrior("Foot Knight of Dol Amroth with banner",         "Foot Knights of Dol Amroth with banner", [ :fiefdoms ])
    gondor_knight_da_horse       = _declare_warrior("Knight of Dol Amroth",                          "Knights of Dol Amroth",                  [ :fiefdoms ])
    gondor_rog                   = _declare_warrior("Ranger of Gondor",                              "Rangers of Gondor",                              [ :minas_tirith ])
    gondor_rog_spear             = _declare_warrior("Ranger of Gondor with spear",                   "Rangers of Gondor with spear",                   [ :minas_tirith ])
    gondor_womt_banner           = _declare_warrior("Warrior of Minas Tirith with banner",           "Warriors of Minas Tirith with banner",           [ :minas_tirith ])
    gondor_womt_bow              = _declare_warrior("Warrior of Minas Tirith with bow",              "Warriors of Minas Tirith with bow",              [ :minas_tirith ])
    gondor_womt_shield           = _declare_warrior("Warrior of Minas Tirith with shield",           "Warriors of Minas Tirith with shield",           [ :minas_tirith ])
    gondor_womt_spear_shield     = _declare_warrior("Warrior of Minas Tirith with spear and shield", "Warriors of Minas Tirith with spear and shield", [ :minas_tirith ])
    maa_da                       = _declare_warrior("Man at Arms of Dol Amroth",                     "Men at Arms of Dol Amroth",      [ :fiefdoms ])
    osgiliath_v_bow              = _declare_warrior("Osgiliath Veteran with bow",                    "Osgiliath Veterans with bow",    [ :minas_tirith ])
    osgiliath_v_shield           = _declare_warrior("Osgiliath Veteran with shield",                 "Osgiliath Veterans with shield", [ :minas_tirith ])
    osgiliath_v_spear            = _declare_warrior("Osgiliath Veteran with spear",                  "Osgiliath Veterans with spear",  [ :minas_tirith ])

    avenger        = _declare_siege("Avenger Bolt Thrower",      "Avenger Bolt Throwers",     [ :minas_tirith ])
    avenger_crew   = _declare_siege("Avenger Bolt Thrower crew", "Avenger Bolt Thrower crew", [ :minas_tirith ])
    trebuchet      = _declare_siege("Battlecry Trebuchet",       "Battlecry Trebuchets",      [ :minas_tirith ])
    trebuchet_crew = _declare_siege("Battlecry Trebuchet crew",  "Battlecry Trebuchet crew",  [ :minas_tirith ])

    #########################################################################
    # FIGURES: HARAD
    #########################################################################

    betrayer      = _declare_unique("The Betrayer",                      [ :harad ])
    dalamyr       = _declare_unique("Dalamyr, Corsair Fleet Master",     [ :harad ])
    golden_king   = _declare_unique("The Golden King of Abrakhân",       [ :harad ])
    knight_umbar  = _declare_unique("The Knight of Umbar",               [ :harad ])
    suladan       = _declare_unique("Suladân",                           [ :harad ])
    suladan_horse = _declare_unique("Suladân the Serpent Lord on horse", [ :harad ])

    corsair_bosun         = _declare_hero("Corsair Bo'sun",              "Corsair Bo'suns",              [ :harad ])
    corsair_captain       = _declare_hero("Corsair Captain",             "Corsair Captains",             [ :harad ])
    harad_chieftain       = _declare_hero("Haradrim Chieftain",          "Haradrim Chieftains",          [ :harad ])
    harad_chieftain_horse = _declare_hero("Haradrim Chieftain on horse", "Haradrim Chieftains on horse", [ :harad ])
    harad_king_horse      = _declare_hero("Haradrim King on horse",      "Haradrim Kings on horse",      [ :harad ])
    harad_taskmaster      = _declare_hero("Haradrim Taskmaster",         "Haradrim Taskmasters",         [ :harad ])
    hasharin              = _declare_hero("Hâsharin",                    "Hâsharii",                     [ :harad ])
    mahud_king            = _declare_hero("Mahud King",                  "Mahud Kings",                  [ :harad ])
    mahud_tribesmaster    = _declare_hero("Mahûd Tribesmaster",          "Mahûd Tribesmasters",          [ :harad ])

    abrakhan_gd        = _declare_warrior("Abrakhân Merchant Guard",           "Abrakhân Merchant Guards",             [ :harad ])
    black_numenorean   = _declare_warrior("Black Numenórean",                  "Black Numenóreans",                    [ :harad, :minas_morgul ])
    corsair_arbalester = _declare_warrior("Corsair Arbalester",                "Corsair Arbalesters",                  [ :harad ])
    corsair_reaver     = _declare_warrior("Corsair Reaver",                    "Corsair Reavers",                      [ :harad ])
    corsair_w_bow      = _declare_warrior("Corsair of Umbar with bow",         "Corsair of Umbar with bow",            [ :harad ])
    corsair_w_shield   = _declare_warrior("Corsair of Umbar with shield",      "Corsair of Umbar with shield",         [ :harad ])
    corsair_w_spear    = _declare_warrior("Corsair of Umbar with spear",       "Corsair of Umbar with spear",          [ :harad ])
    golden_king_bearer = _declare_warrior("The Golden King of Abrakhân Bearer", "The Golden King of Abrakhân Bearers", [ :harad ])
    half_troll         = _declare_warrior("Half Troll",                        "Half Trolls",                          [ :harad ])
    half_troll_2h      = _declare_warrior("Half Troll with two-handed weapon", "Half Trolls with two-handed-weapon",   [ :harad ])
    harad_raider       = _declare_warrior("Haradrim Raider",                   "Haradrim Raiders",                     [ :harad ])
    harad_raider_lance = _declare_warrior("Haradrim Raider with lance",        "Haradrim Raiders with lance",          [ :harad ])
    harad_w_banner     = _declare_warrior("Haradrim Warrior with banner",      "Haradrim Warriors with banner",        [ :harad ])
    harad_w_bow        = _declare_warrior("Haradrim Warrior with bow",         "Haradrim Warriors with bow",           [ :harad ])
    harad_w_spear      = _declare_warrior("Haradrim Warrior with spear",       "Haradrim Warriors with spear",         [ :harad ])
    mahud_beastmaster  = _declare_warrior("Mahûd Beastmaster Chieftain",       "Mahûd Beastmaster Chieftain",          [ :harad ])
    mahud_raider       = _declare_warrior("Mahûd Raider",                      "Mahûd Raiders",                        [ :harad ])
    mahud_w_blowpipe   = _declare_warrior("Mahûd Warrior with blowpipe",       "Mahûd Warriors with blowpipe",         [ :harad ])
    mahud_w_spear      = _declare_warrior("Mahûd Warrior with spear",          "Mahûd Warriors with spear",            [ :harad ])
    serpent_gd         = _declare_warrior("Serpent Guard",                     "Serpent Guards",                       [ :harad ])
    serpent_rider      = _declare_warrior("Serpent Rider",                     "Serpent Riders",                       [ :harad ])
    watcher_karna      = _declare_warrior("Watcher of Karna",                  "Watchers of Karna",                    [ :harad ])

    mumak       = _declare_monster("Mûmak",       "Mûmakil",      [ :harad ])
    mumak_mahud = _declare_warrior("Mûmak Mahud", "Mûmak Mahuds", [ :harad ])

    #########################################################################
    # FIGURES: IRON HILLS
    #########################################################################

    dain_ironfoot      = _declare_unique("Dain Ironfoot",             [ :iron_hills, :erebor ])
    dain_ironfoot_boar = _declare_unique("Dain Ironfoot on war boar", [ :iron_hills, :erebor ])

    iron_hills_captain_goat = _declare_hero("Iron Hills Captain on goat", "Iron Hills Captains on goat", [ :iron_hills, :erebor ])
    iron_hills_captain      = _declare_hero("Iron Hills Captain",         "Iron Hills Captains",         [ :iron_hills, :erebor ])

    iron_hills_chariot            = _declare_warrior("Iron Hills Chariot",                     "Iron Hills Chariots",    [ :iron_hills, :erebor ])
    iron_hills_goat_rider         = _declare_warrior("Iron Hills Goat Rider",                  "Iron Hills Goat Riders", [ :iron_hills, :erebor ])
    iron_hills_dwarf              = _declare_warrior("Iron Hills Dwarf",                       "Iron Hills Dwarves",     [ :iron_hills, :erebor ])
    iron_hills_dwarf_shield_spear = _declare_warrior("Iron Hills Dwarf with spear and shield", "Iron Hills Dwarves with spear and shield", [ :iron_hills, :erebor ])

    iron_hills_ballista      = _declare_siege("Iron Hills Ballista",         "Iron Hills Ballistae",      [ :iron_hills ])
    iron_hills_ballista_crew = _declare_siege("Iron Hills Ballista Crewman", "Iron Hills Ballistae Crew", [ :iron_hills ])

    #########################################################################
    # FIGURES: ISENGARD
    #########################################################################

    grima       = _declare_unique("Grima Wormtongue",   [ :isengard ])
    lurtz       = _declare_unique("Lurtz",              [ :isengard ])
    mauhur      = _declare_unique("Mauhúr",             [ :isengard ])
    sharkey     = _declare_unique("Sharkey",            [ :isengard ])
    sharku      = _declare_unique("Sharku",             [ :isengard ])
    sharku_warg = _declare_unique("Sharku on Warg",     [ :isengard ])
    thrydan     = _declare_unique("Thrydan Wolvesbane", [ :isengard ])
    ugluk       = _declare_unique("Uglúk",              [ :isengard ])
    vrasku      = _declare_unique("Vraskû",             [ :isengard ])
    worm        = _declare_unique("Worm",               [ :isengard ])

    dunlending_chieftain    = _declare_hero("Dunlending Chieftain",                 "Dunlending Chieftains",                 [ :isengard ])
    uruk_hai_captain_shield = _declare_hero("Uruk-hai Captain with shield",         "Uruk-hai Captains with shield",         [ :isengard ])
    uruk_hai_captain_2h     = _declare_hero("Uruk-hai Captain with two-handed axe", "Uruk-hai Captains with two-handed axe", [ :isengard ])
    uruk_hai_shaman         = _declare_hero("Uruk-hai Shaman",                      "Uruk-hai Shamans",                      [ :isengard ])

    dunlending_w            = _declare_warrior("Dunlending",                           "Dunlendings",                        [ :isengard ])
    dunlending_w_banner     = _declare_warrior("Dunlending with banner",               "Dunlendings with banner",            [ :isengard ])
    dunlending_w_bow        = _declare_warrior("Dunlending with bow",                  "Dunlendings with bow",               [ :isengard ])
    dunlending_w_shield     = _declare_warrior("Dunlending with shield",               "Dunlendings with shield",            [ :isengard ])
    dunlending_w_2h         = _declare_warrior("Dunlending with two-handed weapon",    "Dunlendings with two-handed weapon", [ :isengard ])
    ruffian                 = _declare_warrior("Ruffian",                              "Ruffians",                           [ :isengard ])
    ruffian_bow             = _declare_warrior("Ruffian with bow",                     "Ruffians with bow",                  [ :isengard ])
    ruffian_whip            = _declare_warrior("Ruffian with whip",                    "Ruffians with whip",                 [ :isengard ])
    uruk_hai_berserker      = _declare_warrior("Uruk-hai Berserker",                   "Uruk-hai Berserkers",                   [ :isengard ])
    uruk_hai_feral          = _declare_warrior("Feral Uruk-hai",                       "Feral Uruk-hai",                        [ :isengard ])
    uruk_hai_s              = _declare_warrior("Uruk-hai Scout",                       "Uruk-hai Scouts",                       [ :isengard ])
    uruk_hai_s_sword_shield = _declare_warrior("Uruk-hai Scout with sword and shield", "Uruk-hai Scouts with sword and shield", [ :isengard ])
    uruk_hai_s_bow          = _declare_warrior("Uruk-hai Scout with bow",              "Uruk-hai Scouts with bow",              [ :isengard ])
    uruk_hai_w_banner       = _declare_warrior("Uruk-hai Warrior with banner",         "Uruk-hai Warriors with banner",         [ :isengard ])
    uruk_hai_w_crossbow     = _declare_warrior("Uruk-hai Warrior with crossbow",       "Uruk-hai Warriors with crossbow",       [ :isengard ])
    uruk_hai_w_pike         = _declare_warrior("Uruk-hai Warrior with pike",           "Uruk-hai Warriors with pike",           [ :isengard ])
    uruk_hai_w_shield       = _declare_warrior("Uruk-hai Warrior with shield",         "Uruk-hai Warriors with shield",         [ :isengard ])
    wild_man_dunland        = _declare_warrior("Wild Man of Dunland",                  "Wild Men of Dunland",                   [ :isengard ])

    isengard_troll = _declare_monster("Isengard Troll", "Isengard Trolls", [ :isengard ])

    battering_ram           = _declare_siege("Battering Ram",                 "Battering Rams")
    uruk_hai_demo_charge    = _declare_siege("Uruk-hai Demolition Charge",    "Uruk-hai Demolition Charges",   [ :isengard ])
    uruk_hai_demo_crew      = _declare_siege("Uruk-hai Demolition Crew",      "Uruk-hai Demolition Crew",      [ :isengard ])
    uruk_hai_demo_berserker = _declare_siege("Uruk-hai Demolition Berserker", "Uruk-hai Demolition Bersekers", [ :isengard ])
    uruk_hai_ballista       = _declare_siege("Uruk-hai Siege Ballista",       "Uruk-hai Siege Ballistas",      [ :isengard ])
    uruk_hai_ballista_crew  = _declare_siege("Uruk-hai Siege Ballista crew",  "Uruk-hai Siege Ballista crew",  [ :isengard ])

    #########################################################################
    # FIGURES: LAKETOWN
    #########################################################################

    alfrid          = _declare_unique("Alfrid",                         [ :laketown, :survivors ])
    bain            = _declare_unique("Bain, Son of Bard",              [ :laketown, :survivors ])
    bard            = _declare_unique("Bard the Bowman",                [ :laketown, :survivors ])
    bard_windlance  = _declare_unique("Bard the Bowman with Windlance", [ :laketown, :survivors ])
    braga           = _declare_unique("Braga, Captain of the Guard",    [ :laketown ])
    hilda           = _declare_unique("Hilda Bianca",                   [            :survivors ])
    master_laketown = _declare_unique("The Master of Lake-town",        [ :laketown ])
    percy           = _declare_unique("Percy",                          [            :survivors ])
    sigrid          = _declare_unique("Sigrid",                         [ :laketown, :survivors ])
    tilda           = _declare_unique("Tilda",                          [ :laketown, :survivors ])

    laketown_gd_captain = _declare_hero("Lake-town Guard Captain", "Lake-town Guard Captains", [ :laketown, :survivors ])

    laketown_gd_w_bow       = _declare_warrior("Lake-town Guard with bow",      "Lake-town Guards with bow",   [ :laketown ])
    laketown_gd_w_spear     = _declare_warrior("Lake-town Guard with spear",    "Lake-town Guards with spear", [ :laketown ])
    laketown_gd_w_sword     = _declare_warrior("Lake-town Guard with sword",    "Lake-town Guards with sword", [ :laketown ])
    laketown_militia_bow    = _declare_warrior("Lake-town Militia with bow",    "Lake-town Militia with bow",    [ :survivors ])
    laketown_militia_shield = _declare_warrior("Lake-town Militia with shield", "Lake-town Militia with shield", [ :survivors ])
    laketown_militia_spear  = _declare_warrior("Lake-town Militia with spear",  "Lake-town Militia with spear",  [ :survivors ])

    #########################################################################
    # FIGURES: LOTHLORIEN
    #########################################################################

    celeborn       = _declare_unique("Celeborn",                         [ :lothlorien, :white_council ])
    galadriel      = _declare_unique("Galadriel",                        [ :lothlorien, :white_council ])
    galadriel_lotg = _declare_unique("Galadriel, Lady of the Galadhrim", [ :lothlorien ])
    haldir         = _declare_unique("Haldir",                           [ :lothlorien ])
    rumil          = _declare_unique("Rúmil",                            [ :lothlorien ])

    galadhrim_captain     = _declare_hero("Galadhrim Captain",     "Galadhrim Captains",     [ :lothlorien ])
    galadhrim_stormcaller = _declare_hero("Galadhrim Stormcaller", "Galadhrim Stormcallers", [ :lothlorien ])

    galadhrim_gd      = _declare_warrior("Guard of the Galadhrim Court",       "Guards of the Galadhrim Court",       [ :lothlorien ])
    galadhrim_knight  = _declare_warrior("Galadhrim Knight",                   "Galadhrim Knights",                   [ :lothlorien ])
    galadhrim_w_blade = _declare_warrior("Galadhrim Warrior with Elven blade", "Galadhrim Warriors with Elven blade", [ :lothlorien ])
    galadhrim_w_bow   = _declare_warrior("Galadhrim Warrior with Elf bow",     "Galadhrim Warriors with Elf bow",     [ :lothlorien ])

    #########################################################################
    # FIGURES: MIRKWOOD
    #########################################################################

    tauriel   = _declare_unique("Tauriel", [ :thranduil ])
    thranduil = _declare_unique("Thranduil", [ :lothlorien, :thranduil, :white_council ])

    palace_gd_captain       = _declare_hero("Palace Guard Captain",    "Palace Guard Captains",    [ :thranduil ])
    mirkwood_captain        = _declare_hero("Mirkwood Captain",        "Mirkwood Captains",        [ :thranduil ])
    mirkwood_ranger_captain = _declare_hero("Mirkwood Ranger Captain", "Mirkwood Ranger Captains", [ :thranduil ])
    wood_elf_captain        = _declare_hero("Wood Elf Captain",        "Wood Elf Captains",        [ :lothlorien ])

    mirkwood_cavalry       = _declare_warrior("Mirkwood Cavalry",                                      "Mirkwood Cavalry",           [ :thranduil ])
    mirkwood_elf_bow       = _declare_warrior("Mirkwood Elf with bow",                                 "Mirkwood Elves with bow",    [ :thranduil ])
    mirkwood_elf_glaive    = _declare_warrior("Mirkwood Elf with glaive",                              "Mirkwood Elves with glaive", [ :thranduil ])
    mirkwood_elf_shield    = _declare_warrior("Mirkwood Elf with shield",                              "Mirkwood Elves with shield", [ :thranduil ])
    mirkwood_palace_gd     = _declare_warrior("Palace Guard",                                          "Palace Guards",              [ :thranduil ])
    mirkwood_ranger        = _declare_warrior("Mirkwood Ranger",                                       "Mirkwood Rangers",           [ :thranduil ])
    wood_elf_sentinel      = _declare_warrior("Wood Elf Sentinel",                                     "Wood Elf Sentinels", [ :lothlorien ])
    wood_elf_w_armor_bow   = _declare_warrior("Wood Elf Warrior with armour and Elf bow",              "Wood Elf Warriors with armour and Elf bow",     [ :lothlorien ])
    wood_elf_w_armor_blade = _declare_warrior("Wood Elf Warrior with armour and Elven blade",          "Wood Elf Warriors with armour and Elven blade", [ :lothlorien ])
    wood_elf_w_armor_spear = _declare_warrior("Wood Elf Warrior with armour and spear",                "Wood Elf Warriors with armour and spear",       [ :lothlorien ])
    wood_elf_w_banner      = _declare_warrior("Wood Elf Warrior with banner",                          "Wood Elf Warriors with banner",                 [ :lothlorien ])
    wood_elf_w_blade       = _declare_warrior("Wood Elf Warrior with Elven blade and throwing dagger", "Wood Elf Warriors with Elven blade and throwing dagger", [ :lothlorien ])
    wood_elf_w_bow         = _declare_warrior("Wood Elf Warrior with bow",                             "Wood Elf Warriors with bow",                    [ :lothlorien ])
    wood_elf_w_spear       = _declare_warrior("Wood Elf Warrior with spear",                           "Wood Elf Warriors with spear",                  [ :lothlorien ])

    #########################################################################
    # FIGURES: MORDOR
    #########################################################################

    dark_marshal         = _declare_unique("The Dark Marshal", [ :nazgul ])
    gollum               = _declare_unique("Gollum")
    gorbag               = _declare_unique("Gorbag",    [ :cirith_ungol ])
    gothmog              = _declare_unique("Gothmog",   [ :minas_morgul ])
    grishnakh            = _declare_unique("Grishnákh", [ :minas_morgul ])
    #khamul in Easterlings
    mouth                = _declare_unique("Mouth of Sauron",                    [ :barad_dur, :black_gate ])
    mouth_horse          = _declare_unique("Mouth of Sauron on armoured horse",  [ :barad_dur, :black_gate ])
    sauron               = _declare_unique("Sauron",                             [ :barad_dur ])
    shadow_lord          = _declare_unique("The Shadow Lord", [ :nazgul ])
    shagrat              = _declare_unique("Shagrat", [ :cirith_ungol ])
    shelob               = _declare_unique("Shelob",  [ :cirith_ungol ])
    smeagol              = _declare_unique("Sméagol", [ :fellowship ])
    tainted              = _declare_unique("The Tainted",                        [ :angmar, :nazgul ])
    undying              = _declare_unique("The Undying",                        [          :nazgul ])
    witch_king           = _declare_unique("Witch-king of Angmar",               [ :angmar, :dol_guldur, :nazgul ])
    witch_king_flail     = _declare_unique("Witch-king of Angmar with flail",    [ :angmar, :nazgul ])
    witch_king_horse     = _declare_unique("Witch-king of Angmar on horse",      [ :angmar, :nazgul ])
    witch_king_fellbeast = _declare_unique("Witch-king of Angmar on Fell Beast", [ :angmar, :nazgul ])

    black_numenorian_marshal = _declare_hero("Black Numenórean Marshal",                "Black Numenórean Marshals", [ :minas_morgul ])
    m_orc_captain        = _declare_hero("Morannon Orc Captain",                        "Morannon Orc Captains",                        [ :barad_dur, :black_gate ])
    m_orc_captain_2h     = _declare_hero("Morannon Orc Captain with two-handed weapon", "Morannon Orc Captains with two-handed weapon", [ :barad_dur, :black_gate ])
    mordor_uruk_captain  = _declare_hero("Mordor Uruk-hai Captain",                     "Mordor Uruk-hai Captains", [ :black_gate, :cirith_ungol ])
    orc_captain          = _declare_hero("Orc Captain",                                 "Orc Captains",             [ :angmar, :barad_dur, :cirith_ungol, :isengard, :minas_morgul ])
    orc_captain_warg     = _declare_hero("Orc Captain on Warg",                         "Orc Captains on Warg",     [ :angmar, :barad_dur, :cirith_ungol, :isengard, :minas_morgul ])
    orc_drummer          = _declare_hero("Orc Drummer",                                 "Orc Drummers",             [          :barad_dur, :black_gate, :cirith_ungol ])
    orc_shaman           = _declare_hero("Orc Shaman",                                  "Orc Shamans",              [ :angmar, :barad_dur, :black_gate, :cirith_ungol ])
    orc_taskmaster       = _declare_hero("Orc Taskmaster",                              "Orc Taskmasters",          [          :barad_dur, :black_gate, :cirith_ungol ])
    ringwraith           = _declare_hero("Ringwraith",                                  "Ringwraiths",                [ :nazgul ])
    ringwraith_horse     = _declare_hero("Ringwraith on horse",                         "Ringwraiths on horse",       [ :nazgul ])
    ringwraith_fellbeast = _declare_hero("Ringwraith on Fell Beast",                    "Ringwraiths on Fell Beasts", [ :nazgul ])
    troll_chieftain      = _declare_hero("Troll Chieftain",                             "Troll Chieftains", [ :black_gate ])

    m_uruk_hai              = _declare_warrior("Mordor Uruk-hai",                           "Mordor Uruk-hai",                        [ :black_gate, :cirith_ungol ])
    m_uruk_hai_shield       = _declare_warrior("Mordor Uruk-hai with shield",               "Mordor Uruk-hai with shield",            [ :black_gate, :cirith_ungol ])
    m_uruk_hai_2h           = _declare_warrior("Mordor Uruk-hai with two-handed weapon",    "Mordor Uruk-hai with two-handed weapon", [ :black_gate, :cirith_ungol ])
    morgul_knight           = _declare_warrior("Morgul Knight",                             "Morgul Knights",  [ :minas_morgul ])
    morgul_stalker          = _declare_warrior("Morgul Stalker",                            "Morgul Stalkers", [ :minas_morgul ])
    orc_m_shield            = _declare_warrior("Morannon Orc with shield",                  "Morannon Orcs with shield",            [ :barad_dur, :black_gate ])
    orc_m_shield_spear      = _declare_warrior("Morannon Orc with shield and spear",        "Morannon Orcs with shield and spear",  [ :barad_dur, :black_gate ])
    orc_m_spear             = _declare_warrior("Morannon Orc with spear",                   "Morannon Orcs with spear",             [ :barad_dur, :black_gate ])
    orc_tracker             = _declare_warrior("Orc Tracker",                               "Orc Trackers",                [ :angmar, :barad_dur, :black_gate, :cirith_ungol, :minas_morgul ])
    orc_w_banner            = _declare_warrior("Orc with banner",                           "Orcs with banner",            [ :angmar, :barad_dur, :cirith_ungol, :isengard, :minas_morgul ])
    orc_w_bow               = _declare_warrior("Orc with Orc bow",                          "Orcs with Orc bow",           [ :angmar, :barad_dur, :cirith_ungol, :isengard, :minas_morgul ])
    orc_w_shield            = _declare_warrior("Orc with shield",                           "Orcs with shield",            [ :angmar, :barad_dur, :cirith_ungol, :isengard, :minas_morgul ])
    orc_w_spear             = _declare_warrior("Orc with spear",                            "Orcs with spear",             [ :angmar, :barad_dur, :cirith_ungol, :isengard, :minas_morgul])
    orc_w_2h                = _declare_warrior("Orc with two-handed weapon",                "Orcs with two-handed weapon", [ :angmar, :barad_dur, :cirith_ungol, :isengard, :minas_morgul ])
    warg_rider_bow          = _declare_warrior("Warg Rider with bow",                       "Warg Riders with bow",        [ :angmar, :barad_dur, :cirith_ungol, :isengard ])
    warg_rider_shield       = _declare_warrior("Warg Rider with shield",                    "Warg Riders with shield",     [ :angmar, :barad_dur, :cirith_ungol, :isengard ])
    warg_rider_shield_spear = _declare_warrior("Warg Rider with shield and throwing spear", "Warg Riders with shield and throwing spear", [ :angmar, :barad_dur, :cirith_ungol, :isengard ])
    warg_rider_spear        = _declare_warrior("Warg Rider with spear",                     "Warg Riders with spear",      [ :angmar, :barad_dur, :cirith_ungol, :isengard ])

    mordor_troll = _declare_monster("Mordor Troll", "Mordor Trolls", [ :barad_dur, :black_gate, :cirith_ungol ])

    mordor_siege_bow     = _declare_siege("Mordor Siege Bow",          "Mordor Siege Bows",         [ :barad_dur, :cirith_ungol ])
    mordor_siege_bow_orc = _declare_siege("Mordor Siege Bow Orc crew", "Mordor Siege Bow Orc crew", [ :barad_dur, :cirith_ungol ])
    war_catapult         = _declare_siege("War Catapult",              "War Catapults",             [ :barad_dur, :black_gate, :cirith_ungol, :minas_morgul ])
    war_catapult_orc     = _declare_siege("War Catapult Orc crew",     "War Catapult Orc crew",     [ :barad_dur, :black_gate, :cirith_ungol, :minas_morgul ] )
    war_catapult_troll   = _declare_siege("War Catapult Troll",        "War Catapult Trolls",       [ :black_gate, :cirith_ungol ])

    #########################################################################
    # FIGURES: MORIA
    #########################################################################

    ashrak         = _declare_unique("Ashrâk",                  [ :moria ])
    druzhag        = _declare_unique("Drûzhag the Beastcaller", [ :moria ])
    durburz        = _declare_unique("Durbûrz",                 [ :moria ])
    golfimbul      = _declare_unique("Golfimbul")
    golfimbul_warg = _declare_unique("Golfimbul on warg")
    groblog        = _declare_unique("Grôblog",                 [ :moria ])

    gundabad_blackshield_captain = _declare_hero("Gundabad Blackshield Captain",  "Gundabad Blackshield Captains",  [ :moria ])
    gundabad_blackshield_shaman  = _declare_hero("Gundabad Blackshield Shaman",   "Gundabad Blackshield Shamans",   [ :moria ])
    moria_captain                = _declare_hero("Moria Goblin Captain",          "Moria Goblin Captains",          [ :moria ])
    moria_captain_bow            = _declare_hero("Moria Goblin Captain with bow", "Moria Goblin Captains with bow", [ :moria ])
    moria_shaman                 = _declare_hero("Moria Goblin Shaman",           "Moria Goblin Shamans",           [ :moria ])

    gundabad_blackshield = _declare_warrior("Gundabad Blackshield",                  "Gundabad Blackshields",              [ :moria ])
    moria_g_bow    = _declare_warrior("Moria Goblin with Orc bow",                   "Moria Goblins with Orc bow",         [ :moria ])
    moria_g_shield = _declare_warrior("Moria Goblin with shield",                    "Moria Goblins with shield",          [ :moria ])
    moria_g_spear  = _declare_warrior("Moria Goblin with spear",                     "Moria Goblins with spear",           [ :moria ])
    moria_p_bow    = _declare_warrior("Moria Goblin Prowler with Orc bow",           "Moria Goblin Prowlers with Orc bow", [ :moria ])
    moria_p_shield = _declare_warrior("Moria Goblin Prowler with shield",            "Moria Goblin Prowlers with shield",  [ :moria ])
    moria_p_2h     = _declare_warrior("Moria Goblin Prowler with two-handed weapon", "Moria Goblin Prowlers with two-handed weapon", [ :moria ])
    warg_marauder  = _declare_warrior("Warg Marauder",                               "Warg Marauders",  [ :moria ])

    cave_troll_chain = _declare_monster("Cave Troll with chain", "Cave Trolls with chain", [ :angmar, :moria ])
    cave_troll_spear = _declare_monster("Cave Troll with spear", "Cave Trolls with spear", [ :angmar, :moria ])

    gundabad_blackshield_drummer = _declare_warrior("Gundabad Blackshield Drummer", "Gundabad Blackshield Drummers", [ :moria ])
    moria_drum    = _declare_warrior("Moria Goblin drum",    "Moria Goblin drums",    [ :moria ])
    moria_drummer = _declare_warrior("Moria Goblin drummer", "Moria Goblin drummers", [ :moria ])

    balrog         = _declare_monster("Balrog",     "Balrogs",     [ :moria ])
    balrog_plastic = _declare_monster("Balrog (Plastic)", "Balrogs (Plastic)", [ :moria ])
    balrog_whip    = _declare_monster("Balrog with whip", "Balrogs with whip", [ :moria ])
    cave_drake = _declare_monster("Cave Drake", "Cave Drakes", [ :moria ])
    dragon     = _declare_monster("Dragon",     "Dragons",     [ :moria ])
    dweller    = _declare_monster("Dweller in the Dark", "Dwellers in the Dark", [ :moria ])
    tentacle   = _declare_monster("Tentacle",   "Tentacles")
    watcher    = _declare_unique_monster("The Watcher in the Water", [ :moria ])

    #########################################################################
    # FIGURES: NUMENOR
    #########################################################################

    elendil       = _declare_unique("Elendil",          [ :numenor ] )
    isildur       = _declare_unique("Isildur",          [ :numenor ])
    isildur_horse = _declare_unique("Isildur on horse", [ :numenor ])

    numenor_captain = _declare_hero("Captain of Numenor", "Captains of Numenor", [ :numenor ])

    numenor_w_banner       = _declare_warrior("Warrior of Numenor with banner",           "Warriors of Numenor with banner", [ :numenor ])
    numenor_w_bow          = _declare_warrior("Warrior of Numenor with bow",              "Warriors of Numenor with bow",    [ :numenor ])
    numenor_w_shield       = _declare_warrior("Warrior of Numenor with shield",           "Warriors of Numenor with shield", [ :numenor ])
    numenor_w_shield_spear = _declare_warrior("Warrior of Numenor with shield and spear", "Warriors of Numenor with shield and spear", [ :numenor ])

    #########################################################################
    # FIGURES: RIVENDELL
    #########################################################################

    arwen            = _declare_unique("Arwen (FotR)",                 [ :rivendell, :white_council ])
    arwen_horse      = _declare_unique("Arwen on Asfaloth",            [ :rivendell, :white_council ])
    arwen2           = _declare_unique("Arwen (LotR)",                 [ :rivendell, :white_council ])
    elladan          = _declare_unique("Elladan",                      [ :arnor, :rivendell ])
    elladan_armor    = _declare_unique("Elladan with heavy armour",    [ :arnor, :rivendell ])
    elrohir          = _declare_unique("Elrohir",                      [ :arnor, :rivendell ])
    elrohir_armor    = _declare_unique("Elrohir with heavy armour",    [ :arnor, :rivendell ])
    elrond           = _declare_unique("Elrond",                       [ :rivendell, :white_council, :elrond ])
    erestor          = _declare_unique("Erestor",                      [ :rivendell, :white_council ])
    gil_galad        = _declare_unique("Gil-galad",                    [ :rivendell ])
    gildor           = _declare_unique("Gildor",                       [ :rivendell ])
    glorfindel       = _declare_unique("Glorfindel",                   [ :rivendell, :white_council ])
    glorfindel_horse = _declare_unique("Glorfindel on horse",          [ :rivendell, :white_council ])
    glorfindel_lotw  = _declare_unique("Glorfindel, Lord of the West", [ :rivendell, :white_council ])
    lindir           = _declare_unique("Lindir",                       [ :elrond ])

    high_elf_captain         = _declare_hero("High Elf Captain",         "High Elf Captains",     [ :rivendell ])
    high_elf_stormcaller     = _declare_hero("High Elf Stormcaller",     "High Elf Stormcallers", [ :rivendell ])
    rivendell_knight_captain = _declare_hero("Rivendell Knight Captain", "Rivendell Knight Captains", [ :elrond ])

    high_elf_w_banner       = _declare_warrior("High Elf with banner",           "High Elves with banner",           [ :rivendell ])
    high_elf_w_blade        = _declare_warrior("High Elf with Elven blade",      "High Elves with Elven blade",      [ :rivendell ])
    high_elf_w_bow          = _declare_warrior("High Elf with bow",              "High Elves with bow",              [ :rivendell ])
    high_elf_w_spear_shield = _declare_warrior("High Elf with spear and shield", "High Elves with spear and shield", [ :rivendell ])
    rivendell_knight        = _declare_warrior("Rivendell Knight",               "Rivendell Knights",                [ :elrond ])

    #########################################################################
    # FIGURES: ROHAN
    #########################################################################

    eomer               = _declare_unique("Éomer",                                [ :rohan ])
    eomer_horse         = _declare_unique("Éomer on horse",                       [ :rohan ])
    eorl_horse          = _declare_unique("Eorl the Young on horse",              [ :rohan ])
    eowyn_armor         = _declare_unique("Éowyn with armour",                    [ :rohan ])
    eowyn_horse         = _declare_unique("Éowyn on horse",                       [ :rohan ])
    erkenbrand          = _declare_unique("Erkenbrand",                           [ :rohan ])
    erkenbrand_horse    = _declare_unique("Erkenbrand on horse",                  [ :rohan ])
    gamling             = _declare_unique("Gamling",                              [ :rohan ])
    gamling_horse       = _declare_unique("Gamling on horse with banner",         [ :rohan ])
    grimbold            = _declare_unique("Grimbold of Grimslade",                [ :rohan ])
    hama                = _declare_unique("Hama",                                 [ :rohan ])
    merry_rohan         = _declare_unique("Meriadoc, Knight of the Mark",         [ :rohan ])
    theoden             = _declare_unique("Théoden",                              [ :rohan ])
    theoden_horse       = _declare_unique("Théoden on horse",                     [ :rohan ])
    theoden_armor_horse = _declare_unique("Théoden with armour on armored horse", [ :rohan ])
    theodred_horse      = _declare_unique("Théodred on horse",                    [ :rohan ])

    kings_huntsman      = _declare_hero("King's Huntsman",           "King's Huntsmen",            [ :rohan ])
    rohan_captain       = _declare_hero("Captain of Rohan",          "Captains of Rohan",          [ :rohan ])
    rohan_captain_horse = _declare_hero("Captain of Rohan on horse", "Captains of Rohan on horse", [ :rohan ])

    rohan_gd              = _declare_warrior("Rohan Royal Guard",                               "Rohan Royal Guards",                              [ :rohan ])
    rohan_gd_spear        = _declare_warrior("Rohan Royal Guard with throwing spear",           "Rohan Royal Guards with throwing spear",          [ :rohan ])
    rohan_gd_horse_spear  = _declare_warrior("Rohan Royal Guard with throwing spear on horse",  "Rohan Royal Guards with throwing spear on horse", [ :rohan ])
    rohan_gd_horse_banner = _declare_warrior("Rohan Royal Guard with banner",                   "Rohan Royal Guards with banner",                  [ :rohan ])
    rohan_outrider        = _declare_warrior("Rohan Outrider",                                  "Rohan Outriders",                     [ :rohan ])
    rohan_rider           = _declare_warrior("Rider of Rohan",                                  "Riders of Rohan",                     [ :rohan ])
    rohan_rider_banner    = _declare_warrior("Rider of Rohan with banner",                      "Riders of Rohan with banner",         [ :rohan ])
    rohan_rider_spear     = _declare_warrior("Rider of Rohan with throwing spear",              "Riders of Rohan with throwing spear", [ :rohan ])
    rohan_w_banner        = _declare_warrior("Warrior of Rohan with banner",                    "Warriors of Rohan with banner",                    [ :rohan ])
    rohan_w_bow           = _declare_warrior("Warrior of Rohan with bow",                       "Warriors of Rohan with bow",                       [ :rohan ])
    rohan_w_shield        = _declare_warrior("Warrior of Rohan with shield",                    "Warriors of Rohan with shield",                    [ :rohan ])
    rohan_w_spear_shield  = _declare_warrior("Warrior of Rohan with throwing spear and shield", "Warriors of Rohan with throwing spear and shield", [ :rohan ])
    son_eorl              = _declare_warrior("Son of Eorl", "Sons of Eorl", [ :rohan ])

    #########################################################################
    # FIGURES: SHIRE
    #########################################################################

    bandobras      = _declare_unique("Bandobras Took",         [ :wanderers ])
    bandobras_pony = _declare_unique("Bandobras Took on pony", [ :wanderers ])
    bilbo          = _declare_unique("Bilbo Baggins",          [ :wanderers ])
    fang           = _declare_unique("Fang",                      [ :shire ])
    fatty          = _declare_unique("Fredegar Bolger",           [ :shire ])
    grip           = _declare_unique("Grip",                      [ :shire ])
    lobelia        = _declare_unique("Lobelia Sackville-Baggins", [ :shire ])
    maggot         = _declare_unique("Farmer Maggot",             [ :shire ])
    paladin        = _declare_unique("Paladin Took",              [ :shire ])
    wolf           = _declare_unique("Wolf",                      [ :shire ])

    hobbit_archer      = _declare_warrior("Hobbit Archer",                  "Hobbit Archers", [ :shire ])
    hobbit_archer_horn = _declare_warrior("Hobbit Archer with signal horn", "Hobbit Archers with signal horn", [ :shire ])
    hobbit_militia     = _declare_warrior("Hobbit Militia",                 "Hobbit Militia", [ :shire ])
    hobbit_shirriff    = _declare_warrior("Hobbit Shirriff",                "Hobbit Shirriffs", [ :shire ])

    #########################################################################
    # FIGURES: THORIN'S COMPANY
    #########################################################################

    balin              = _declare_unique("Balin",                                       [ :thorins_co ])
    balin_barrel       = _declare_unique("Balin in barrel")
    balin_erebor       = _declare_unique("Balin, Champion of Erebor",                   [ :erebor ])
    balin_young        = _declare_unique("Young Balin",                                 [ :army_thror ])
    bifur              = _declare_unique("Bifur",                                       [ :thorins_co ])
    bifur_barrel       = _declare_unique("Bifur in barrel")
    bifur_erebor       = _declare_unique("Bifur, Champion of Erebor",                   [ :erebor ])
    young_bilbo        = _declare_unique("Bilbo Baggins",                               [ :survivors, :thorins_co ])
    young_bilbo_barrel = _declare_unique("Bilbo Baggins on barrel")
    bofur              = _declare_unique("Bofur",                                       [ :thorins_co ])
    bofur_barrel       = _declare_unique("Bofur in barrel")
    bofur_erebor       = _declare_unique("Bofur, Champion of Erebor",                   [ :erebor ])
    bombur             = _declare_unique("Bombur",                                      [ :thorins_co ])
    bombur_barrel      = _declare_unique("Bombur in barrel")
    bombur_erebor      = _declare_unique("Bombur, Champion of Erebor",                  [ :erebor ])
    dori               = _declare_unique("Dori",                                        [ :thorins_co ])
    dori_barrel        = _declare_unique("Dori in barrel")
    dori_erebor        = _declare_unique("Dori, Champion of Erebor",                    [ :erebor ])
    dwalin             = _declare_unique("Dwalin",                                      [ :thorins_co ])
    dwalin_barrel      = _declare_unique("Dwalin in barrel")
    dwalin_erebor      = _declare_unique("Dwalin, Champion of Erebor",                  [ :erebor ])
    dwalin_goat        = _declare_unique("Dwalin on goat")
    dwalin_young       = _declare_unique("Young Dwalin",                                [ :army_thror ])
    fili               = _declare_unique("Fili",                                        [ :thorins_co ])
    fili_barrel        = _declare_unique("Fili in barrel")
    fili_erebor        = _declare_unique("Fili, Champion of Erebor",                    [ :erebor ])
    fili_goat          = _declare_unique("Fili on goat")
    gloin              = _declare_unique("Gloin",                                       [ :thorins_co ])
    gloin_barrel       = _declare_unique("Gloin in barrel")
    gloin_erebor       = _declare_unique("Gloin, Champion of Erebor",                   [ :erebor ])
    kili               = _declare_unique("Kili",                                        [ :thorins_co ])
    kili_barrel        = _declare_unique("Kili in barrel")
    kili_erebor        = _declare_unique("Kili, Champion of Erebor",                    [ :erebor ])
    kili_goat          = _declare_unique("Kili on goat")
    nori               = _declare_unique("Nori",                                        [ :thorins_co ])
    nori_barrel        = _declare_unique("Nori in barrel")
    nori_erebor        = _declare_unique("Nori, Champion of Erebor",                    [ :erebor ])
    oin                = _declare_unique("Oin",                                         [ :thorins_co ])
    oin_barrel         = _declare_unique("Oin in barrel")
    oin_erebor         = _declare_unique("Oin, Champion of Erebor",                     [ :erebor ])
    ori                = _declare_unique("Ori",                                         [ :thorins_co ])
    ori_barrel         = _declare_unique("Ori in barrel")
    ori_erebor         = _declare_unique("Ori, Champion of Erebor",                     [ :erebor ])
    thorin             = _declare_unique("Thorin Oakenshield",                          [ :thorins_co ])
    thorin_barrel      = _declare_unique("Thorin Oakenshield in barrel")
    thorin_erebor      = _declare_unique("Thorin Oakenshield, King Under the Mountain", [ :erebor ])
    thorin_goat        = _declare_unique("Thorin Oakenshield on goat")
    thorin_young       = _declare_unique("Young Thorin Oakenshield",                    [ :army_thror ])

    #########################################################################
    # THE TROLLS
    #########################################################################

    bert    = _declare_unique_monster("Bert",    [ :trolls ])
    tom     = _declare_unique_monster("Tom",     [ :trolls ])
    william = _declare_unique_monster("William", [ :trolls ])

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
    # THE BATTLE OF THE FIVE ARMIES
    #########################################################################

    #========================================================================
    bo5a_s1 = Repo.insert! %Scenario{
      name: "Fire and Water",
      blurb: "Bard attempts to take down Smaug as the dragon attacks Lake-town.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 34,
      map_width: 48, map_height: 48, location: :laketown
    }

    Repo.insert! %ScenarioResource{scenario_id: bo5a_s1.id, resource_type: :source, book: :bot5a, title: "Battle of the Five Armies", sort_order: 1, page: 6}
    _declare_video_replay(bo5a_s1.id, "https://www.youtube.com/watch?v=e_CKPe8raRk&list=PLeIywh8H3Kc7ylraUCzZyMf2Jo_eXEt4a&index=4", "DCHL", 1)

    bo5a_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: bo5a_s1.id, faction: :laketown, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(bo5a_s1f1,  1,  1, [ bard_windlance ])
    _declare_role_figure(bo5a_s1f1,  1,  2, [ fili ])
    _declare_role_figure(bo5a_s1f1,  1,  3, [ kili ])
    _declare_role_figure(bo5a_s1f1,  1,  4, [ bofur ])
    _declare_role_figure(bo5a_s1f1,  1,  5, [ oin ])
    _declare_role_figure(bo5a_s1f1,  1,  6, [ tauriel ])
    _declare_role_figure(bo5a_s1f1,  1,  7, [ master_laketown ])
    _declare_role_figure(bo5a_s1f1,  1,  8, [ alfrid ])
    _declare_role_figure(bo5a_s1f1,  1,  9, [ laketown_gd_captain ])
    _declare_role_figure(bo5a_s1f1, 12, 10, [ laketown_gd_w_spear ])
    _declare_role_figure(bo5a_s1f1, 12, 11, [ laketown_gd_w_bow ])

    bo5a_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: bo5a_s1.id, faction: :desolator_north, suggested_points: 700, actual_points: 700, sort_order: 2}
    _declare_role_figure(bo5a_s1f2,  1, 1, [ smaug ])

    #========================================================================
    bo5a_s2 = Repo.insert! %Scenario{
      name: "Assault on Ravenhill",
      blurb: "Thorin's Company gets help to decapitate the Evil army assaulting the Good forces at Erebor.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 53,
      map_width: 48, map_height: 48, location: :erebor
    }

    Repo.insert! %ScenarioResource{scenario_id: bo5a_s2.id, resource_type: :source, book: :bot5a, title: "Battle of the Five Armies", sort_order: 2, page: 8}
    _declare_podcast(bo5a_s2.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-7-assaul", "The Green Dragon", 1)

    bo5a_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: bo5a_s2.id, faction: :laketown, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(bo5a_s2f1,  1,  1, [ thorin ])
    _declare_role_figure(bo5a_s2f1,  1,  2, [ fili ])
    _declare_role_figure(bo5a_s2f1,  1,  3, [ kili ])
    _declare_role_figure(bo5a_s2f1,  1,  4, [ dwalin ])
    _declare_role_figure(bo5a_s2f1,  1,  5, [ young_bilbo ])
    _declare_role_figure(bo5a_s2f1,  1,  6, [ radagast_eagle ])
    _declare_role_figure(bo5a_s2f1,  1,  7, [ tauriel ])
    _declare_role_figure(bo5a_s2f1,  1,  8, [ legolas ])
    _declare_role_figure(bo5a_s2f1,  1,  9, [ beorn ])
    _declare_role_figure(bo5a_s2f1,  1, 10, [ gwaihir ])
    _declare_role_figure(bo5a_s2f1,  2, 11, [ eagle ])

    bo5a_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: bo5a_s2.id, faction: :azogs_hunters, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(bo5a_s2f2,  1, 1, [ azog ])
    _declare_role_figure(bo5a_s2f2,  1, 2, [ bolg ])
    _declare_role_figure(bo5a_s2f2,  3, 3, [ gundabad_orc_captain ])
    _declare_role_figure(bo5a_s2f2, 36, 4, "Gundabad Orcs", [ gundabad_orc_shield, gundabad_orc_spear ])

    #########################################################################
    # THE BATTLE OF THE PELENNOR FIELDS
    #########################################################################

    #========================================================================
    bpf_s1 = Repo.insert! %Scenario{
      name: "The Banks of the Harnen",
      blurb: "The Haradrim attempt to cross the Harnen river to enter Gondorian lands.",
      date_age: 3, date_year: 3019, date_month: 1, date_day: 15, size: 50,
      map_width: 48, map_height: 48, location: :harondor
    }

    Repo.insert! %ScenarioResource{scenario_id: bpf_s1.id, resource_type: :source, book: :bpf, title: "Battle of the Pelennor Fields", sort_order: 1, page: 14}
    _declare_web_replay(bpf_s1.id, "http://davetownsend.org/Battles/LotR-20090208/", "DaveT", 1)

    bpf_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s1.id, faction: :minas_tirith, suggested_points: 280, actual_points: 280, sort_order: 1}
    _declare_role_figure(bpf_s1f1, 1, 1, [ gondor_captain_mt ])
    _declare_role_figure(bpf_s1f1, 8, 2, [ gondor_womt_spear_shield ])
    _declare_role_figure(bpf_s1f1, 7, 3, [ gondor_womt_shield ])
    _declare_role_figure(bpf_s1f1, 8, 4, [ gondor_womt_bow ])
    _declare_role_figure(bpf_s1f1, 1, 5, [ gondor_womt_banner ])

    bpf_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s1.id, faction: :harad, suggested_points: 280, actual_points: 244, sort_order: 2}
    _declare_role_figure(bpf_s1f2,  1, 1, [ harad_chieftain ])
    _declare_role_figure(bpf_s1f2, 12, 2, [ harad_w_spear ])
    _declare_role_figure(bpf_s1f2, 12, 3, [ harad_w_bow ])
    _declare_role_figure(bpf_s1f2,  1, 4, [ harad_w_banner ])

    #========================================================================
    bpf_s2 = Repo.insert! %Scenario{
      name: "A Blade in the Night",
      blurb: "A lone Hâsharin tries to assassinate Prince Imrahil.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 1, size: 26,
      map_width: 48, map_height: 48, location: :harondor
    }

    Repo.insert! %ScenarioResource{scenario_id: bpf_s2.id, resource_type: :source, book: :bpf, title: "Battle of the Pelennor Fields", sort_order: 2, page: 20}

    bpf_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s2.id, faction: :minas_tirith, suggested_points: 300, actual_points: 331, sort_order: 1}
    _declare_role_figure(bpf_s2f1,  1, 1, [ imrahil ])
    _declare_role_figure(bpf_s2f1, 12, 2, [ gondor_womt_shield ])
    _declare_role_figure(bpf_s2f1,  4, 3, [ gondor_womt_spear_shield ])
    _declare_role_figure(bpf_s2f1,  4, 4, [ gondor_knight_da_horse ])
    _declare_role_figure(bpf_s2f1,  4, 5, [ gondor_womt_bow ])

    bpf_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s2.id, faction: :harad, suggested_points: 100, actual_points: 90, sort_order: 2}
    _declare_role_figure(bpf_s2f2,  1, 1, [ hasharin ])

    #========================================================================
    bpf_s3 = Repo.insert! %Scenario{
      name: "The Harad Road",
      blurb: "A separated force of Gondor infantry and cavalry are surrounded by Haradrim.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 5, size: 102,
      map_width: 48, map_height: 48, location: :harondor
    }

    Repo.insert! %ScenarioResource{scenario_id: bpf_s3.id, resource_type: :source, book: :bpf, title: "Battle of the Pelennor Fields", sort_order: 3, page: 26}

    bpf_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s3.id, faction: :minas_tirith, suggested_points: 500, actual_points: 688, sort_order: 1}
    _declare_role_figure(bpf_s3f1,  1, 1, [ gondor_captain_mt ])
    _declare_role_figure(bpf_s3f1,  1, 2, [ gondor_captain_mt_horse ])
    _declare_role_figure(bpf_s3f1,  6, 3, [ gondor_womt_shield ])
    _declare_role_figure(bpf_s3f1,  2, 4, [ gondor_womt_banner ])
    _declare_role_figure(bpf_s3f1,  8, 5, [ gondor_womt_spear_shield ])
    _declare_role_figure(bpf_s3f1,  8, 6, [ gondor_womt_bow ])
    _declare_role_figure(bpf_s3f1,  4, 7, [ gondor_knight_da_foot ])
    _declare_role_figure(bpf_s3f1, 12, 8, [ gondor_knight ])
    _declare_role_figure(bpf_s3f1,  6, 9, [ gondor_knight_da_horse ])

    bpf_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s3.id, faction: :harad, suggested_points: 500, actual_points: 611, sort_order: 2}
    _declare_role_figure(bpf_s3f2,  1, 1, [ harad_chieftain ])
    _declare_role_figure(bpf_s3f2,  1, 2, [ harad_chieftain_horse ])
    _declare_role_figure(bpf_s3f2, 16, 3, [ harad_w_spear ])
    _declare_role_figure(bpf_s3f2, 18, 4, [ harad_w_bow ])
    _declare_role_figure(bpf_s3f2,  2, 5, [ harad_w_banner ])
    _declare_role_figure(bpf_s3f2,  8, 6, [ harad_raider ])
    _declare_role_figure(bpf_s3f2,  8, 7, [ harad_raider_lance ])

    #========================================================================
    bpf_s4 = Repo.insert! %Scenario{
      name: "The Fall of Harmindon",
      blurb: "Imrahil, aided by a rogue Hâsharin defends the town of Harmindon from Suladan's assault.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 15, size: 67,
      map_width: 72, map_height: 48, location: :harondor
    }

    Repo.insert! %ScenarioResource{scenario_id: bpf_s4.id, resource_type: :source, book: :bpf, title: "Battle of the Pelennor Fields", sort_order: 4, page: 28}

    bpf_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s4.id, faction: :minas_tirith, suggested_points: 500, actual_points: 0, sort_order: 1}
    _declare_role_figure(bpf_s4f1,  1, 1, [ imrahil ])
    _declare_role_figure(bpf_s4f1,  1, 2, [ gondor_captain_mt_horse ])
    _declare_role_figure(bpf_s4f1,  1, 3, [ hasharin ])
    _declare_role_figure(bpf_s4f1,  4, 4, [ gondor_womt_shield ])
    _declare_role_figure(bpf_s4f1,  2, 5, [ gondor_womt_banner ])
    _declare_role_figure(bpf_s4f1,  6, 6, [ gondor_womt_spear_shield ])
    _declare_role_figure(bpf_s4f1,  6, 7, [ gondor_womt_bow ])
    _declare_role_figure(bpf_s4f1,  6, 8, [ gondor_knight_da_foot ])
    _declare_role_figure(bpf_s4f1,  6, 9, [ gondor_knight_da_horse ])

    bpf_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s4.id, faction: :harad, suggested_points: 500, actual_points: 0, sort_order: 2}
    _declare_role_figure(bpf_s4f2,  1, 1, [ suladan ])
    _declare_role_figure(bpf_s4f2,  1, 2, [ harad_chieftain_horse ])
    _declare_role_figure(bpf_s4f2,  8, 3, [ harad_raider_lance ])
    _declare_role_figure(bpf_s4f2,  8, 4, [ harad_raider ])
    _declare_role_figure(bpf_s4f2,  8, 5, [ harad_w_bow ])
    _declare_role_figure(bpf_s4f2,  6, 6, [ harad_w_spear ])
    _declare_role_figure(bpf_s4f2,  2, 7, [ harad_w_banner ])

    #========================================================================
    bpf_s5 = Repo.insert! %Scenario{
      name: "Hunt the Mumak",
      blurb: "Prince Imrahil's force tries to take down a Mumak in the middle of a sand storm.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 20, size: 39,
      map_width: 48, map_height: 48, location: :harondor
    }

    Repo.insert! %ScenarioResource{scenario_id: bpf_s5.id, resource_type: :source, book: :bpf, title: "Battle of the Pelennor Fields", sort_order: 5, page: 34}

    bpf_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s5.id, faction: :minas_tirith, suggested_points: 400, actual_points: 0, sort_order: 1}
    _declare_role_figure(bpf_s5f1,  1, 1, [ imrahil ])
    _declare_role_figure(bpf_s5f1,  1, 2, [ gondor_captain_mt ])
    _declare_role_figure(bpf_s5f1,  8, 3, [ gondor_knight_da_horse ])
    _declare_role_figure(bpf_s5f1,  7, 4, [ gondor_womt_bow ])
    _declare_role_figure(bpf_s5f1,  1, 5, [ gondor_womt_banner ])

    bpf_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s5.id, faction: :harad, suggested_points: 400, actual_points: 0, sort_order: 2}
    _declare_role_figure(bpf_s5f2,  1, 1, [ mumak ])
    _declare_role_figure(bpf_s5f2, 12, 2, [ harad_w_bow ])
    _declare_role_figure(bpf_s5f2,  8, 3, [ harad_w_spear ])

    #========================================================================
    bpf_s6 = Repo.insert! %Scenario{
      name: "Rebellion",
      blurb: "Two Hâsharin lead a revolt against Suladân in his own camp.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 27, size: 64,
      map_width: 48, map_height: 48, location: :harondor
    }

    Repo.insert! %ScenarioResource{scenario_id: bpf_s6.id, resource_type: :source, book: :bpf, title: "Battle of the Pelennor Fields", sort_order: 6, page: 40}

    bpf_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s6.id, faction: :harad, suggested_points: 1200, actual_points: 0, sort_order: 1}
    _declare_role_figure(bpf_s6f1,  1, 1, [ suladan ])
    _declare_role_figure(bpf_s6f1,  2, 2, [ harad_chieftain_horse ])
    _declare_role_figure(bpf_s6f1,  2, 3, [ harad_chieftain ])
    _declare_role_figure(bpf_s6f1, 24, 4, [ harad_w_spear ])
    _declare_role_figure(bpf_s6f1, 24, 5, [ harad_w_bow ])
    _declare_role_figure(bpf_s6f1,  4, 6, [ harad_raider ])
    _declare_role_figure(bpf_s6f1,  4, 7, [ harad_raider_lance ])
    _declare_role_figure(bpf_s6f1,  1, 8, [ mumak ])

    bpf_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s6.id, faction: :harad, suggested_points: 200, actual_points: 0, sort_order: 2}
    _declare_role_figure(bpf_s6f2,  2, 1, [ hasharin ])

    #========================================================================
    bpf_s7 = Repo.insert! %Scenario{
      name: "Assault on Glamorgath",
      blurb: "Prince Imrahil conducts a fighting withdrawal against Suladân's assault on the ruins of Glamorgath.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 1, size: 110,
      map_width: 48, map_height: 48, location: :harondor
    }

    Repo.insert! %ScenarioResource{scenario_id: bpf_s7.id, resource_type: :source, book: :bpf, title: "Battle of the Pelennor Fields", sort_order: 7, page: 44}

    bpf_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s7.id, faction: :minas_tirith, suggested_points: 750, actual_points: 0, sort_order: 1}
    _declare_role_figure(bpf_s7f1,  1, 1, [ imrahil ])
    _declare_role_figure(bpf_s7f1,  1, 2, [ gondor_captain_mt ])
    _declare_role_figure(bpf_s7f1, 10, 3, [ gondor_knight_da_foot ])
    _declare_role_figure(bpf_s7f1, 11, 4, [ gondor_womt_shield ])
    _declare_role_figure(bpf_s7f1, 12, 5, [ gondor_womt_spear_shield ])
    _declare_role_figure(bpf_s7f1, 12, 6, [ gondor_womt_bow ])
    _declare_role_figure(bpf_s7f1,  1, 7, [ gondor_womt_banner ])

    bpf_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s7.id, faction: :harad, suggested_points: 1500, actual_points: 0, sort_order: 2}
    _declare_role_figure(bpf_s7f2,  1, 1, [ suladan ])
    _declare_role_figure(bpf_s7f2,  1, 2, [ mumak ])
    _declare_role_figure(bpf_s7f2,  1, 3, [ harad_chieftain ])
    _declare_role_figure(bpf_s7f2,  1, 4, [ harad_chieftain_horse ])
    _declare_role_figure(bpf_s7f2, 22, 5, [ harad_w_spear ])
    _declare_role_figure(bpf_s7f2, 24, 6, [ harad_w_bow ])
    _declare_role_figure(bpf_s7f2,  2, 7, [ harad_w_banner ])
    _declare_role_figure(bpf_s7f2,  5, 8, [ harad_raider_lance ])
    _declare_role_figure(bpf_s7f2,  5, 9, [ harad_raider ])

    #========================================================================
    bpf_s8 = Repo.insert! %Scenario{
      name: "Ambush in Ithilien",
      blurb: "Faramir's Rangers ambush a large Southron force, complete with Mûmak.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 7, size: 74,
      map_width: 48, map_height: 48, location: :ithilien
    }

    Repo.insert! %ScenarioResource{scenario_id: bpf_s8.id, resource_type: :source, book: :bpf, title: "Battle of the Pelennor Fields", sort_order: 8, page: 48}

    bpf_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s8.id, faction: :minas_tirith, suggested_points: 400, actual_points: 0, sort_order: 1}
    _declare_role_figure(bpf_s8f1,  1, 1, [ faramir ])
    _declare_role_figure(bpf_s8f1,  1, 2, [ madril ])
    _declare_role_figure(bpf_s8f1,  1, 3, [ damrod ])
    _declare_role_figure(bpf_s8f1,  1, 4, [ frodo ])
    _declare_role_figure(bpf_s8f1,  1, 5, [ sam ])
    _declare_role_figure(bpf_s8f1, 20, 6, [ gondor_rog ])

    bpf_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s8.id, faction: :harad, suggested_points: 800, actual_points: 0, sort_order: 2}
    _declare_role_figure(bpf_s8f2,  1, 1, [ harad_chieftain ])
    _declare_role_figure(bpf_s8f2,  1, 2, [ harad_chieftain_horse ])
    _declare_role_figure(bpf_s8f2, 11, 3, [ harad_w_spear ])
    _declare_role_figure(bpf_s8f2, 24, 4, [ harad_w_bow ])
    _declare_role_figure(bpf_s8f2,  1, 5, [ harad_w_banner ])
    _declare_role_figure(bpf_s8f2,  5, 6, [ harad_raider ])
    _declare_role_figure(bpf_s8f2,  5, 7, [ harad_raider_lance ])
    _declare_role_figure(bpf_s8f2,  1, 8, [ mumak ])

    #========================================================================
    bpf_s9 = Repo.insert! %Scenario{
      name: "The Glory of Dol Amroth",
      blurb: "Gandalf and Prince Imrahil ride out from Gondor to save Faramir from the forces of Mordor.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 13, size: 93,
      map_width: 48, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: bpf_s9.id, resource_type: :source, book: :bpf, title: "Battle of the Pelennor Fields", sort_order: 9, page: 52}

    bpf_s9f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s9.id, faction: :minas_tirith, suggested_points: 1250, actual_points: 0, sort_order: 1}
    _declare_role_figure(bpf_s9f1,  1,  1, [ faramir_armor_horse ])
    _declare_role_figure(bpf_s9f1,  1,  2, "Gandalf the White on Shadowfax", [ gandalf_white_horse, gandalf_white_horse_mt ])
    _declare_role_figure(bpf_s9f1,  1,  3, [ imrahil_horse ])
    _declare_role_figure(bpf_s9f1,  2,  4, [ gondor_captain_mt_horse ])
    _declare_role_figure(bpf_s9f1,  5,  5, [ gondor_womt_spear_shield ])
    _declare_role_figure(bpf_s9f1,  4,  6, [ gondor_womt_bow ])
    _declare_role_figure(bpf_s9f1,  1,  7, [ gondor_womt_banner ])
    _declare_role_figure(bpf_s9f1, 10,  8, [ gondor_rog ])
    _declare_role_figure(bpf_s9f1, 10,  9, [ gondor_knight ])
    _declare_role_figure(bpf_s9f1,  8, 10, [ gondor_knight_da_horse ])

    bpf_s9f2 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s9.id, faction: :barad_dur, suggested_points: 1000, actual_points: 0, sort_order: 2}
    _declare_role_figure(bpf_s9f2,  2,  1, [ ringwraith_fellbeast ])
    _declare_role_figure(bpf_s9f2,  2,  2, [ harad_chieftain_horse ])
    _declare_role_figure(bpf_s9f2,  1,  3, [ orc_captain ])
    _declare_role_figure(bpf_s9f2,  1,  4, [ orc_captain_warg ])
    _declare_role_figure(bpf_s9f2,  6,  5, [ orc_w_shield ])
    _declare_role_figure(bpf_s9f2,  2,  6, [ orc_w_banner ])
    _declare_role_figure(bpf_s9f2,  8,  7, [ orc_w_spear ])
    _declare_role_figure(bpf_s9f2,  4,  8, [ orc_w_bow ])
    _declare_role_figure(bpf_s9f2,  4,  9, [ orc_w_2h ])
    _declare_role_figure(bpf_s9f2,  6, 10, [ harad_raider ])
    _declare_role_figure(bpf_s9f2,  6, 11, [ harad_raider_lance ])
    _declare_role_figure(bpf_s9f2,  4, 12, [ warg_rider_spear ])
    _declare_role_figure(bpf_s9f2,  4, 13, [ warg_rider_bow ])

    #========================================================================
    bpf_s10 = Repo.insert! %Scenario{
      name: "The Horse and the Serpent",
      blurb: "Théoden and Suladân face off in the Pelennor Fields.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 47,
      map_width: 48, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: bpf_s10.id, resource_type: :source, book: :bpf, title: "Battle of the Pelennor Fields", sort_order: 9, page: 56}

    bpf_s10f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s10.id, faction: :rohan, suggested_points: 800, actual_points: 0, sort_order: 1}
    _declare_role_figure(bpf_s10f1,  1,  1, [ theoden_armor_horse ])
    _declare_role_figure(bpf_s10f1,  1,  2, [ gamling_horse ])
    _declare_role_figure(bpf_s10f1,  1,  3, [ eowyn_horse ])
    _declare_role_figure(bpf_s10f1,  1,  4, [ merry_rohan ])
    _declare_role_figure(bpf_s10f1,  1,  5, [ rohan_captain_horse ])
    _declare_role_figure(bpf_s10f1,  6,  6, [ rohan_gd_horse_spear ])
    _declare_role_figure(bpf_s10f1, 12,  7, [ rohan_rider ])
    _declare_role_figure(bpf_s10f1,  6,  8, [ rohan_rider_spear ])

    bpf_s10f2 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s10.id, faction: :harad, suggested_points: 800, actual_points: 0, sort_order: 2}
    _declare_role_figure(bpf_s10f2,  1,  1, [ suladan ])
    _declare_role_figure(bpf_s10f2,  1,  2, [ witch_king_fellbeast ])
    _declare_role_figure(bpf_s10f2,  2,  3, [ harad_chieftain_horse ])
    _declare_role_figure(bpf_s10f2,  8,  4, [ harad_raider ])
    _declare_role_figure(bpf_s10f2,  8,  6, [ harad_raider_lance ])
    _declare_role_figure(bpf_s10f2,  4,  7, [ warg_rider_spear ])
    _declare_role_figure(bpf_s10f2,  4,  8, [ warg_rider_bow ])

    #========================================================================
    bpf_s11 = Repo.insert! %Scenario{
      name: "Éomer's Rage",
      blurb: "Aragorn and Imrahil rush to save Éomer as he is surrounded by forces of Mordor and Harad.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 136,
      map_width: 48, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: bpf_s11.id, resource_type: :source, book: :bpf, title: "Battle of the Pelennor Fields", sort_order: 9, page: 60}

    bpf_s11f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s11.id, faction: :rohan, suggested_points: 1000, actual_points: 0, sort_order: 1}
    _declare_role_figure(bpf_s11f1,  1,  1, [ imrahil_horse ])
    _declare_role_figure(bpf_s11f1,  1,  2, "Aragorn with Elven cloak and Andúril", [ aragorn ])
    _declare_role_figure(bpf_s11f1,  1,  3, [ legolas ])
    _declare_role_figure(bpf_s11f1,  1,  4, "Gimli", gimli_all_foot)
    _declare_role_figure(bpf_s11f1,  1,  5, [ halbarad ])
    _declare_role_figure(bpf_s11f1,  1,  6, [ elladan ])
    _declare_role_figure(bpf_s11f1,  1,  7, [ elrohir ])
    _declare_role_figure(bpf_s11f1,  9,  8, [ ranger_north ])
    _declare_role_figure(bpf_s11f1,  1,  9, [ eomer ])
    _declare_role_figure(bpf_s11f1,  2, 10, [ rohan_captain ])
    _declare_role_figure(bpf_s11f1,  8, 11, [ gondor_knight_da_horse ])
    _declare_role_figure(bpf_s11f1,  8, 12, [ gondor_knight ])
    _declare_role_figure(bpf_s11f1,  4, 13, [ rohan_gd_spear ])
    _declare_role_figure(bpf_s11f1,  6, 14, [ rohan_w_bow ])
    _declare_role_figure(bpf_s11f1,  6, 15, [ rohan_w_spear_shield ])
    _declare_role_figure(bpf_s11f1,  5, 16, [ rohan_w_shield ])
    _declare_role_figure(bpf_s11f1,  1, 17, [ rohan_w_banner ])

    bpf_s11f2 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s11.id, faction: :minas_morgul, suggested_points: 1000, actual_points: 0, sort_order: 2}
    _declare_role_figure(bpf_s11f2,  1,  1, "Gothmog, Lieutenant of Morgul", [ gothmog ])
    _declare_role_figure(bpf_s11f2,  1,  2, [ orc_shaman ])
    _declare_role_figure(bpf_s11f2,  1,  3, [ easterling_captain ])
    _declare_role_figure(bpf_s11f2,  1,  4, [ mordor_uruk_captain ])
    _declare_role_figure(bpf_s11f2,  1,  5, [ troll_chieftain ])
    _declare_role_figure(bpf_s11f2,  1,  6, [ harad_chieftain ])
    _declare_role_figure(bpf_s11f2,  6,  7, [ orc_w_shield ])
    _declare_role_figure(bpf_s11f2,  2,  8, [ orc_w_banner ])
    _declare_role_figure(bpf_s11f2,  8,  9, [ orc_w_spear ])
    _declare_role_figure(bpf_s11f2,  4, 10, [ orc_w_2h ])
    _declare_role_figure(bpf_s11f2,  4, 11, [ orc_w_bow ])
    _declare_role_figure(bpf_s11f2,  6, 12, [ easterling_w_shield_spear ])
    _declare_role_figure(bpf_s11f2,  6, 13, [ easterling_w_shield ])
    _declare_role_figure(bpf_s11f2, 18, 14, [ harad_w_bow ])
    _declare_role_figure(bpf_s11f2,  6, 15, [ harad_w_spear ])
    _declare_role_figure(bpf_s11f2,  4, 16, [ m_uruk_hai_shield ])
    _declare_role_figure(bpf_s11f2,  4, 17, [ m_uruk_hai_2h ])
    _declare_role_figure(bpf_s11f2,  2, 18, [ mordor_troll ])
    _declare_role_figure(bpf_s11f2,  1, 19, [ mumak ])
    _declare_role_figure(bpf_s11f2,  1, 20, [ mahud_beastmaster])

    #########################################################################
    # THE DESOLATION OF SMAUG
    #########################################################################

    #========================================================================
    dos_s1 = Repo.insert! %Scenario{
      name: "Alone in the Woods",
      blurb: "Beorn is cornered by Azog's Hunters.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 21,
      map_width: 48, map_height: 48, location: :mirkwood
    }

    Repo.insert! %ScenarioResource{scenario_id: dos_s1.id, resource_type: :source, book: :dos, title: "The Desolation of Smaug", sort_order: 1, page: 6}

    dos_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: dos_s1.id, faction: :wanderers, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(dos_s1f1, 1, 1, [ beorn ])

    dos_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: dos_s1.id, faction: :azogs_hunters, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(dos_s1f2,  1, 1, [ azog ])
    _declare_role_figure(dos_s1f2,  1, 2, [ narzug ])
    _declare_role_figure(dos_s1f2,  6, 3, [ hunter_orc_warg ])
    _declare_role_figure(dos_s1f2, 12, 4, [ hunter_orc ])

    #========================================================================
    dos_s2 = Repo.insert! %Scenario{
      name: "Flies and Spiders, Part I",
      blurb: "Bilbo attempts to rescue the dwarves from the clutches of the spiders.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 7,
      map_width: 48, map_height: 48, location: :mirkwood
    }

    Repo.insert! %ScenarioResource{scenario_id: dos_s2.id, resource_type: :source, book: :dos, title: "The Desolation of Smaug", sort_order: 2, page: 8}
    _declare_podcast(dos_s2.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-11-flies-and-spiders", "The Green Dragon", 1)

    dos_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: dos_s2.id, faction: :wanderers, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(dos_s2f1, 1, 1, [ young_bilbo ])

    dos_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: dos_s2.id, faction: :dol_guldur, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(dos_s2f2,  6, 1, [ mirkwood_spider ])

    #========================================================================
    dos_s3 = Repo.insert! %Scenario{
      name: "Flies and Spiders, Part II",
      blurb: "Elves inadvertently rescue Thorin's company from the spiders of Mirkwood.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 58,
      map_width: 48, map_height: 48, location: :mirkwood
    }

    Repo.insert! %ScenarioResource{scenario_id: dos_s3.id, resource_type: :source, book: :dos, title: "The Desolation of Smaug", sort_order: 3, page: 10}

    dos_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: dos_s3.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(dos_s3f1,  1, 1, [ thorin ])
    _declare_role_figure(dos_s3f1,  1, 1, [ balin ])
    _declare_role_figure(dos_s3f1,  1, 1, [ dwalin ])
    _declare_role_figure(dos_s3f1,  1, 1, [ fili ])
    _declare_role_figure(dos_s3f1,  1, 1, [ kili ])
    _declare_role_figure(dos_s3f1,  1, 1, [ oin ])
    _declare_role_figure(dos_s3f1,  1, 1, [ gloin ])
    _declare_role_figure(dos_s3f1,  1, 1, [ ori ])
    _declare_role_figure(dos_s3f1,  1, 1, [ nori ])
    _declare_role_figure(dos_s3f1,  1, 1, [ dori ])
    _declare_role_figure(dos_s3f1,  1, 1, [ bifur ])
    _declare_role_figure(dos_s3f1,  1, 1, [ bofur ])
    _declare_role_figure(dos_s3f1,  1, 1, [ bombur ])
    _declare_role_figure(dos_s3f1,  1, 1, [ young_bilbo ])
    _declare_role_figure(dos_s3f1,  1, 1, [ legolas ])
    _declare_role_figure(dos_s3f1,  1, 1, [ tauriel ])
    _declare_role_figure(dos_s3f1, 24, 1, [ mirkwood_ranger ])

    dos_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: dos_s3.id, faction: :dol_guldur, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(dos_s3f2, 18, 1, [ mirkwood_spider ])

    #========================================================================
    dos_s4 = Repo.insert! %Scenario{
      name: "Barrels Out of Bond, Part I",
      blurb: "Azog's troops catch up to the dwarves, who are escaping in barrels from the elves.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 74,
      map_width: 72, map_height: 48, location: :mirkwood
    }

    Repo.insert! %ScenarioResource{scenario_id: dos_s4.id, resource_type: :source, book: :dos, title: "The Desolation of Smaug", sort_order: 4, page: 12}
    _declare_web_replay(dos_s4.id, "http://davetownsend.org/Battles/LotR-20160507/", "DaveT", 1)
    _declare_podcast(dos_s4.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-8-barrels-out-of-bond", "The Green Dragon", 1)

    dos_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: dos_s4.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(dos_s4f1,  1,  1, [ thorin_barrel ])
    _declare_role_figure(dos_s4f1,  1,  2, [ balin_barrel ])
    _declare_role_figure(dos_s4f1,  1,  3, [ dwalin_barrel ])
    _declare_role_figure(dos_s4f1,  1,  4, [ fili_barrel ])
    _declare_role_figure(dos_s4f1,  1,  5, [ kili_barrel ])
    _declare_role_figure(dos_s4f1,  1,  6, [ oin_barrel ])
    _declare_role_figure(dos_s4f1,  1,  7, [ gloin_barrel ])
    _declare_role_figure(dos_s4f1,  1,  8, [ ori_barrel ])
    _declare_role_figure(dos_s4f1,  1,  9, [ nori_barrel ])
    _declare_role_figure(dos_s4f1,  1, 10, [ dori_barrel ])
    _declare_role_figure(dos_s4f1,  1, 11, [ bifur_barrel ])
    _declare_role_figure(dos_s4f1,  1, 12, [ bofur_barrel ])
    _declare_role_figure(dos_s4f1,  1, 13, [ bombur_barrel ])
    _declare_role_figure(dos_s4f1,  1, 14, [ young_bilbo_barrel ])
    _declare_role_figure(dos_s4f1,  1, 15, [ legolas ])
    _declare_role_figure(dos_s4f1,  1, 16, [ tauriel ])
    _declare_role_figure(dos_s4f1, 20, 17, [ mirkwood_ranger ])

    dos_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: dos_s4.id, faction: :azogs_hunters, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(dos_s4f2,  1, 1, [ azog_warg ])
    _declare_role_figure(dos_s4f2,  1, 2, [ fimbul_warg ])
    _declare_role_figure(dos_s4f2,  1, 3, [ narzug ])
    _declare_role_figure(dos_s4f2, 24, 4, [ hunter_orc ])
    _declare_role_figure(dos_s4f2, 12, 5, [ hunter_orc_warg ])

    #========================================================================
    dos_s5 = Repo.insert! %Scenario{
      name: "Barrels Out of Bond, Part II",
      blurb: "Azog's troops attempt to capture or kill Kili.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 72,
      map_width: 72, map_height: 48, location: :mirkwood
    }

    Repo.insert! %ScenarioResource{scenario_id: dos_s5.id, resource_type: :source, book: :dos, title: "The Desolation of Smaug", sort_order: 5, page: 14}

    dos_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: dos_s5.id, faction: :mirkwood, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(dos_s5f1,  1, 1, [ legolas ])
    _declare_role_figure(dos_s5f1,  1, 2, [ tauriel ])
    _declare_role_figure(dos_s5f1,  1, 3, [ kili ])
    _declare_role_figure(dos_s5f1, 20, 4, [ mirkwood_ranger ])
    _declare_role_figure(dos_s5f1, 10, 5, [ mirkwood_palace_gd ])

    dos_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: dos_s5.id, faction: :azogs_hunters, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(dos_s5f2,  1, 1, [ azog_warg ])
    _declare_role_figure(dos_s5f2,  1, 2, [ fimbul_warg ])
    _declare_role_figure(dos_s5f2,  1, 3, [ narzug ])
    _declare_role_figure(dos_s5f2, 24, 4, [ hunter_orc ])
    _declare_role_figure(dos_s5f2, 12, 5, [ hunter_orc_warg ])

    #========================================================================
    dos_s6 = Repo.insert! %Scenario{
      name: "The Battle of Dimrill Dale, Part I",
      blurb: "Azog goes after Thror.",
      date_age: 3, date_year: 2799, date_month: 0, date_day: 0, size: 123,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: dos_s6.id, resource_type: :source, book: :dos, title: "The Desolation of Smaug", sort_order: 6, page: 16}
    _declare_video_replay(dos_s6.id, "https://www.youtube.com/watch?v=1BNm0UIbSTQ&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV&index=32", "Spillforeningen the Fellowship", 1)

    dos_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: dos_s6.id, faction: :army_thror, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(dos_s6f1,  1,  1, [ thror ])
    _declare_role_figure(dos_s6f1,  1,  2, [ thrain ])
    _declare_role_figure(dos_s6f1,  1,  3, [ thorin ])
    _declare_role_figure(dos_s6f1,  2,  4, "Captains of Erebor with shield", [ erebor_captain ])
    _declare_role_figure(dos_s6f1,  2,  5, [ grim_hammer_captain ])
    _declare_role_figure(dos_s6f1, 13,  6, [ erebor_w_shield ])
    _declare_role_figure(dos_s6f1, 12,  7, [ erebor_w_spear ])
    _declare_role_figure(dos_s6f1,  1,  8, [ erebor_w_banner ])
    _declare_role_figure(dos_s6f1, 23,  9, [ grim_hammer_w ])
    _declare_role_figure(dos_s6f1,  1, 10, [ grim_hammer_w_banner ])

    dos_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: dos_s6.id, faction: :azogs_hunters, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(dos_s6f2,  1,  1, [ azog ])
    _declare_role_figure(dos_s6f2,  1,  2, [ fimbul_warg ])
    _declare_role_figure(dos_s6f2,  1,  3, [ narzug ])
    _declare_role_figure(dos_s6f2,  1,  4, [ yazneg ])
    _declare_role_figure(dos_s6f2,  3,  5, [ hunter_orc_captain ])
    _declare_role_figure(dos_s6f2,  2,  6, [ hunter_orc_captain_warg ])
    _declare_role_figure(dos_s6f2, 12,  7, [ hunter_orc_warg ])
    _declare_role_figure(dos_s6f2, 12,  8, [ hunter_orc ])
    _declare_role_figure(dos_s6f2, 24,  9, [ fell_warg ])

    #========================================================================
    dos_s7 = Repo.insert! %Scenario{
      name: "The Battle of Dimrill Dale, Part II",
      blurb: "Azog goes after Thrain.",
      date_age: 3, date_year: 2799, date_month: 0, date_day: 0, size: 93,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: dos_s7.id, resource_type: :source, book: :dos, title: "The Desolation of Smaug", sort_order: 7, page: 18}
    _declare_video_replay(dos_s7.id, "https://www.youtube.com/watch?v=yP84ftOiTQQ&index=33&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV", "Spillforeningen the Fellowship", 1)

    dos_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: dos_s7.id, faction: :army_thror, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(dos_s7f1,  1,  1, [ thrain ])
    _declare_role_figure(dos_s7f1,  1,  2, [ thorin ])
    _declare_role_figure(dos_s7f1,  2,  3, "Captains of Erebor with shield", [ erebor_captain ])
    _declare_role_figure(dos_s7f1,  2,  4, [ grim_hammer_captain ])
    _declare_role_figure(dos_s7f1, 12,  5, [ erebor_w_shield ])
    _declare_role_figure(dos_s7f1, 12,  6, [ erebor_w_spear ])
    _declare_role_figure(dos_s7f1, 20,  7, [ grim_hammer_w ])

    dos_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: dos_s7.id, faction: :azogs_hunters, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(dos_s7f2,  1,  1, [ azog ])
    _declare_role_figure(dos_s7f2,  1,  2, [ fimbul_warg ])
    _declare_role_figure(dos_s7f2,  1,  3, [ narzug ])
    _declare_role_figure(dos_s7f2,  1,  4, [ yazneg ])
    _declare_role_figure(dos_s7f2,  3,  5, [ hunter_orc_captain_warg ])
    _declare_role_figure(dos_s7f2, 12,  7, [ hunter_orc_warg ])
    _declare_role_figure(dos_s7f2, 12,  8, [ hunter_orc ])
    _declare_role_figure(dos_s7f2, 12,  9, [ fell_warg ])

    #========================================================================
    dos_s8 = Repo.insert! %Scenario{
      name: "The Battle of Dimrill Dale, Part III",
      blurb: "Azog goes after Thorin.",
      date_age: 3, date_year: 2799, date_month: 0, date_day: 0, size: 66,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: dos_s8.id, resource_type: :source, book: :dos, title: "The Desolation of Smaug", sort_order: 8, page: 20}
    _declare_video_replay(dos_s8.id, "https://www.youtube.com/watch?v=UNuXKiGSXjA&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV&index=34", "Spillforeningen the Fellowship", 1)

    dos_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: dos_s8.id, faction: :army_thror, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(dos_s8f1,  1,  1, [ thorin ])
    _declare_role_figure(dos_s8f1,  1,  2, [ balin ])
    _declare_role_figure(dos_s8f1,  1,  3, [ dwalin ])
    _declare_role_figure(dos_s8f1, 12,  4, [ erebor_w_shield ])
    _declare_role_figure(dos_s8f1, 12,  5, [ erebor_w_spear ])

    dos_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: dos_s8.id, faction: :azogs_hunters, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(dos_s8f2,  1,  1, [ azog ])
    _declare_role_figure(dos_s8f2,  2,  2, [ gundabad_orc_captain ])
    _declare_role_figure(dos_s8f2, 36,  3, "Gundabad Orcs", [ gundabad_orc_shield, gundabad_orc_spear ])

    #########################################################################
    # THE FALL OF THE NECROMANCER
    #########################################################################

    #========================================================================
    fotn_s1 = Repo.insert! %Scenario{
      name: "Dol Guldur Awakens",
      blurb: "Thranduil leads a warband against the creatures of Mirkwood.",
      date_age: 3, date_year: 2060, date_month: 0, date_day: 0, size: 22,
      map_width: 24, map_height: 24, location: :mirkwood
    }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s1.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 1, page: 8}
    _declare_video_replay(fotn_s1.id, "https://www.youtube.com/watch?v=0_dCdLngsKs&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", "Mid-Sussex Wargamers", 1)

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
      date_age: 3,  date_year: 2061, date_month: 0, date_day: 0, size: 65,
      map_width: 48, map_height: 48, location: :mirkwood
    }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s2.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 2, page: 10}
    _declare_video_replay(fotn_s2.id, "https://www.youtube.com/watch?v=AMrP8abPj0Q&index=2&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", "Mid-Sussex Wargamers", 1)

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
      date_age: 3, date_year: 2062, date_month: 0, date_day: 0, size: 23,
      map_width: 48, map_height: 48, location: :mirkwood
    }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s3.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 3, page: 12}
    _declare_video_replay(fotn_s3.id, "https://www.youtube.com/watch?v=YN8X_azJfO8&index=3&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", "Mid-Sussex Wargamers", 1)

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
      blurb: "The Istari face the minions of Dol Guldur.",
      date_age: 3, date_year: 2062, date_month: -1, date_day: 0, size: 17,
      map_width: 24, map_height: 24, location: :mirkwood
    }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s4.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 4, page: 14}
    _declare_video_replay(fotn_s4.id, "https://www.youtube.com/watch?v=UbIM0XE6jT8&index=4&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", "Mid-Sussex Wargamers", 1)

    fotn_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s4.id, faction: :white_council, suggested_points: 500, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotn_s4f1, 1, 1, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(fotn_s4f1, 1, 2, "Radagast the Brown", [ radagast_goblintown, radagast_lotr, radagast_sebastian ])
    _declare_role_figure(fotn_s4f1, 1, 3, "Saruman the White", saruman_foot_all)

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
      blurb: "Lothlórien attacks the beasts of Mirkwood",
      date_age: 3, date_year: 2063, date_month: 0, date_day: 0, size: 41,
      map_width: 24, map_height: 24, location: :mirkwood
    }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s5.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 5, page: 16}
    _declare_video_replay(fotn_s5.id, "https://www.youtube.com/watch?v=eyHTP-Vjhd8&index=5&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", "Mid-Sussex Wargamers", 1)

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
      date_age: 3, date_year: 2850, date_month: 0, date_day: 0, size: 91,
      map_width: 48, map_height: 48, location: :dol_guldur
    }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s6.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 6, page: 18}
    _declare_video_replay(fotn_s6.id, "https://www.youtube.com/watch?v=Cug7stLutRQ&index=6&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", "Mid-Sussex Wargamers", 1)

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
      date_age: 3, date_year: 2851, date_month: 0, date_day: 0, size: 29,
      map_width: 24, map_height: 24, location: :dol_guldur
    }

    Repo.insert! %ScenarioResource{scenario_id: fotn_s7.id, resource_type: :source, book: :fotn, title: "Fall of the Necromancer", sort_order: 7, page: 20}
    _declare_video_replay(fotn_s7.id, "https://www.youtube.com/watch?v=2J5px0_J2wQ&index=7&list=PLa_Dq2-Vx86ITkcanEGELzdBfezvkYtUq", "Mid-Sussex Wargamers", 1)

    fotn_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: fotn_s7.id, faction: :rivendell,  suggested_points: 1500, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotn_s7f1, 1, 1, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(fotn_s7f1, 1, 2, "Saruman the White", saruman_foot_all)
    _declare_role_figure(fotn_s7f1, 1, 3, "Radagast the Brown", [ radagast_goblintown, radagast_lotr, radagast_sebastian ])
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
    # FALLEN REALMS
    #########################################################################

    #========================================================================
    fr_s1 = Repo.insert! %Scenario{
      name: "The Deeping Wall",
      blurb: "The Uruk-hai attempt to breach the outer defenses of Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 83,
      map_width: 48, map_height: 24, location: :helms_deep
    }

    Repo.insert! %ScenarioResource{scenario_id: fr_s1.id, resource_type: :source, book: :fr, title: "Fallen Realms", sort_order: 1, page: 46}

    fr_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: fr_s1.id, faction: :rohan,  suggested_points: 600, actual_points: 0, sort_order: 1}
    _declare_role_figure(fr_s1f1, 1,  1, "Aragorn with Elven cloak", [ aragorn ])
    _declare_role_figure(fr_s1f1, 1,  2, "Legolas with Elven cloak", [ legolas ])
    _declare_role_figure(fr_s1f1, 1,  3, "Gimli with Elven cloak", gimli_all_foot)
    _declare_role_figure(fr_s1f1, 1,  4, "Rohan Captain with Heavy Armour", [ rohan_captain ])
    _declare_role_figure(fr_s1f1, 1,  5, "Haldir, Defender of Helm's Deep", [ haldir ])
    _declare_role_figure(fr_s1f1, 3,  6, [ rohan_gd ])
    _declare_role_figure(fr_s1f1, 3,  7, [ rohan_w_spear_shield ])
    _declare_role_figure(fr_s1f1, 3,  8, [ rohan_w_bow ])
    _declare_role_figure(fr_s1f1, 2,  9, [ rohan_w_shield ])
    _declare_role_figure(fr_s1f1, 2, 10, [ rohan_w_spear_shield ])
    _declare_role_figure(fr_s1f1, 3, 11, [ galadhrim_w_bow ])
    _declare_role_figure(fr_s1f1, 5, 12, [ galadhrim_w_blade ])

    fr_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: fr_s1.id, faction: :isengard,  suggested_points: 900, actual_points: 0, sort_order: 2}
    _declare_role_figure(fr_s1f2,  2,  1, "Uruk-hai Captains with shield and heavy armour", [ uruk_hai_captain_shield ])
    _declare_role_figure(fr_s1f2,  2,  2, "Uruk-hai Captains with two-handed weapon and heavy armour", [ uruk_hai_captain_2h ])
    _declare_role_figure(fr_s1f2,  9,  3, [ uruk_hai_berserker ])
    _declare_role_figure(fr_s1f2,  9,  4, [ uruk_hai_w_crossbow ])
    _declare_role_figure(fr_s1f2, 13,  5, [ uruk_hai_w_shield ])
    _declare_role_figure(fr_s1f2, 14,  6, [ uruk_hai_w_pike ])
    _declare_role_figure(fr_s1f2,  2,  7, [ uruk_hai_demo_charge ])
    _declare_role_figure(fr_s1f2,  4,  8, [ uruk_hai_demo_crew ])
    _declare_role_figure(fr_s1f2,  2,  9, [ uruk_hai_demo_berserker ])

    #========================================================================
    fr_s2 = Repo.insert! %Scenario{
      name: "Charge of the Mûmakil",
      blurb: "Eomer attempts to ride down the Mûmakil at the Pelennor Fields.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 62,
      map_width: 48, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: fr_s2.id, resource_type: :source, book: :fr, title: "Fallen Realms", sort_order: 2, page: 47}

    fr_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: fr_s2.id, faction: :rohan,  suggested_points: 500, actual_points: 0, sort_order: 1}
    _declare_role_figure(fr_s2f1,  1,  1, "Éomer, Knight of the Pelennor, on horse", [ eomer_horse ])
    _declare_role_figure(fr_s2f1,  1,  2, "Rohan Captain on horse with heavy armour and shield", [ rohan_captain_horse ])
    _declare_role_figure(fr_s2f1,  9,  3, [ rohan_rider_spear ])
    _declare_role_figure(fr_s2f1, 13,  4, [ rohan_rider ])

    fr_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: fr_s2.id, faction: :harad,  suggested_points: 900, actual_points: 0, sort_order: 1}
    _declare_role_figure(fr_s2f2,  1,  1, "Haradrim Chieftain on horse with war spear", [ harad_chieftain_horse ])
    _declare_role_figure(fr_s2f2,  2,  2, [ mumak ])
    _declare_role_figure(fr_s2f2, 14,  3, [ harad_w_bow ])
    _declare_role_figure(fr_s2f2, 13,  4, [ harad_w_spear ])
    _declare_role_figure(fr_s2f2,  4,  5, [ harad_raider ])
    _declare_role_figure(fr_s2f2,  4,  6, [ harad_raider_lance ])

    #########################################################################
    # THE FELLOWSHIP OF THE RING
    #########################################################################

    #========================================================================
    fotr_s1 = Repo.insert! %Scenario{
      name: "Close Encounter",
      blurb: "The remnants of Sauron's army attack Numenorians returning from the last battle against Sauron.",
      date_age: 2, date_year: 3442, date_month: 0, date_day: 0, size: 36,
      map_width: 48, map_height: 48, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: fotr_s1.id, resource_type: :source, book: :fotr, title: "The Fellowship of the Ring", sort_order: 1, page: 64}
    _declare_video_replay(fotr_s1.id, "https://www.youtube.com/watch?v=3XttmqOQvt4&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV&index=8", "Spillforeningen the Fellowship", 1)

    fotr_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: fotr_s1.id, faction: :numenor, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotr_s1f1, 4, 1, [ numenor_w_shield_spear ])
    _declare_role_figure(fotr_s1f1, 8, 2, [ numenor_w_shield ])

    fotr_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: fotr_s1.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotr_s1f2, 8, 1, [ moria_g_shield ])
    _declare_role_figure(fotr_s1f2, 8, 2, [ moria_g_spear ])
    _declare_role_figure(fotr_s1f2, 8, 3, [ moria_g_bow ])

    #========================================================================
    fotr_s2 = Repo.insert! %Scenario{
      name: "Weathertop",
      blurb: "The Witch-King attempts to seize the One Ring from Frodo and friends.",
      date_age: 3, date_year: 3018, date_month: 10, date_day: 6, size: 10,
      map_width: 48, map_height: 48, location: :weathertop
    }

    Repo.insert! %ScenarioResource{scenario_id: fotr_s2.id, resource_type: :source, book: :fotr, title: "The Fellowship of the Ring", sort_order: 2, page: 66}

    fotr_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: fotr_s2.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotr_s2f1, 1, 1, [ frodo ])
    _declare_role_figure(fotr_s2f1, 1, 2, [ sam ])
    _declare_role_figure(fotr_s2f1, 1, 3, [ merry ])
    _declare_role_figure(fotr_s2f1, 1, 4, [ pippin ])
    _declare_role_figure(fotr_s2f1, 1, 5, [ aragorn ])

    fotr_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: fotr_s2.id, faction: :nazgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotr_s2f2, 1, 1, [ witch_king ])
    _declare_role_figure(fotr_s2f2, 4, 2, [ ringwraith ])

    #========================================================================
    fotr_s3 = Repo.insert! %Scenario{
      name: "Balin's Tomb",
      blurb: "The Fellowship are cornered in Balin's Tomb by goblins, and They Have a Cave Troll.",
      date_age: 3, date_year: 3019, date_month: 1, date_day: 14, size: 49,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: fotr_s3.id, resource_type: :source, book: :fotr, title: "The Fellowship of the Ring", sort_order: 3, page: 68}

    fotr_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: fotr_s3.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotr_s3f1, 1, 1, [ frodo ])
    _declare_role_figure(fotr_s3f1, 1, 2, [ sam ])
    _declare_role_figure(fotr_s3f1, 1, 3, [ merry ])
    _declare_role_figure(fotr_s3f1, 1, 4, [ pippin ])
    _declare_role_figure(fotr_s3f1, 1, 5, [ aragorn ])
    _declare_role_figure(fotr_s3f1, 1, 6, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(fotr_s3f1, 1, 7, [ boromir ])
    _declare_role_figure(fotr_s3f1, 1, 8, [ legolas ])
    _declare_role_figure(fotr_s3f1, 1, 9, "Gimli", gimli_all_foot)

    fotr_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: fotr_s3.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotr_s3f2,  3, 1, [ moria_captain ])
    _declare_role_figure(fotr_s3f2, 12, 2, [ moria_g_shield ])
    _declare_role_figure(fotr_s3f2, 12, 3, [ moria_g_spear ])
    _declare_role_figure(fotr_s3f2, 12, 4, [ moria_g_bow ])
    _declare_role_figure(fotr_s3f2,  1, 5, "Cave Troll", [ cave_troll_spear, cave_troll_chain ])

    #========================================================================
    fotr_s4 = Repo.insert! %Scenario{
      name: "The Bridge of Khazad-dûm",
      blurb: "Gandalf sacrifices himself against the Balrog. \"Fly, you fools!\"",
      date_age: 3, date_year: 3019, date_month: 1, date_day: 15, size: 34,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: fotr_s4.id, resource_type: :source, book: :fotr, title: "The Fellowship of the Ring", sort_order: 4, page: 70}

    fotr_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: fotr_s4.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotr_s4f1, 1, 1, [ frodo ])
    _declare_role_figure(fotr_s4f1, 1, 2, [ sam ])
    _declare_role_figure(fotr_s4f1, 1, 3, [ merry ])
    _declare_role_figure(fotr_s4f1, 1, 4, [ pippin ])
    _declare_role_figure(fotr_s4f1, 1, 5, [ aragorn ])
    _declare_role_figure(fotr_s4f1, 1, 6, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(fotr_s4f1, 1, 7, [ boromir ])
    _declare_role_figure(fotr_s4f1, 1, 8, [ legolas ])
    _declare_role_figure(fotr_s4f1, 1, 9, "Gimli", gimli_all_foot)

    fotr_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: fotr_s4.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotr_s4f2, 1, 1, "Balrog", [ balrog, balrog_plastic, balrog_whip ])
    _declare_role_figure(fotr_s4f2, 8, 2, [ moria_g_shield ])
    _declare_role_figure(fotr_s4f2, 8, 3, [ moria_g_spear ])
    _declare_role_figure(fotr_s4f2, 8, 4, [ moria_g_bow ])

    #========================================================================
    fotrjb_s5 = Repo.insert! %Scenario{
      name: "Lothlórien",
      blurb: "The Fellowship finds refuge from a Goblin search party within the edges of Lothlórien.",
      date_age: 3, date_year: 3019, date_month: 1, date_day: 15, size: 59,
      map_width: 48, map_height: 48, location: :lothlorien
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s5.id, resource_type: :source, book: :fotr, title: "The Fellowship of the Ring", sort_order: 5, page: 72}

    fotrjb_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s5.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s5f1,  1,  1, [ frodo ])
    _declare_role_figure(fotrjb_s5f1,  1,  2, [ sam ])
    _declare_role_figure(fotrjb_s5f1,  1,  3, [ merry ])
    _declare_role_figure(fotrjb_s5f1,  1,  4, [ pippin ])
    _declare_role_figure(fotrjb_s5f1,  1,  5, [ aragorn ])
    _declare_role_figure(fotrjb_s5f1,  1,  6, [ boromir ])
    _declare_role_figure(fotrjb_s5f1,  1,  7, [ legolas ])
    _declare_role_figure(fotrjb_s5f1,  1,  8, "Gimli", gimli_all_foot)
    _declare_role_figure(fotrjb_s5f1,  1,  9, [ haldir ])
    _declare_role_figure(fotrjb_s5f1, 10, 10, [ wood_elf_w_bow ])

    fotrjb_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s5.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotrjb_s5f2,  2, 1, [ moria_captain ])
    _declare_role_figure(fotrjb_s5f2, 16, 3, [ moria_g_shield ])
    _declare_role_figure(fotrjb_s5f2, 16, 4, [ moria_g_spear ])
    _declare_role_figure(fotrjb_s5f2, 16, 5, [ moria_g_bow ])

    #========================================================================
    fotr_s6 = Repo.insert! %Scenario{
      name: "Amon Hen",
      blurb: "The Uruk-hai split the Fellowship and run off with some hobbits.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 26, size: 36,
      map_width: 72, map_height: 48, location: :amon_hen
    }

    Repo.insert! %ScenarioResource{scenario_id: fotr_s6.id, resource_type: :source, book: :fotr, title: "The Fellowship of the Ring", sort_order: 6, page: 74}

    fotr_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: fotr_s6.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotr_s6f1,  1,  1, [ aragorn ])
    _declare_role_figure(fotr_s6f1,  1,  2, [ boromir ])
    _declare_role_figure(fotr_s6f1,  1,  3, [ legolas ])
    _declare_role_figure(fotr_s6f1,  1,  4, "Gimli", gimli_all_foot)
    _declare_role_figure(fotr_s6f1,  1,  5, [ frodo ])
    _declare_role_figure(fotr_s6f1,  1,  6, [ sam ])
    _declare_role_figure(fotr_s6f1,  1,  7, [ merry ])
    _declare_role_figure(fotr_s6f1,  1,  8, [ pippin ])

    fotr_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: fotr_s6.id, faction: :isengard, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotr_s6f2,  1,  1, [ lurtz ])
    _declare_role_figure(fotr_s6f2, 35,  2, [ uruk_hai_s_sword_shield ])
    _declare_role_figure(fotr_s6f2,  5,  3, [ uruk_hai_s_bow ])

    #========================================================================
    fotr_s7 = Repo.insert! %Scenario{
      name: "The Last Alliance",
      blurb: "Elendil and Gil-Galad lead the forces of Men and Elves against hundreds (literally!) of Orcs.",
      date_age: 2, date_year: 3441, date_month: 0, date_day: 0, size: 348,
      map_width: 72, map_height: 48, location: :mordor
    }

    Repo.insert! %ScenarioResource{scenario_id: fotr_s7.id, resource_type: :source, book: :fotr, title: "The Fellowship of the Ring", sort_order: 7, page: 76}

    fotr_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: fotr_s7.id, faction: :rivendell, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotr_s7f1,  1,  1, [ gil_galad ])
    _declare_role_figure(fotr_s7f1,  1,  2, [ elrond ])
    _declare_role_figure(fotr_s7f1, 24,  3, [ high_elf_w_blade ])
    _declare_role_figure(fotr_s7f1, 24,  4, [ high_elf_w_bow ])
    _declare_role_figure(fotr_s7f1,  1,  5, [ elendil ])
    _declare_role_figure(fotr_s7f1,  1,  6, [ isildur ])
    _declare_role_figure(fotr_s7f1, 24,  7, [ numenor_w_shield ])
    _declare_role_figure(fotr_s7f1, 24,  8, [ numenor_w_shield_spear ])

    fotr_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: fotr_s7.id, faction: :barad_dur, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotr_s7f2,  8,  1, [ orc_captain ])
    _declare_role_figure(fotr_s7f2, 90,  6, [ orc_w_shield ])
    _declare_role_figure(fotr_s7f2, 90,  7, [ orc_w_spear ])
    _declare_role_figure(fotr_s7f2, 60,  8, [ orc_w_bow ])

    #========================================================================
    fotr_s8 = Repo.insert! %Scenario{
      name: "The Gladden Fields",
      blurb: "Isildur must escape from an Orcish ambush to keep the One Ring.",
      date_age: 3, date_year: 2, date_month: 0, date_day: 0, size: 91,
      map_width: 48, map_height: 24, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: fotr_s8.id, resource_type: :source, book: :fotr, title: "The Fellowship of the Ring", sort_order: 8, page: 78}

    fotr_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: fotr_s8.id, faction: :numenor, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotr_s8f1,  1, 1, "Isildur with the One Ring", [ isildur ])
    _declare_role_figure(fotr_s8f1, 24, 3, [ numenor_w_shield ])
    _declare_role_figure(fotr_s8f1, 24, 4, [ numenor_w_shield_spear ])

    fotr_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: fotr_s8.id, faction: :cirith_ungol, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotr_s8f2,  2,  1, [ orc_captain ])
    _declare_role_figure(fotr_s8f2, 20,  3, [ orc_w_shield ])
    _declare_role_figure(fotr_s8f2, 10,  4, [ orc_w_spear ])
    _declare_role_figure(fotr_s8f2, 10,  6, [ orc_w_bow ])

    #########################################################################
    # THE FELLOWSHIP OF THE RING JOURNEYBOOK
    #########################################################################

    #========================================================================
    fotrjb_s1 = Repo.insert! %Scenario{
      name: "The Hunt Begins",
      blurb: "The Nazgul probe the edges of the Shire, where the Dúnedain drive them off.",
      date_age: 3, date_year: 3018, date_month: 9, date_day: 21, size: 12,
      map_width: 48, map_height: 48, location: :eriador
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s1.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 1, page: 16}

    fotrjb_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s1.id, faction: :arnor, suggested_points: 216, actual_points: 216, sort_order: 1}
    _declare_role_figure(fotrjb_s1f1, 9, 1, [ dunedain ])

    fotrjb_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s1.id, faction: :nazgul, suggested_points: 180, actual_points: 180, sort_order: 2}
    _declare_role_figure(fotrjb_s1f2, 1, 1, [ witch_king ])
    _declare_role_figure(fotrjb_s1f2, 2, 2, [ ringwraith ])

    #========================================================================
    fotrjb_s2 = Repo.insert! %Scenario{
      name: "The Trust of Arnor",
      blurb: "The Nazgul drive off the Dúnedain protecting the Shire (well, in the story they do...).",
      date_age: 3, date_year: 3018, date_month: 9, date_day: 22, size: 18,
      map_width: 48, map_height: 48, location: :the_shire
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s2.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 2, page: 18}

    fotrjb_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s2.id, faction: :arnor, suggested_points: 216, actual_points: 216, sort_order: 1}
    _declare_role_figure(fotrjb_s2f1, 9, 1, [ dunedain ])

    fotrjb_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s2.id, faction: :nazgul, suggested_points: 550, actual_points: 550, sort_order: 2}
    _declare_role_figure(fotrjb_s2f2, 1, 1, [ witch_king ])
    _declare_role_figure(fotrjb_s2f2, 8, 2, [ ringwraith ])

    #========================================================================
    fotrjb_s3 = Repo.insert! %Scenario{
      name: "Short Cuts Make Long Delays",
      blurb: "Frodo and friends escape from searching Ringwraiths thanks to the timely appearance of Gildor Inglorion.",
      date_age: 3, date_year: 3018, date_month: 9, date_day: 23, size: 8,
      map_width: 48, map_height: 48, location: :the_shire
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s3.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 3, page: 20}
    _declare_web_replay(fotrjb_s3.id, "http://davetownsend.org/Battles/LotR-20050929/", "DaveT", 1)

    fotrjb_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s3.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s3f1, 1, 1, [ frodo ])
    _declare_role_figure(fotrjb_s3f1, 1, 2, [ sam ])
    _declare_role_figure(fotrjb_s3f1, 1, 3, [ pippin ])
    _declare_role_figure(fotrjb_s3f1, 1, 4, [ merry ])
    _declare_role_figure(fotrjb_s3f1, 1, 5, [ gildor ])

    fotrjb_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s3.id, faction: :nazgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotrjb_s3f2, 3, 1, [ ringwraith ])

    #========================================================================
    fotrjb_s4 = Repo.insert! %Scenario{
      name: "Bucklebury Ferry",
      blurb: "Frodo and friends dodge the Ringwraiths by crossing the Brandywine River.",
      date_age: 3, date_year: 3018, date_month: 9, date_day: 24, size: 7,
      map_width: 48, map_height: 48, location: :the_shire
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s4.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 4, page: 26}

    fotrjb_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s4.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s4f1, 1, 1, [ frodo ])
    _declare_role_figure(fotrjb_s4f1, 1, 2, [ sam ])
    _declare_role_figure(fotrjb_s4f1, 1, 3, [ pippin ])
    _declare_role_figure(fotrjb_s4f1, 1, 4, [ merry ])

    fotrjb_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s4.id, faction: :nazgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotrjb_s4f2, 3, 1, [ ringwraith ])

    #========================================================================
    fotrjb_s5 = Repo.insert! %Scenario{
      name: "Fog on the Barrow Downs",
      blurb: "Frodo's band must escape from the dead spirits of Angmar.",
      date_age: 3, date_year: 3018, date_month: 9, date_day: 28, size: 9,
      map_width: 48, map_height: 48, location: :eriador
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s5.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 5, page: 30}

    fotrjb_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s5.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s5f1, 1, 1, [ frodo ])
    _declare_role_figure(fotrjb_s5f1, 1, 2, [ sam ])
    _declare_role_figure(fotrjb_s5f1, 1, 3, [ pippin ])
    _declare_role_figure(fotrjb_s5f1, 1, 4, [ merry ])
    _declare_role_figure(fotrjb_s5f1, 1, 5, [ tom_bombadil ])

    fotrjb_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s5.id, faction: :angmar, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotrjb_s5f2, 4, 1, [ barrow_wight ])

    #========================================================================
    fotrjb_s6 = Repo.insert! %Scenario{
      name: "The Grey Pilgrim and the Black Riders",
      blurb: "Gandalf is attacked by the Ringwraiths at Weathertop.",
      date_age: 3, date_year: 3018, date_month: 10, date_day: 3, size: 10,
      map_width: 24, map_height: 24, location: :weathertop
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s6.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 6, page: 42}

    fotrjb_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s6.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s6f1, 1, 1, "Gandalf the Grey", gandalf_grey_foot_all)

    fotrjb_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s6.id, faction: :nazgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotrjb_s6f2, 1, 1, [ witch_king ])
    _declare_role_figure(fotrjb_s6f2, 8, 2, [ ringwraith ])

    #========================================================================
    fotrjb_s7 = Repo.insert! %Scenario{
      name: "Pursuit Into the Wild",
      blurb: "Gandalf draws off the Ringwraiths.",
      date_age: 3, date_year: 3018, date_month: 10, date_day: 4, size: 11,
      map_width: 48, map_height: 48, location: :eriador
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s7.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 7, page: 44}

    fotrjb_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s7.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s7f1, 1, 1, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(fotrjb_s7f1, 6, 2, [ dunedain ])

    fotrjb_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s7.id, faction: :nazgul, suggested_points: 220, actual_points: 220, sort_order: 2}
    _declare_role_figure(fotrjb_s7f2, 4, 1, [ ringwraith ])

    #========================================================================
    fotrjb_s8 = Repo.insert! %Scenario{
      name: "Amon Sûl",
      blurb: "Frodo and friends are attacked by the Ringwraiths at Weathertop.",
      date_age: 3, date_year: 3018, date_month: 10, date_day: 6, size: 10,
      map_width: 48, map_height: 48, location: :weathertop
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s8.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 8, page: 46}
    _declare_podcast(fotrjb_s8.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-1-amon-sul", "The Green Dragon", 1)

    fotrjb_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s8.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s8f1, 1, 1, [ frodo ])
    _declare_role_figure(fotrjb_s8f1, 1, 2, [ sam ])
    _declare_role_figure(fotrjb_s8f1, 1, 3, [ merry ])
    _declare_role_figure(fotrjb_s8f1, 1, 4, [ pippin ])
    _declare_role_figure(fotrjb_s8f1, 1, 5, [ aragorn ])

    fotrjb_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s8.id, faction: :nazgul, suggested_points: 330, actual_points: 330, sort_order: 2}
    _declare_role_figure(fotrjb_s8f2, 1, 1, [ witch_king ])
    _declare_role_figure(fotrjb_s8f2, 4, 2, [ ringwraith ])

    #========================================================================
    fotrjb_s9 = Repo.insert! %Scenario{
      name: "Flight to the Ford",
      blurb: "A wounded Frodo must get to Rivendell before succumbing to the effects of the Morgul blade.  Can Glorfindel (or possibly Arwen) help?",
      date_age: 3, date_year: 3018, date_month: 10, date_day: 20, size: 15,
      map_width: 48, map_height: 48, location: :eriador
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s9.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 9, page: 50}

    fotrjb_s9f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s9.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s9f1, 1, 1, [ frodo ])
    _declare_role_figure(fotrjb_s9f1, 1, 2, [ sam ])
    _declare_role_figure(fotrjb_s9f1, 1, 3, [ merry ])
    _declare_role_figure(fotrjb_s9f1, 1, 4, [ pippin ])
    _declare_role_figure(fotrjb_s9f1, 1, 5, [ aragorn ])
    _declare_role_figure(fotrjb_s9f1, 1, 6, [ boromir ])
    _declare_role_figure(fotrjb_s9f1, 1, 7, [ legolas ])
    _declare_role_figure(fotrjb_s9f1, 1, 8, "Gimli", gimli_all_foot)

    fotrjb_s9f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s9.id, faction: :nazgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotrjb_s9f2, 1, 1, [ witch_king_horse ])
    _declare_role_figure(fotrjb_s9f2, 8, 2, [ ringwraith_horse ])

    #========================================================================
    fotrjb_s10 = Repo.insert! %Scenario{
      name: "The Hounds of Sauron",
      blurb: "The Fellowship is attacked by a pack of wild wargs.",
      date_age: 3, date_year: 3019, date_month: 1, date_day: 12, size: 28,
      map_width: 48, map_height: 48, location: :eriador
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s10.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 10, page: 54}

    fotrjb_s10f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s10.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s10f1, 1, 1, [ frodo ])
    _declare_role_figure(fotrjb_s10f1, 1, 2, [ sam ])
    _declare_role_figure(fotrjb_s10f1, 1, 3, [ merry ])
    _declare_role_figure(fotrjb_s10f1, 1, 4, [ pippin ])
    _declare_role_figure(fotrjb_s10f1, 1, 5, [ aragorn ])
    _declare_role_figure(fotrjb_s10f1, 1, 6, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(fotrjb_s10f1, 1, 7, [ boromir ])
    _declare_role_figure(fotrjb_s10f1, 1, 8, [ legolas ])
    _declare_role_figure(fotrjb_s10f1, 1, 9, "Gimli", gimli_all_foot)

    fotrjb_s10f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s10.id, faction: :angmar, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotrjb_s10f2,  1, 1, [ warg_chieftain ])
    _declare_role_figure(fotrjb_s10f2, 18, 2, [ warg ])

    #========================================================================
    fotrjb_s11 = Repo.insert! %Scenario{
      name: "The Watcher in the Water",
      blurb: "The Fellowship is chased into Moria by the Watcher in the Water.",
      date_age: 3, date_year: 3019, date_month: 1, date_day: 13, size: 15,
      map_width: 36, map_height: 24, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s11.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 11, page: 58}

    fotrjb_s11f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s11.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s11f1, 1, 1, [ frodo ])
    _declare_role_figure(fotrjb_s11f1, 1, 2, [ sam ])
    _declare_role_figure(fotrjb_s11f1, 1, 3, [ merry ])
    _declare_role_figure(fotrjb_s11f1, 1, 4, [ pippin ])
    _declare_role_figure(fotrjb_s11f1, 1, 5, [ aragorn ])
    _declare_role_figure(fotrjb_s11f1, 1, 6, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(fotrjb_s11f1, 1, 7, [ boromir ])
    _declare_role_figure(fotrjb_s11f1, 1, 8, [ legolas ])
    _declare_role_figure(fotrjb_s11f1, 1, 9, "Gimli", gimli_all_foot)

    fotrjb_s11f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s11.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotrjb_s11f2, 6, 1, [ tentacle ])

    #========================================================================
    fotrjb_s12 = Repo.insert! %Scenario{
      name: "Balin's Tomb",
      blurb: "The Fellowship are cornered in Balin's Tomb by goblins, and They Have a Cave Troll.",
      date_age: 3, date_year: 3019, date_month: 1, date_day: 14, size: 36,
      map_width: 18, map_height: 18, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s12.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 12, page: 64}
    _declare_podcast(fotrjb_s12.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-13-balins-tomb", "The Green Dragon", 1)

    fotrjb_s12f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s12.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s12f1, 1, 1, [ frodo ])
    _declare_role_figure(fotrjb_s12f1, 1, 2, [ sam ])
    _declare_role_figure(fotrjb_s12f1, 1, 3, [ merry ])
    _declare_role_figure(fotrjb_s12f1, 1, 4, [ pippin ])
    _declare_role_figure(fotrjb_s12f1, 1, 5, [ aragorn ])
    _declare_role_figure(fotrjb_s12f1, 1, 6, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(fotrjb_s12f1, 1, 7, [ boromir ])
    _declare_role_figure(fotrjb_s12f1, 1, 8, [ legolas ])
    _declare_role_figure(fotrjb_s12f1, 1, 9, "Gimli", gimli_all_foot)

    fotrjb_s12f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s12.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotrjb_s12f2, 2, 1, [ moria_captain ])
    _declare_role_figure(fotrjb_s12f2, 8, 2, [ moria_g_shield ])
    _declare_role_figure(fotrjb_s12f2, 8, 3, [ moria_g_spear ])
    _declare_role_figure(fotrjb_s12f2, 8, 4, [ moria_g_bow ])
    _declare_role_figure(fotrjb_s12f2, 1, 5, "Cave Troll", [ cave_troll_spear, cave_troll_chain ])

    #========================================================================
    fotrjb_s13 = Repo.insert! %Scenario{
      name: "The Escape from the Dwarrowdelf",
      blurb: "The Fellowship escape from the ambush in Balin's Tomb into yet another ambush.",
      date_age: 3, date_year: 3019, date_month: 1, date_day: 15, size: 36,
      map_width: 36, map_height: 24, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s13.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 13, page: 70}

    fotrjb_s13f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s13.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s13f1, 1, 1, [ frodo ])
    _declare_role_figure(fotrjb_s13f1, 1, 2, [ sam ])
    _declare_role_figure(fotrjb_s13f1, 1, 3, [ merry ])
    _declare_role_figure(fotrjb_s13f1, 1, 4, [ pippin ])
    _declare_role_figure(fotrjb_s13f1, 1, 5, [ aragorn ])
    _declare_role_figure(fotrjb_s13f1, 1, 6, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(fotrjb_s13f1, 1, 7, [ boromir ])
    _declare_role_figure(fotrjb_s13f1, 1, 8, [ legolas ])
    _declare_role_figure(fotrjb_s13f1, 1, 9, "Gimli", gimli_all_foot)

    fotrjb_s13f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s13.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotrjb_s13f2, 2, 1, [ moria_captain ])
    _declare_role_figure(fotrjb_s13f2, 8, 2, [ moria_g_shield ])
    _declare_role_figure(fotrjb_s13f2, 8, 3, [ moria_g_spear ])
    _declare_role_figure(fotrjb_s13f2, 8, 4, [ moria_g_bow ])
    _declare_role_figure(fotrjb_s13f2, 1, 5, "Cave Troll", [ cave_troll_spear, cave_troll_chain ])

    #========================================================================
    fotrjb_s14 = Repo.insert! %Scenario{
      name: "The Bridge of Khazad-dûm",
      blurb: "Gandalf sacrifices himself against the Balrog. \"Fly, you fools!\"",
      date_age: 3, date_year: 3019, date_month: 1, date_day: 15, size: 36,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s14.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 14, page: 76}

    fotrjb_s14f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s14.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s14f1, 1, 1, [ frodo ])
    _declare_role_figure(fotrjb_s14f1, 1, 2, [ sam ])
    _declare_role_figure(fotrjb_s14f1, 1, 3, [ merry ])
    _declare_role_figure(fotrjb_s14f1, 1, 4, [ pippin ])
    _declare_role_figure(fotrjb_s14f1, 1, 5, [ aragorn ])
    _declare_role_figure(fotrjb_s14f1, 1, 6, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(fotrjb_s14f1, 1, 7, [ boromir ])
    _declare_role_figure(fotrjb_s14f1, 1, 8, [ legolas ])
    _declare_role_figure(fotrjb_s14f1, 1, 9, "Gimli", gimli_all_foot)

    fotrjb_s14f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s14.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotrjb_s14f2, 1, 1, "Balrog", [ balrog, balrog_plastic, balrog_whip ])
    _declare_role_figure(fotrjb_s14f2, 2, 2, [ moria_captain ])
    _declare_role_figure(fotrjb_s14f2, 8, 3, [ moria_g_shield ])
    _declare_role_figure(fotrjb_s14f2, 8, 4, [ moria_g_spear ])
    _declare_role_figure(fotrjb_s14f2, 8, 5, [ moria_g_bow ])

    #========================================================================
    fotrjb_s15 = Repo.insert! %Scenario{
      name: "Lothlórien",
      blurb: "The Fellowship finds refuge from a Goblin search party within the edges of Lothlórien.",
      date_age: 3, date_year: 3019, date_month: 1, date_day: 15, size: 50,
      map_width: 48, map_height: 48, location: :lothlorien
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s15.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 15, page: 78}

    fotrjb_s15f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s15.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s15f1, 1,  1, [ frodo ])
    _declare_role_figure(fotrjb_s15f1, 1,  2, [ sam ])
    _declare_role_figure(fotrjb_s15f1, 1,  3, [ merry ])
    _declare_role_figure(fotrjb_s15f1, 1,  4, [ pippin ])
    _declare_role_figure(fotrjb_s15f1, 1,  5, [ aragorn ])
    _declare_role_figure(fotrjb_s15f1, 1,  6, [ boromir ])
    _declare_role_figure(fotrjb_s15f1, 1,  7, [ legolas ])
    _declare_role_figure(fotrjb_s15f1, 1,  8, "Gimli", gimli_all_foot)
    _declare_role_figure(fotrjb_s15f1, 1,  9, [ haldir ])
    _declare_role_figure(fotrjb_s15f1, 6, 10, "Elves with Elf bows & Elven blades", [ wood_elf_w_bow, wood_elf_w_blade ])

    fotrjb_s15f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s15.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotrjb_s15f2,  2, 1, [ moria_captain ])
    _declare_role_figure(fotrjb_s15f2,  1, 1, [ warg_chieftain ])
    _declare_role_figure(fotrjb_s15f2,  8, 3, [ moria_g_shield ])
    _declare_role_figure(fotrjb_s15f2,  8, 4, [ moria_g_spear ])
    _declare_role_figure(fotrjb_s15f2,  8, 5, [ moria_g_bow ])
    _declare_role_figure(fotrjb_s15f2, 18, 6, [ warg ])

    #========================================================================
    fotrjb_s16 = Repo.insert! %Scenario{
      name: "Aragorn's Stand",
      blurb: "Aragorn protects Frodo from marauding Uruk-hai.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 26, size: 24,
      map_width: 48, map_height: 24, location: :amon_hen
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s16.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 16, page: 84}
    _declare_podcast(fotrjb_s16.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-9-amon-hen", "The Green Dragon", 1)

    fotrjb_s16f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s16.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s16f1, 1,  1, [ aragorn ])
    _declare_role_figure(fotrjb_s16f1, 1,  2, [ legolas ])
    _declare_role_figure(fotrjb_s16f1, 1,  3, "Gimli", gimli_all_foot)
    _declare_role_figure(fotrjb_s16f1, 1,  4, [ frodo ])

    fotrjb_s16f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s16.id, faction: :isengard, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotrjb_s16f2,  1, 1, [ lurtz ])
    _declare_role_figure(fotrjb_s16f2,  1, 2, "Uruk-hai Captain", [ uruk_hai_captain_shield, uruk_hai_captain_2h ])
    _declare_role_figure(fotrjb_s16f2,  6, 3, [ uruk_hai_s_bow ])
    _declare_role_figure(fotrjb_s16f2, 12, 4, [ uruk_hai_s_sword_shield ])

    #========================================================================
    fotrjb_s17 = Repo.insert! %Scenario{
      name: "Boromir's Redemption",
      blurb: "Boromir protects Merry and Pipping from marauding Uruk-hai.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 26, size: 22,
      map_width: 48, map_height: 48, location: :amon_hen
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s17.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 17, page: 86}
    _declare_podcast(fotrjb_s17.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-9-amon-hen", "The Green Dragon", 1)

    fotrjb_s17f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s17.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s17f1, 1,  1, [ boromir ])
    _declare_role_figure(fotrjb_s17f1, 1,  2, [ merry ])
    _declare_role_figure(fotrjb_s17f1, 1,  3, [ pippin ])

    fotrjb_s17f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s17.id, faction: :isengard, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotrjb_s17f2,  1, 1, "Uruk-hai Captain", [ uruk_hai_captain_shield, uruk_hai_captain_2h ])
    _declare_role_figure(fotrjb_s17f2, 12, 2, [ uruk_hai_s_sword_shield ])
    _declare_role_figure(fotrjb_s17f2,  6, 3, [ uruk_hai_s_bow ])

    #========================================================================
    fotrjb_s18 = Repo.insert! %Scenario{
      name: "The Breaking of the Fellowship",
      blurb: "Can the Three Hunters save the wounded Boromir?",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 26, size: 24,
      map_width: 48, map_height: 48, location: :amon_hen
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s18.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 18, page: 88}
    _declare_podcast(fotrjb_s18.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-9-amon-hen", "The Green Dragon", 1)

    fotrjb_s18f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s18.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s18f1, 1,  1, [ aragorn ])
    _declare_role_figure(fotrjb_s18f1, 1,  2, [ legolas ])
    _declare_role_figure(fotrjb_s18f1, 1,  3, "Gimli", gimli_all_foot)
    _declare_role_figure(fotrjb_s18f1, 1,  4, [ boromir ])

    fotrjb_s18f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s18.id, faction: :isengard, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotrjb_s18f2,  1, 1, [ lurtz ])
    _declare_role_figure(fotrjb_s18f2,  1, 2, "Uruk-hai Captain", [ uruk_hai_captain_shield, uruk_hai_captain_2h ])
    _declare_role_figure(fotrjb_s18f2,  6, 3, [ uruk_hai_s_bow ])
    _declare_role_figure(fotrjb_s18f2, 12, 4, [ uruk_hai_s_sword_shield ])

    #########################################################################
    # THE FREE PEOPLES
    #########################################################################

    #========================================================================
    fp_s1 = Repo.insert! %Scenario{
      name: "The Battle of Bywater",
      blurb: "The final battle of the War of the Ring.",
      date_age: 3, date_year: 3019, date_month: 11, date_day: 1, size: 58,
      map_width: 36, map_height: 24, location: :the_shire
    }

    Repo.insert! %ScenarioResource{scenario_id: fp_s1.id, resource_type: :source, book: :fp, title: "The Free Peoples", sort_order: 1, page: 57}

    fp_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: fp_s1.id, faction: :shire, suggested_points: 275, actual_points: 275, sort_order: 1}
    _declare_role_figure(fp_s1f1,  1,  1, "Frodo of the Nine Fingers on pony", [ frodo_pony ])
    _declare_role_figure(fp_s1f1,  1,  2, "Samwise the Brave on pony", [ sam_pony ])
    _declare_role_figure(fp_s1f1,  1,  3, "Meriadoc, Captain of the Shire on pony", [ merry_pony ])
    _declare_role_figure(fp_s1f1,  1,  4, "Pippin, Captain of the Shire on pony", [ pippin_pony ])
    _declare_role_figure(fp_s1f1, 12,  5, [ hobbit_militia ])
    _declare_role_figure(fp_s1f1,  8,  6, [ hobbit_archer ])
    _declare_role_figure(fp_s1f1,  3,  7, [ hobbit_shirriff ])

    fp_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: fp_s1.id, faction: :isengard, suggested_points: 175, actual_points: 175, sort_order: 2}
    _declare_role_figure(fp_s1f2,   1,  1, [ sharkey ])
    _declare_role_figure(fp_s1f2,   1,  2, [ worm ])
    _declare_role_figure(fp_s1f2,  10,  3, [ ruffian ])
    _declare_role_figure(fp_s1f2,   9,  4, [ ruffian_bow ])
    _declare_role_figure(fp_s1f2,  10,  5, [ ruffian_whip ])

    #========================================================================
    fp_s2 = Repo.insert! %Scenario{
      name: "The Last Alliance",
      blurb: "Elendil and Gil-Galad lead the forces of Men and Elves against Sauron himself.",
      date_age: 2, date_year: 3441, date_month: 0, date_day: 0, size: 113,
      map_width: 72, map_height: 48, location: :mordor
    }

    Repo.insert! %ScenarioResource{scenario_id: fp_s2.id, resource_type: :source, book: :fp, title: "The Free Peoples", sort_order: 2, page: 58}

    fp_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: fp_s2.id, faction: :rivendell, suggested_points: 710, actual_points: 710, sort_order: 1}
    _declare_role_figure(fp_s2f1,  1,  1, [ gil_galad ])
    _declare_role_figure(fp_s2f1,  1,  2, [ elrond ])
    _declare_role_figure(fp_s2f1, 10,  3, [ high_elf_w_blade ])
    _declare_role_figure(fp_s2f1, 10,  4, [ high_elf_w_bow ])
    _declare_role_figure(fp_s2f1,  9,  5, [ high_elf_w_spear_shield ])
    _declare_role_figure(fp_s2f1,  1,  6, [ high_elf_w_banner ])
    _declare_role_figure(fp_s2f1,  1,  7, [ elendil ])
    _declare_role_figure(fp_s2f1,  1,  8, [ isildur ])
    _declare_role_figure(fp_s2f1,  1,  9, "Numenor Captain with heavy armour and shield", [ numenor_captain ])
    _declare_role_figure(fp_s2f1,  7, 10, [ numenor_w_shield ])
    _declare_role_figure(fp_s2f1,  7, 11, [ numenor_w_bow ])
    _declare_role_figure(fp_s2f1,  6, 12, [ numenor_w_shield_spear ])
    _declare_role_figure(fp_s2f1,  1, 13, [ numenor_w_banner ])

    fp_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: fp_s2.id, faction: :barad_dur, suggested_points: 1575, actual_points: 1575, sort_order: 2}
    _declare_role_figure(fp_s2f2,  1,  1, [ sauron ])
    _declare_role_figure(fp_s2f2,  1,  2, "Witch-King of Angmar on horse (full M/W/F)", [ witch_king_horse ])
    _declare_role_figure(fp_s2f2,  2,  3, "Ringwraiths on horse (full M/W/F)", [ ringwraith_horse ])
    _declare_role_figure(fp_s2f2,  1,  4, [ troll_chieftain ])
    _declare_role_figure(fp_s2f2,  2,  5, [ orc_captain ])
    _declare_role_figure(fp_s2f2, 12,  6, [ orc_w_shield ])
    _declare_role_figure(fp_s2f2, 12,  7, [ orc_w_spear ])
    _declare_role_figure(fp_s2f2,  6,  8, [ orc_w_bow ])
    _declare_role_figure(fp_s2f2,  6,  9, [ orc_w_2h ])
    _declare_role_figure(fp_s2f2,  4, 10, [ warg_rider_bow ])
    _declare_role_figure(fp_s2f2,  4, 11, [ warg_rider_shield ])
    _declare_role_figure(fp_s2f2,  4, 12, [ warg_rider_shield_spear ])
    _declare_role_figure(fp_s2f2,  2, 13, [ mordor_troll ])

    #========================================================================
    fp_s3 = Repo.insert! %Scenario{
      name: "The East Gate",
      blurb: "Balin attempts to reclaim Moria from the Goblins.",
      date_age: 3, date_year: 2989, date_month: 0, date_day: 0, size: 40,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: fp_s3.id, resource_type: :source, book: :fp, title: "The Free Peoples", sort_order: 3, page: 59}

    fp_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: fp_s3.id, faction: :durins_folk, suggested_points: 200, actual_points: 0, sort_order: 1}
    _declare_role_figure(fp_s3f1,  1,  1, [ balin ])
    _declare_role_figure(fp_s3f1,  4,  2, [ dwarf_w_shield ])
    _declare_role_figure(fp_s3f1,  3,  3, [ dwarf_w_bow ])
    _declare_role_figure(fp_s3f1,  3,  4, [ dwarf_w_2h ])
    _declare_role_figure(fp_s3f1,  3,  5, [ dwarf_khazad_gd ])

    fp_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: fp_s3.id, faction: :moria, suggested_points: 200, actual_points: 0, sort_order: 2}
    _declare_role_figure(fp_s3f2,  2,  1, "Moria Captains with Shield", [ moria_captain ])
    _declare_role_figure(fp_s3f2,  8,  2, [ moria_g_shield ])
    _declare_role_figure(fp_s3f2,  8,  3, [ moria_g_spear ])
    _declare_role_figure(fp_s3f2,  8,  4, [ moria_g_bow ])

    #========================================================================
    fp_s4 = Repo.insert! %Scenario{
      name: "Attack on Weathertop",
      blurb: "The Ringwraiths attempt to wrest the One Ring from Frodo.",
      date_age: 3, date_year: 3018, date_month: 10, date_day: 6, size: 10,
      map_width: 48, map_height: 48, location: :weathertop
    }

    Repo.insert! %ScenarioResource{scenario_id: fp_s4.id, resource_type: :source, book: :fp, title: "The Free Peoples", sort_order: 4, page: 60}

    fp_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: fp_s4.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fp_s4f1,  1,  1, [ frodo ])
    _declare_role_figure(fp_s4f1,  1,  2, [ sam ])
    _declare_role_figure(fp_s4f1,  1,  3, [ merry ])
    _declare_role_figure(fp_s4f1,  1,  4, [ pippin ])
    _declare_role_figure(fp_s4f1,  1,  5, [ aragorn ])

    fp_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: fp_s4.id, faction: :nazgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fp_s4f2,  1,  1, [ witch_king ])
    _declare_role_figure(fp_s4f2,  4,  2, [ ringwraith ])

    #========================================================================
    fp_s5 = Repo.insert! %Scenario{
      name: "Flight to the Ford",
      blurb: "Can Frodo reach Rivendell before succumbing to the effects of the Morgul Blade?",
      date_age: 3, date_year: 3018, date_month: 10, date_day: 20, size: 16,
      map_width: 48, map_height: 48, location: :eriador
    }

    Repo.insert! %ScenarioResource{scenario_id: fp_s5.id, resource_type: :source, book: :fp, title: "The Free Peoples", sort_order: 5, page: 61}

    fp_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: fp_s5.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fp_s5f1,  1,  1, [ frodo ])
    _declare_role_figure(fp_s5f1,  1,  2, [ sam ])
    _declare_role_figure(fp_s5f1,  1,  3, [ merry ])
    _declare_role_figure(fp_s5f1,  1,  4, [ pippin ])
    _declare_role_figure(fp_s5f1,  1,  5, [ aragorn ])
    _declare_role_figure(fp_s5f1,  1,  6, [ aragorn ])
    _declare_role_figure(fp_s5f1,  1,  7, [ glorfindel_horse ])

    fp_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: fp_s5.id, faction: :nazgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fp_s5f2,  1,  1, [ witch_king_horse ])
    _declare_role_figure(fp_s5f2,  8,  2, [ ringwraith_horse ])

    #========================================================================
    fp_s6 = Repo.insert! %Scenario{
      name: "Amon Hen",
      blurb: "The Uruk-hai split the Fellowship and run off with some hobbits.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 26, size: 36,
      map_width: 72, map_height: 48, location: :amon_hen
    }

    Repo.insert! %ScenarioResource{scenario_id: fp_s6.id, resource_type: :source, book: :fp, title: "The Free Peoples", sort_order: 6, page: 62}
    _declare_video_replay(fp_s6.id, "https://www.youtube.com/watch?v=O0k7OAKAGms&index=5&list=PLojk5rjS_dLaLSaURnRx1NDBMXeB9lhc-", "Hot Gates Gaming", 1)

    fp_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: fp_s6.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fp_s6f1,  1,  1, "Aragorn with bow and Elven cloak", [ aragorn ])
    _declare_role_figure(fp_s6f1,  1,  2, "Boromir with Elven cloak", [ boromir ])
    _declare_role_figure(fp_s6f1,  1,  3, "Legolas with Elven cloak", [ legolas ])
    _declare_role_figure(fp_s6f1,  1,  4, "Gimli with Elven cloak", gimli_all_foot)
    _declare_role_figure(fp_s6f1,  1,  5, "Frodo with Elven cloak, mithril coat, and Sting", [ frodo ])
    _declare_role_figure(fp_s6f1,  1,  6, "Sam with Elven cloak", [ sam ])
    _declare_role_figure(fp_s6f1,  1,  7, "Merry with Elven cloak", [ merry ])
    _declare_role_figure(fp_s6f1,  1,  8, "Pippin with Elven cloak", [ pippin ])

    fp_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: fp_s6.id, faction: :isengard, suggested_points: 360, actual_points: 358, sort_order: 2}
    _declare_role_figure(fp_s6f2,  1,  1, [ lurtz ])
    _declare_role_figure(fp_s6f2, 13,  2, [ uruk_hai_s_sword_shield ])
    _declare_role_figure(fp_s6f2, 14,  3, [ uruk_hai_s_bow ])

    #========================================================================
    fp_s7 = Repo.insert! %Scenario{
      name: "The Last March of the Ents",
      blurb: "The Ents exact revenge for Saruman's treatment of the forest of Fangorn.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 56,
      map_width: 48, map_height: 24, location: :isengard
    }

    Repo.insert! %ScenarioResource{scenario_id: fp_s7.id, resource_type: :source, book: :fp, title: "The Free Peoples", sort_order: 7, page: 63}

    fp_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: fp_s7.id, faction: :wanderers, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fp_s7f1,  1,  1, [ treebeard ])
    _declare_role_figure(fp_s7f1,  3,  2, [ ent ])

    fp_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: fp_s7.id, faction: :isengard, suggested_points: 500, actual_points: 495, sort_order: 2}
    _declare_role_figure(fp_s7f2,  1,  1, [ uruk_hai_captain_shield ])
    _declare_role_figure(fp_s7f2,  1,  2, "Orc Captain with shield", [ orc_captain ])
    _declare_role_figure(fp_s7f2,  3,  3, [ uruk_hai_w_crossbow ])
    _declare_role_figure(fp_s7f2, 10,  4, [ uruk_hai_w_shield ])
    _declare_role_figure(fp_s7f2, 10,  5, [ uruk_hai_w_pike ])
    _declare_role_figure(fp_s7f2,  9,  6, [ orc_w_shield ])
    _declare_role_figure(fp_s7f2,  9,  7, [ orc_w_spear ])
    _declare_role_figure(fp_s7f2,  5,  8, [ orc_w_bow ])
    _declare_role_figure(fp_s7f2,  4,  9, [ orc_w_2h ])

    #########################################################################
    # GOBLINTOWN
    #########################################################################

    #========================================================================
    gt_s1 = Repo.insert! %Scenario{
      name: "Wizards in the Dark",
      blurb: "Gandalf and Radagast investigate Goblintown.",
      date_age: 3, date_year: 2938, date_month: 0, date_day: 0, size: 23,
      map_width: 48, map_height: 48, location: :goblintown
    }

    Repo.insert! %ScenarioResource{scenario_id: gt_s1.id, resource_type: :source, book: :gt, title: "Goblintown Starter Set", sort_order: 1, page: 0}
    _declare_podcast(gt_s1.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-4f-wizards-in-the-dark", "The Green Dragon", 1)
    _declare_video_replay(gt_s1.id, "https://www.youtube.com/watch?v=rdEcq_cMws0&index=36&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV", "Spillforeningen the Fellowship", 1)

    gt_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: gt_s1.id, faction: :white_council, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(gt_s1f1,  1,  1, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(gt_s1f1,  1,  2, "Radagast the Brown", [ radagast_goblintown, radagast_lotr, radagast_sebastian ])

    gt_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: gt_s1.id, faction: :goblintown, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(gt_s1f2,  1,  1, [ goblin_king ])
    _declare_role_figure(gt_s1f2, 20,  2, [ goblintown_g ])

    #========================================================================
    gt_s2 = Repo.insert! %Scenario{
      name: "The Breakthrough",
      blurb: "A few dwarves from Thorin's Company try to escape from Goblintown.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 17,
      map_width: 24, map_height: 24, location: :goblintown
    }

    Repo.insert! %ScenarioResource{scenario_id: gt_s2.id, resource_type: :source, book: :gt, title: "Goblintown Starter Set", sort_order: 2, page: 28}
    _declare_podcast(gt_s2.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-4a-the-breakthrough", "The Green Dragon", 1)
    _declare_video_replay(gt_s2.id, "https://www.youtube.com/watch?v=uW4hOlxrtig&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV&index=41", "Spillforeningen the Fellowship", 2)

    gt_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: gt_s2.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(gt_s2f1,  1,  1, [ fili ])
    _declare_role_figure(gt_s2f1,  1,  2, [ kili ])
    _declare_role_figure(gt_s2f1,  1,  3, [ oin ])
    _declare_role_figure(gt_s2f1,  1,  4, [ gloin ])

    gt_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: gt_s2.id, faction: :goblintown, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(gt_s2f2,  1,  1, [ goblintown_captain ])
    _declare_role_figure(gt_s2f2, 12,  2, [ goblintown_g ])

    #========================================================================
    gt_s3 = Repo.insert! %Scenario{
      name: "Rescue the Baggage",
      blurb: "A few dwarves from Thorin's Company try to recover their baggage and escape from Goblintown.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 16,
      map_width: 24, map_height: 24, location: :goblintown
    }

    Repo.insert! %ScenarioResource{scenario_id: gt_s3.id, resource_type: :source, book: :gt, title: "Goblintown Starter Set", sort_order: 3, page: 30}
    _declare_podcast(gt_s3.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-4b-rescue-the-baggage", "The Green Dragon", 1)
    _declare_video_replay(gt_s3.id, "https://www.youtube.com/watch?v=HbczOIRKY-I&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV&index=42", "Spillforeningen the Fellowship", 2)

    gt_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: gt_s3.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(gt_s3f1,  1,  1, [ bifur ])
    _declare_role_figure(gt_s3f1,  1,  2, [ bofur ])
    _declare_role_figure(gt_s3f1,  1,  3, [ bombur ])

    gt_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: gt_s3.id, faction: :goblintown, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(gt_s3f2,  1,  1, [ grinnah ])
    _declare_role_figure(gt_s3f2, 12,  2, [ goblintown_g ])

    #========================================================================
    gt_s4 = Repo.insert! %Scenario{
      name: "Brothers in Arms",
      blurb: "A few dwarves from Thorin's Company try to find their weapons and escape from Goblintown.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 16,
      map_width: 24, map_height: 24, location: :goblintown
    }

    Repo.insert! %ScenarioResource{scenario_id: gt_s4.id, resource_type: :source, book: :gt, title: "Goblintown Starter Set", sort_order: 4, page: 32}
    _declare_podcast(gt_s4.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-4c-brothers-in-arms", "The Green Dragon", 1)
    _declare_video_replay(gt_s4.id, "https://www.youtube.com/watch?v=ah0m1ldoPNI&t=464s&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV&index=43", "Spillforeningen the Fellowship", 2)

    gt_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: gt_s4.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(gt_s4f1,  1,  1, [ ori ])
    _declare_role_figure(gt_s4f1,  1,  2, [ nori ])
    _declare_role_figure(gt_s4f1,  1,  3, [ dori ])

    gt_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: gt_s4.id, faction: :goblintown, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(gt_s4f2,  1,  1, [ goblin_scribe ])
    _declare_role_figure(gt_s4f2, 12,  2, [ goblintown_g ])

    #========================================================================
    gt_s5 = Repo.insert! %Scenario{
      name: "Guard the Crossing",
      blurb: "The heavy hitters from Thorin's Company try prevent the goblins from escaping their own kingdom.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 16,
      map_width: 24, map_height: 24, location: :goblintown
    }

    Repo.insert! %ScenarioResource{scenario_id: gt_s5.id, resource_type: :source, book: :gt, title: "Goblintown Starter Set", sort_order: 5, page: 34}
    _declare_podcast(gt_s5.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-4d-guard-the-crossing", "The Green Dragon", 1)
    _declare_video_replay(gt_s5.id, "https://www.youtube.com/watch?v=9H2_pXdQAMU&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV&index=44", "Spillforeningen the Fellowship", 2)

    gt_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: gt_s5.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(gt_s5f1,  1,  1, [ thorin ])
    _declare_role_figure(gt_s5f1,  1,  2, [ balin ])
    _declare_role_figure(gt_s5f1,  1,  3, [ dwalin ])

    gt_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: gt_s5.id, faction: :goblintown, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(gt_s5f2,  1,  1, [ goblin_king ])
    _declare_role_figure(gt_s5f2, 12,  2, [ goblintown_g ])

    #========================================================================
    gt_s6 = Repo.insert! %Scenario{
      name: "The Wizard and the Burglar",
      blurb: "Gandalf tries to reach Bilbo in the depths of Goblintown.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 10,
      map_width: 24, map_height: 24, location: :goblintown
    }

    Repo.insert! %ScenarioResource{scenario_id: gt_s6.id, resource_type: :source, book: :gt, title: "Goblintown Starter Set", sort_order: 6, page: 36}
    _declare_podcast(gt_s6.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-4e-the-wizard-and-the-burglar", "The Green Dragon", 1)

    gt_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: gt_s6.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(gt_s6f1,  1,  1, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(gt_s6f1,  1,  2, [ young_bilbo ])

    gt_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: gt_s6.id, faction: :goblintown, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(gt_s6f2,  1,  1, [ goblin_king ])
    _declare_role_figure(gt_s6f2,  1,  2, [ grinnah ])
    _declare_role_figure(gt_s6f2,  6,  3, [ goblintown_g ])

    #########################################################################
    # GONDOR IN FLAMES
    #########################################################################

    #========================================================================
    gif_s1 = Repo.insert! %Scenario{
      name: "The Gladden Fields",
      blurb: "Isildur must escape from an Orcish ambush to keep the One Ring.",
      date_age: 3, date_year: 2, date_month: 0, date_day: 0, size: 121,
      map_width: 48, map_height: 24, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: gif_s1.id, resource_type: :source, book: :gif, title: "Gondor in Flames", sort_order: 1, page: 52}

    gif_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: gif_s1.id, faction: :numenor, suggested_points: 600, actual_points: 610, sort_order: 1}
    _declare_role_figure(gif_s1f1,  1, 1, [ isildur_horse ])
    _declare_role_figure(gif_s1f1,  3, 2, [ dunedain ])
    _declare_role_figure(gif_s1f1, 15, 3, [ numenor_w_shield ])
    _declare_role_figure(gif_s1f1, 15, 4, [ numenor_w_shield_spear ])
    _declare_role_figure(gif_s1f1,  9, 5, [ numenor_w_bow ])
    _declare_role_figure(gif_s1f1,  8, 6, [ ranger_north ])
    _declare_role_figure(gif_s1f1,  4, 7, [ ranger_north_spear ])

    gif_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: gif_s1.id, faction: :cirith_ungol, suggested_points: 900, actual_points: 0, sort_order: 2}
    _declare_role_figure(gif_s1f2,  2,  1, [ orc_captain ])
    _declare_role_figure(gif_s1f2,  2,  2, [ orc_shaman ])
    _declare_role_figure(gif_s1f2, 16,  3, [ orc_w_shield ])
    _declare_role_figure(gif_s1f2, 16,  4, [ orc_w_spear ])
    _declare_role_figure(gif_s1f2,  8,  5, [ orc_w_2h ])
    _declare_role_figure(gif_s1f2,  8,  6, [ orc_w_bow ])
    _declare_role_figure(gif_s1f2,  2,  7, [ orc_w_banner ])
    _declare_role_figure(gif_s1f2,  9,  8, [ morgul_stalker ])
    _declare_role_figure(gif_s1f2,  9,  9, [ orc_tracker ])
    _declare_role_figure(gif_s1f2, 12, 10, [ warg ])
    _declare_role_figure(gif_s1f2,  4, 11, [ warg_rider_shield ])
    _declare_role_figure(gif_s1f2,  4, 12, [ warg_rider_bow ])
    _declare_role_figure(gif_s1f2,  4, 13, [ warg_rider_spear ])

    #========================================================================
    gif_s2 = Repo.insert! %Scenario{
      name: "The Fall of Minas Ithil",
      blurb: "The Nazgûl use their terrifying powers to conquer Minas Ithil (Tower of the Moon) and turn it into Minas Morgul (Tower of Black Sorcery).",
      date_age: 3, date_year: 2002, date_month: 0, date_day: 0, size: 67,
      map_width: 48, map_height: 24, location: :minas_morgul
    }

    Repo.insert! %ScenarioResource{scenario_id: gif_s2.id, resource_type: :source, book: :gif, title: "Gondor in Flames", sort_order: 2, page: 54}
    _declare_video_replay(gif_s2.id, "https://www.youtube.com/watch?v=W99MecKpiTU&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV&index=2", "Spillforeningen the Fellowship", 1)

    gif_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: gif_s2.id, faction: :minas_tirith, suggested_points: 750, actual_points: 0, sort_order: 1}
    _declare_role_figure(gif_s2f1, 1,  1, [ king_of_men ])
    _declare_role_figure(gif_s2f1, 1,  2, [ gondor_captain_mt ])
    _declare_role_figure(gif_s2f1, 8,  3, [ gondor_womt_shield ])
    _declare_role_figure(gif_s2f1, 8,  4, [ gondor_womt_spear_shield ])
    _declare_role_figure(gif_s2f1, 8,  5, [ gondor_womt_bow ])
    _declare_role_figure(gif_s2f1, 1,  6, [ gondor_womt_banner ])
    _declare_role_figure(gif_s2f1, 3,  7, [ fountain_court_gd ])
    _declare_role_figure(gif_s2f1, 8,  8, [ gondor_rog ])
    _declare_role_figure(gif_s2f1, 4,  9, [ gondor_rog_spear ])
    _declare_role_figure(gif_s2f1, 1, 10, [ trebuchet ])
    _declare_role_figure(gif_s2f1, 3, 11, [ trebuchet_crew ])

    gif_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: gif_s2.id, faction: :nazgul, suggested_points: 1050, actual_points: 0, sort_order: 2}
    _declare_role_figure(gif_s2f2, 1,  1, [ witch_king_flail ])
    _declare_role_figure(gif_s2f2, 1,  2, [ khamul ])
    _declare_role_figure(gif_s2f2, 7,  3, [ ringwraith ])

    #========================================================================
    gif_s3 = Repo.insert! %Scenario{
      name: "Osgiliath",
      blurb: "Sauron probes Osgiliath, defended by the cream of Gondorian leadership.",
      date_age: 3, date_year: 3018, date_month: 6, date_day: 20, size: 117,
      map_width: 48, map_height: 48, location: :osgiliath
    }

    Repo.insert! %ScenarioResource{scenario_id: gif_s3.id, resource_type: :source, book: :gif, title: "Gondor in Flames", sort_order: 3, page: 56}

    gif_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: gif_s3.id, faction: :minas_tirith, suggested_points: 1000, actual_points: 0, sort_order: 1}
    _declare_role_figure(gif_s3f1,  1,  1, [ boromir_wt_banner ])
    _declare_role_figure(gif_s3f1,  1,  2, [ faramir ])
    _declare_role_figure(gif_s3f1,  1,  3, [ madril ])
    _declare_role_figure(gif_s3f1,  1,  4, [ damrod ])
    _declare_role_figure(gif_s3f1,  2,  5, [ gondor_captain_mt ])
    _declare_role_figure(gif_s3f1,  8,  6, [ gondor_womt_shield ])
    _declare_role_figure(gif_s3f1,  8,  7, [ gondor_womt_spear_shield ])
    _declare_role_figure(gif_s3f1,  8,  8, [ gondor_womt_bow ])
    _declare_role_figure(gif_s3f1,  2,  9, [ gondor_womt_banner ])
    _declare_role_figure(gif_s3f1,  4, 10, [ osgiliath_v_shield ])
    _declare_role_figure(gif_s3f1,  4, 11, [ osgiliath_v_spear ])
    _declare_role_figure(gif_s3f1,  4, 12, [ osgiliath_v_bow ])
    _declare_role_figure(gif_s3f1, 10, 13, "Knights of Minas Tirith with shield", [ gondor_knight ])

    gif_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: gif_s3.id, faction: :minas_morgul, suggested_points: 1000, actual_points: 0, sort_order: 2}
    _declare_role_figure(gif_s3f2,  1,  1, [ gothmog ])
    _declare_role_figure(gif_s3f2,  2,  2, [ orc_captain ])
    _declare_role_figure(gif_s3f2,  6,  3, [ orc_tracker ])
    _declare_role_figure(gif_s3f2,  8,  4, [ orc_m_shield_spear ])
    _declare_role_figure(gif_s3f2,  8,  5, [ orc_m_spear ])
    _declare_role_figure(gif_s3f2,  8,  6, [ orc_m_shield ])
    _declare_role_figure(gif_s3f2,  8,  7, [ orc_w_shield ])
    _declare_role_figure(gif_s3f2,  8,  8, [ orc_w_spear ])
    _declare_role_figure(gif_s3f2,  4,  9, [ orc_w_bow ])
    _declare_role_figure(gif_s3f2,  4, 10, [ orc_w_2h ])
    _declare_role_figure(gif_s3f2,  2, 11, [ orc_w_banner ])
    _declare_role_figure(gif_s3f2,  2, 11, [ mordor_troll ])
    _declare_role_figure(gif_s3f2,  3, 12, [ morgul_stalker ])
    _declare_role_figure(gif_s3f2,  6, 13, [ m_uruk_hai_shield ])
    _declare_role_figure(gif_s3f2,  3, 14, [ m_uruk_hai_2h ])

    #========================================================================
    gif_s4 = Repo.insert! %Scenario{
      name: "Against the Southron Horde",
      blurb: "Boromir leads a charge of knights on a ride through a Haradrim camp.",
      date_age: 3, date_year: 3001, date_month: 0, date_day: 0, size: 97,
      map_width: 72, map_height: 24, location: :harad
    }

    Repo.insert! %ScenarioResource{scenario_id: gif_s4.id, resource_type: :source, book: :gif, title: "Gondor in Flames", sort_order: 4, page: 58}
    _declare_podcast(gif_s4.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-12-against-the-southron-horde", "The Green Dragon", 1)

    gif_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: gif_s4.id, faction: :minas_tirith, suggested_points: 600, actual_points: 0, sort_order: 1}
    _declare_role_figure(gif_s4f1,  1,  1, "Boromir, Captain of the White Tower on horse with lance and shield", [ boromir_wt_horse ])
    _declare_role_figure(gif_s4f1,  1,  2, "Captain of Minas Tirith on horse with lance and shield", [ gondor_captain_mt_horse ])
    _declare_role_figure(gif_s4f1, 22,  3, [ gondor_knight_shield  ])
    _declare_role_figure(gif_s4f1,  1,  4, [ gondor_knight_banner ])

    gif_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: gif_s4.id, faction: :harad, suggested_points: 700, actual_points: 0, sort_order: 2}
    _declare_role_figure(gif_s4f2,  1,  1, [ harad_king_horse ])
    _declare_role_figure(gif_s4f2,  1,  2, [ hasharin ])
    _declare_role_figure(gif_s4f2,  6,  3, [ serpent_rider ])
    _declare_role_figure(gif_s4f2, 12,  4, [ serpent_gd ])
    _declare_role_figure(gif_s4f2,  6,  5, [ harad_raider ])
    _declare_role_figure(gif_s4f2,  6,  6, [ harad_raider_lance ])
    _declare_role_figure(gif_s4f2, 18,  7, [ harad_w_bow ])
    _declare_role_figure(gif_s4f2, 18,  8, [ harad_w_spear ])
    _declare_role_figure(gif_s4f2,  1,  9, [ harad_w_banner ])

    #========================================================================
    gif_s5 = Repo.insert! %Scenario{
      name: "The Battle for Pelargir",
      blurb: "Aragorn and his Grey Company assault the Corsairs of Umbar.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 19, size: 100,
      map_width: 48, map_height: 24, location: :gondor
    }

    Repo.insert! %ScenarioResource{scenario_id: gif_s5.id, resource_type: :source, book: :gif, title: "Gondor in Flames", sort_order: 4, page: 60}

    gif_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: gif_s5.id, faction: :fiefdoms, suggested_points: 1050, actual_points: 0, sort_order: 1}
    _declare_role_figure(gif_s5f1,  1,  1, "Aragorn with Anduril", [ aragorn ])
    _declare_role_figure(gif_s5f1,  1,  2, [ legolas ])
    _declare_role_figure(gif_s5f1,  1,  3, "Gimli", gimli_all_foot)
    _declare_role_figure(gif_s5f1,  1,  4, [ angbor ])
    _declare_role_figure(gif_s5f1,  1,  5, [ king_dead ])
    _declare_role_figure(gif_s5f1,  1,  6, [ gondor_captain_da ])
    _declare_role_figure(gif_s5f1,  6,  7, [ gondor_rog ])
    _declare_role_figure(gif_s5f1,  3,  8, [ gondor_knight_da_foot ])
    _declare_role_figure(gif_s5f1,  6,  9, [ clansmen_lamedon ])
    _declare_role_figure(gif_s5f1,  6, 10, [ maa_da ])
    _declare_role_figure(gif_s5f1,  6, 11, [ axemen_lossarnach ])
    _declare_role_figure(gif_s5f1,  6, 12, [ dead_w ])
    _declare_role_figure(gif_s5f1,  3, 13, [ dead_rider ])

    gif_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: gif_s5.id, faction: :harad, suggested_points: 790, actual_points: 0, sort_order: 2}
    _declare_role_figure(gif_s5f2,  2,  1, [ hasharin ])
    _declare_role_figure(gif_s5f2, 18,  2, [ harad_w_bow ])
    _declare_role_figure(gif_s5f2, 18,  3, [ harad_w_spear ])
    _declare_role_figure(gif_s5f2,  1,  4, [ harad_w_banner ])
    _declare_role_figure(gif_s5f2,  8,  5, [ orc_w_spear ])
    _declare_role_figure(gif_s5f2,  8,  6, [ orc_w_shield ])
    _declare_role_figure(gif_s5f2,  4,  7, [ orc_w_2h ])
    _declare_role_figure(gif_s5f2,  4,  8, [ orc_w_bow ])
    _declare_role_figure(gif_s5f2,  5,  9, "Mordor Uruk-hai", [ m_uruk_hai_shield, m_uruk_hai_2h ])
    _declare_role_figure(gif_s5f2,  1, 10, [ mordor_troll ])

    #########################################################################
    # HARAD
    #########################################################################

    #========================================================================
    harad_s1 = Repo.insert! %Scenario{
      name: "The Battle of Kârna",
      blurb: "Gondor tries to reassert control over the city of Kârna.",
      date_age: 3, date_year: 1050, date_month: 0, date_day: 0, size: 50,
      map_width: 24, map_height: 24, location: :harad
    }

    Repo.insert! %ScenarioResource{scenario_id: harad_s1.id, resource_type: :source, book: :harad, title: "Harad", sort_order: 1, page: 50}

    harad_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: harad_s1.id, faction: :minas_tirith, suggested_points: 250, actual_points: 0, sort_order: 1}
    _declare_role_figure(harad_s1f1, 1,  1, [ gondor_captain_mt ])
    _declare_role_figure(harad_s1f1, 4,  2, [ gondor_womt_shield ])
    _declare_role_figure(harad_s1f1, 4,  3, [ gondor_womt_bow ])
    _declare_role_figure(harad_s1f1, 8,  4, [ gondor_womt_spear_shield ])
    _declare_role_figure(harad_s1f1, 8,  5, [ gondor_rog ])

    harad_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: harad_s1.id, faction: :harad, suggested_points: 200, actual_points: 0, sort_order: 2}
    _declare_role_figure(harad_s1f2,  1,  1, "Haradrim Chieftain with bow and spear", [ harad_chieftain ])
    _declare_role_figure(harad_s1f2, 12,  2, [ harad_w_spear ])
    _declare_role_figure(harad_s1f2, 12,  3, [ harad_w_bow ])

    #========================================================================
    harad_s2 = Repo.insert! %Scenario{
      name: "The Spoils of War",
      blurb: "Gondor heroic questers try to escape with treasures from the now-haunted city of Kârna.",
      date_age: 3, date_year: 1071, date_month: 0, date_day: 0, size: 37,
      map_width: 48, map_height: 48, location: :harad
    }

    Repo.insert! %ScenarioResource{scenario_id: harad_s2.id, resource_type: :source, book: :harad, title: "Harad", sort_order: 2, page: 52}

    harad_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: harad_s2.id, faction: :minas_tirith, suggested_points: 300, actual_points: 0, sort_order: 1}
    _declare_role_figure(harad_s2f1, 1,  1, [ king_of_men ])
    _declare_role_figure(harad_s2f1, 2,  2, [ gondor_captain_mt ])
    _declare_role_figure(harad_s2f1, 2,  3, [ gondor_captain_da ])

    harad_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: harad_s2.id, faction: :harad, suggested_points: 500, actual_points: 0, sort_order: 2}
    _declare_role_figure(harad_s2f2,  1,  1, "Mahûd Tribesmaster with blowpipe and shield", [ mahud_tribesmaster ])
    _declare_role_figure(harad_s2f2,  6,  2, [ mahud_w_spear ])
    _declare_role_figure(harad_s2f2,  3,  3, [ mahud_w_blowpipe ])
    _declare_role_figure(harad_s2f2,  1,  4, [ half_troll ])
    _declare_role_figure(harad_s2f2, 12,  5, [ watcher_karna ])
    _declare_role_figure(harad_s2f2,  1,  6, [ barrow_wight ])
    _declare_role_figure(harad_s2f2,  2,  7, [ spectre ])
    _declare_role_figure(harad_s2f2,  6,  8, [ dead_w ])

    #========================================================================
    harad_s3 = Repo.insert! %Scenario{
      name: "Uprising!",
      blurb: "The Southrons drive the Gondorians out of Umbar.",
      date_age: 3, date_year: 2954, date_month: 0, date_day: 0, size: 63,
      map_width: 48, map_height: 48, location: :harad
    }

    Repo.insert! %ScenarioResource{scenario_id: harad_s3.id, resource_type: :source, book: :harad, title: "Harad", sort_order: 3, page: 54}

    harad_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: harad_s3.id, faction: :minas_tirith, suggested_points: 550, actual_points: 0, sort_order: 1}
    _declare_role_figure(harad_s3f1, 1, 1, [ king_of_men ])
    _declare_role_figure(harad_s3f1, 2, 2, [ gondor_captain_mt ])
    _declare_role_figure(harad_s3f1, 9, 3, "Citadel Guard", [ gondor_citadel_gd_spear, gondor_citadel_gd_bow ])
    _declare_role_figure(harad_s3f1, 8, 4, [ gondor_womt_shield ])
    _declare_role_figure(harad_s3f1, 8, 5, [ gondor_womt_spear_shield ])
    _declare_role_figure(harad_s3f1, 8, 6, [ gondor_womt_bow ])

    harad_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: harad_s3.id, faction: :harad, suggested_points: 450, actual_points: 0, sort_order: 2}
    _declare_role_figure(harad_s3f2,  3, 1, [ hasharin ])
    _declare_role_figure(harad_s3f2, 12, 2, [ harad_w_spear ])
    _declare_role_figure(harad_s3f2, 12, 3, [ harad_w_bow ])

    #========================================================================
    harad_s4 = Repo.insert! %Scenario{
      name: "Raid on Anfalas",
      blurb: "Corsairs of Umbar raid Gondor's southern coast, where they are intercepted by Boromir with some local troops.",
      date_age: 3, date_year: 3008, date_month: 0, date_day: 0, size: 63,
      map_width: 24, map_height: 24, location: :gondor
    }

    Repo.insert! %ScenarioResource{scenario_id: harad_s4.id, resource_type: :source, book: :harad, title: "Harad", sort_order: 4, page: 56}

    harad_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: harad_s4.id, faction: :minas_tirith, suggested_points: 625, actual_points: 0, sort_order: 1}
    _declare_role_figure(harad_s4f1,  1, 1, "Boromir, Captain of the White Tower on horse with shield and lance", [ boromir_wt_horse ])
    _declare_role_figure(harad_s4f1,  1, 2, [ gondor_captain_da ])
    _declare_role_figure(harad_s4f1,  6, 3, [ gondor_knight_shield ])
    _declare_role_figure(harad_s4f1,  3, 4, [ gondor_knight_da_foot ])
    _declare_role_figure(harad_s4f1,  1, 5, [ gondor_knight_da_foot_banner ])
    _declare_role_figure(harad_s4f1,  8, 6, [ gondor_rog ])
    _declare_role_figure(harad_s4f1,  4, 7, [ gondor_rog_spear ])
    _declare_role_figure(harad_s4f1, 12, 8, [ clansmen_lamedon ])

    harad_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: harad_s4.id, faction: :harad, suggested_points: 650, actual_points: 0, sort_order: 2}
    _declare_role_figure(harad_s4f2, 1, 1, [ dalamyr ])
    _declare_role_figure(harad_s4f2, 1, 2, [ hasharin ])
    _declare_role_figure(harad_s4f2, 1, 3, [ corsair_captain ])
    _declare_role_figure(harad_s4f2, 1, 4, [ corsair_bosun ])
    _declare_role_figure(harad_s4f2, 8, 5, [ corsair_w_shield ])
    _declare_role_figure(harad_s4f2, 8, 6, [ corsair_w_bow ])
    _declare_role_figure(harad_s4f2, 8, 7, [ corsair_w_spear ])
    _declare_role_figure(harad_s4f2, 9, 8, [ corsair_reaver ])
    _declare_role_figure(harad_s4f2, 6, 9, [ corsair_arbalester ])

    #========================================================================
    harad_s5 = Repo.insert! %Scenario{
      name: "Assault on Glamorgath",
      blurb: "Prince Imrahil fights a delaying action against a Mûmak.",
      date_age: 3, date_year: 3017, date_month: 0, date_day: 0, size: 115,
      map_width: 48, map_height: 24, location: :harondor
    }

    Repo.insert! %ScenarioResource{scenario_id: harad_s5.id, resource_type: :source, book: :harad, title: "Harad", sort_order: 4, page: 58}

    harad_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: harad_s5.id, faction: :fiefdoms, suggested_points: 650, actual_points: 0, sort_order: 1}
    _declare_role_figure(harad_s5f1,  1, 1, [ imrahil ])
    _declare_role_figure(harad_s5f1,  1, 2, [ gondor_captain_da ])
    _declare_role_figure(harad_s5f1, 18, 3, [ maa_da ])
    _declare_role_figure(harad_s5f1, 12, 4, [ gondor_knight_da_foot ])
    _declare_role_figure(harad_s5f1, 12, 5, [ clansmen_lamedon ])
    _declare_role_figure(harad_s5f1,  8, 6, [ gondor_rog ])
    _declare_role_figure(harad_s5f1,  4, 7, [ gondor_rog_spear ])

    harad_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: harad_s5.id, faction: :harad, suggested_points: 900, actual_points: 0, sort_order: 2}
    _declare_role_figure(harad_s5f2,  1,  1, [ suladan_horse ])
    _declare_role_figure(harad_s5f2,  1,  2, [ harad_chieftain ])
    _declare_role_figure(harad_s5f2,  1,  3, [ mumak ])
    _declare_role_figure(harad_s5f2, 12,  4, [ harad_w_spear ])
    _declare_role_figure(harad_s5f2, 12,  5, [ harad_w_bow ])
    _declare_role_figure(harad_s5f2,  6,  6, [ watcher_karna ])
    _declare_role_figure(harad_s5f2,  6,  7, [ serpent_gd ])
    _declare_role_figure(harad_s5f2,  8,  8, [ harad_raider ])
    _declare_role_figure(harad_s5f2,  4,  9, [ harad_raider_lance ])
    _declare_role_figure(harad_s5f2,  8, 10, [ serpent_rider ])

    #========================================================================
    harad_s6 = Repo.insert! %Scenario{
      name: "The Great Army of Harad",
      blurb: "What if Boromir had lead the army of Gondor against Suladân's hordes?",
      date_age: 3, date_year: 3018, date_month: 0, date_day: 0, size: 237,
      map_width: 72, map_height: 48, location: :harad
    }

    Repo.insert! %ScenarioResource{scenario_id: harad_s6.id, resource_type: :source, book: :harad, title: "Harad", sort_order: 4, page: 60}

    harad_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: harad_s6.id, faction: :minas_tirith, suggested_points: 2000, actual_points: 0, sort_order: 1}
    _declare_role_figure(harad_s6f1,  1,  1, [ boromir_wt_horse ])
    _declare_role_figure(harad_s6f1,  1,  2, [ imrahil_horse ])
    _declare_role_figure(harad_s6f1,  1,  3, [ faramir ])
    _declare_role_figure(harad_s6f1,  1,  4, [ gondor_captain_mt ])
    _declare_role_figure(harad_s6f1,  1,  5, [ madril ])
    _declare_role_figure(harad_s6f1,  1,  6, [ cirion ])
    _declare_role_figure(harad_s6f1,  1,  7, [ damrod ])
    _declare_role_figure(harad_s6f1,  1,  8, [ angbor ])
    _declare_role_figure(harad_s6f1,  1,  9, [ forlong ])
    _declare_role_figure(harad_s6f1, 12, 10, [ gondor_womt_shield ])
    _declare_role_figure(harad_s6f1, 12, 11, [ gondor_womt_spear_shield ])
    _declare_role_figure(harad_s6f1, 12, 12, [ gondor_womt_bow ])
    _declare_role_figure(harad_s6f1,  1, 13, [ gondor_womt_banner ])
    _declare_role_figure(harad_s6f1, 11, 14, [ gondor_knight_shield ])
    _declare_role_figure(harad_s6f1,  1, 15, [ gondor_knight_banner ])
    _declare_role_figure(harad_s6f1,  8, 16, [ gondor_rog ])
    _declare_role_figure(harad_s6f1,  4, 17, [ gondor_rog_spear ])
    _declare_role_figure(harad_s6f1,  7, 18, [ fountain_court_gd ])
    _declare_role_figure(harad_s6f1, 21, 19, [ maa_da ])
    _declare_role_figure(harad_s6f1, 12, 20, [ axemen_lossarnach ])
    _declare_role_figure(harad_s6f1, 12, 21, [ clansmen_lamedon ])
    _declare_role_figure(harad_s6f1,  6, 22, "Knights of Dol Amroth with lance and armoured horse", [ gondor_knight_da_horse ])
    _declare_role_figure(harad_s6f1, 12, 23, "Knights of Dol Amroth with lance and armoured horse", [ gondor_knight_da_horse ])

    harad_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: harad_s6.id, faction: :harad, suggested_points: 2000, actual_points: 0, sort_order: 2}
    _declare_role_figure(harad_s6f2,  1,  1, [ suladan_horse ])
    _declare_role_figure(harad_s6f2,  1,  2, [ dalamyr ])
    _declare_role_figure(harad_s6f2,  3,  3, [ hasharin ])
    _declare_role_figure(harad_s6f2,  1,  4, [ harad_chieftain ])
    _declare_role_figure(harad_s6f2,  1,  5, [ mahud_tribesmaster ])
    _declare_role_figure(harad_s6f2,  1,  6, [ corsair_captain ])
    _declare_role_figure(harad_s6f2,  1,  7, [ corsair_bosun ])
    _declare_role_figure(harad_s6f2, 12,  8, [ harad_w_spear ])
    _declare_role_figure(harad_s6f2, 12,  9, [ harad_w_bow ])
    _declare_role_figure(harad_s6f2,  1, 10, "War Mûmak of Harad", [ mumak ])
    _declare_role_figure(harad_s6f2,  6, 11, [ serpent_rider ])
    _declare_role_figure(harad_s6f2,  9, 12, [ serpent_gd ])
    _declare_role_figure(harad_s6f2,  9, 13, [ watcher_karna ])
    _declare_role_figure(harad_s6f2,  6, 14, [ harad_raider ])
    _declare_role_figure(harad_s6f2,  6, 15, [ harad_raider_lance ])
    _declare_role_figure(harad_s6f2,  6, 16, [ mahud_w_blowpipe ])
    _declare_role_figure(harad_s6f2,  6, 17, [ mahud_w_spear ])
    _declare_role_figure(harad_s6f2,  1, 18, "War Mûmak of Far Harad", [ mumak ])
    _declare_role_figure(harad_s6f2,  2, 19, [ half_troll ])
    _declare_role_figure(harad_s6f2,  1, 20, [ half_troll_2h ])
    _declare_role_figure(harad_s6f2,  4, 21, [ corsair_w_shield ])
    _declare_role_figure(harad_s6f2,  4, 22, [ corsair_w_spear ])
    _declare_role_figure(harad_s6f2,  4, 23, [ corsair_w_bow ])
    _declare_role_figure(harad_s6f2,  3, 24, [ corsair_reaver ])
    _declare_role_figure(harad_s6f2,  6, 25, [ corsair_arbalester ])

    #########################################################################
    # THE HOBBIT: AN UNEXPECTED JOURNEY
    #########################################################################

    #========================================================================
    hobbit_s1 = Repo.insert! %Scenario{
      name: "Roast Mutton",
      blurb: "Thorin's Company runs into some hungry Trolls on the Ettenmoors.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 17,
      map_width: 48, map_height: 48, location: :eriador
    }

    Repo.insert! %ScenarioResource{scenario_id: hobbit_s1.id, resource_type: :source, book: :hobbit, title: "The Hobbit", sort_order: 1, page: 112}
    _declare_video_replay(hobbit_s1.id, "https://www.youtube.com/watch?v=lwc1bqolr7g", "Spillforeningen the Fellowship", 1)
    _declare_video_replay(hobbit_s1.id, "https://www.youtube.com/watch?v=qo23ETd11oI&list=PLeIywh8H3Kc7fiaGLheYUBXCfAaqzMvvw&index=1&t=7s", "DCHL", 2)
    _declare_video_replay(hobbit_s1.id, "https://www.youtube.com/watch?v=6v-1Wmu-9k4&list=PLa_Dq2-Vx86Ju52qrkmvTbfsT3x4g1Or8&index=3", "Mid-Sussex Wargamers", 3)
    _declare_web_replay(hobbit_s1.id, "http://davetownsend.org/Battles/LotR-20160528/", "DaveT", 4)

    hobbit_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s1.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(hobbit_s1f1, 1,  1, [ thorin ])
    _declare_role_figure(hobbit_s1f1, 1,  2, [ balin ])
    _declare_role_figure(hobbit_s1f1, 1,  3, [ dwalin ])
    _declare_role_figure(hobbit_s1f1, 1,  4, [ fili ])
    _declare_role_figure(hobbit_s1f1, 1,  5, [ kili ])
    _declare_role_figure(hobbit_s1f1, 1,  6, [ oin ])
    _declare_role_figure(hobbit_s1f1, 1,  7, [ gloin ])
    _declare_role_figure(hobbit_s1f1, 1,  8, [ ori ])
    _declare_role_figure(hobbit_s1f1, 1,  9, [ nori ])
    _declare_role_figure(hobbit_s1f1, 1, 10, [ dori ])
    _declare_role_figure(hobbit_s1f1, 1, 11, [ bifur ])
    _declare_role_figure(hobbit_s1f1, 1, 12, [ bofur ])
    _declare_role_figure(hobbit_s1f1, 1, 13, [ bombur ])
    _declare_role_figure(hobbit_s1f1, 1, 14, [ young_bilbo ])

    hobbit_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s1.id, faction: :trolls, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(hobbit_s1f2, 1,  1, [ william ])
    _declare_role_figure(hobbit_s1f2, 1,  2, [ tom ])
    _declare_role_figure(hobbit_s1f2, 1,  3, [ bert ])

    #========================================================================
    hobbit_s2 = Repo.insert! %Scenario{
      name: "The Chase",
      blurb: "Radagast attempts to lead Azog's hunters on a wild rabbit chase.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 31,
      map_width: 48, map_height: 48, location: :eriador
    }

    Repo.insert! %ScenarioResource{scenario_id: hobbit_s2.id, resource_type: :source, book: :hobbit, title: "The Hobbit", sort_order: 2, page: 114}
    _declare_video_replay(hobbit_s2.id, "https://www.youtube.com/watch?v=ek6FHqDp2-w", "Spillforeningen the Fellowship", 1)
    _declare_video_replay(hobbit_s2.id, "https://www.youtube.com/watch?v=DE8qtshNA7I&list=PLeIywh8H3Kc7fiaGLheYUBXCfAaqzMvvw&index=2", "DCHL", 2)
    _declare_video_replay(hobbit_s2.id, "https://www.youtube.com/watch?v=80ZREBebyYw&index=2&list=PLa_Dq2-Vx86Ju52qrkmvTbfsT3x4g1Or8", "Mid-Sussex Wargamers", 3)

    hobbit_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s2.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(hobbit_s2f1, 1,  1, [ thorin ])
    _declare_role_figure(hobbit_s2f1, 1,  2, [ balin ])
    _declare_role_figure(hobbit_s2f1, 1,  3, [ dwalin ])
    _declare_role_figure(hobbit_s2f1, 1,  4, [ fili ])
    _declare_role_figure(hobbit_s2f1, 1,  5, [ kili ])
    _declare_role_figure(hobbit_s2f1, 1,  6, [ oin ])
    _declare_role_figure(hobbit_s2f1, 1,  7, [ gloin ])
    _declare_role_figure(hobbit_s2f1, 1,  8, [ ori ])
    _declare_role_figure(hobbit_s2f1, 1,  9, [ nori ])
    _declare_role_figure(hobbit_s2f1, 1, 10, [ dori ])
    _declare_role_figure(hobbit_s2f1, 1, 11, [ bifur ])
    _declare_role_figure(hobbit_s2f1, 1, 12, [ bofur ])
    _declare_role_figure(hobbit_s2f1, 1, 13, [ bombur ])
    _declare_role_figure(hobbit_s2f1, 1, 14, [ young_bilbo ])
    _declare_role_figure(hobbit_s2f1, 1, 15, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(hobbit_s2f1, 1, 16, [ radagast_sleigh ])

    hobbit_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s2.id, faction: :azogs_hunters, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(hobbit_s2f2,  1, 1, [ azog_warg ])
    _declare_role_figure(hobbit_s2f2,  1, 2, [ fimbul_warg ])
    _declare_role_figure(hobbit_s2f2,  1, 3, [ narzug_warg ])
    _declare_role_figure(hobbit_s2f2, 12, 4, [ hunter_orc_warg ])

    #========================================================================
    hobbit_s3 = Repo.insert! %Scenario{
      name: "The Capture",
      blurb: "Thorin's company's camping spot turns out to be swarming with Goblins.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 45,
      map_width: 48, map_height: 48, location: :eriador
    }

    Repo.insert! %ScenarioResource{scenario_id: hobbit_s3.id, resource_type: :source, book: :hobbit, title: "The Hobbit", sort_order: 3, page: 116}
    _declare_video_replay(hobbit_s3.id, "https://www.youtube.com/watch?v=PahHhcXCNPY", "Spillforeningen the Fellowship", 1)
    _declare_video_replay(hobbit_s3.id, "https://www.youtube.com/watch?v=mn7yH5lXXMg&list=PLeIywh8H3Kc7fiaGLheYUBXCfAaqzMvvw&index=3", "DCHL", 2)
    _declare_video_replay(hobbit_s3.id, "https://www.youtube.com/watch?v=UCzV27PopK0&list=PLa_Dq2-Vx86Ju52qrkmvTbfsT3x4g1Or8", "Mid-Sussex Wargamers", 3)

    hobbit_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s3.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(hobbit_s3f1, 1,  1, [ thorin ])
    _declare_role_figure(hobbit_s3f1, 1,  2, [ balin ])
    _declare_role_figure(hobbit_s3f1, 1,  3, [ dwalin ])
    _declare_role_figure(hobbit_s3f1, 1,  4, [ fili ])
    _declare_role_figure(hobbit_s3f1, 1,  5, [ kili ])
    _declare_role_figure(hobbit_s3f1, 1,  6, [ oin ])
    _declare_role_figure(hobbit_s3f1, 1,  7, [ gloin ])
    _declare_role_figure(hobbit_s3f1, 1,  8, [ ori ])
    _declare_role_figure(hobbit_s3f1, 1,  9, [ nori ])
    _declare_role_figure(hobbit_s3f1, 1, 10, [ dori ])
    _declare_role_figure(hobbit_s3f1, 1, 11, [ bifur ])
    _declare_role_figure(hobbit_s3f1, 1, 12, [ bofur ])
    _declare_role_figure(hobbit_s3f1, 1, 13, [ bombur ])
    _declare_role_figure(hobbit_s3f1, 1, 14, [ young_bilbo ])
    _declare_role_figure(hobbit_s3f1, 1, 15, "Gandalf the Grey", gandalf_grey_foot_all)

    hobbit_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s3.id, faction: :goblintown, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(hobbit_s3f2, 30, 1, [ goblintown_g ])

    #========================================================================
    hobbit_s4 = Repo.insert! %Scenario{
      name: "Flight to Freedom",
      blurb: "With the help of Gandalf, Thorin's company escapes the clutches of the Goblin King.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 53,
      map_width: 48, map_height: 48, location: :goblintown
    }

    Repo.insert! %ScenarioResource{scenario_id: hobbit_s4.id, resource_type: :source, book: :hobbit, title: "The Hobbit", sort_order: 4, page: 118}
    _declare_video_replay(hobbit_s4.id, "https://www.youtube.com/watch?v=zg7MijSVBes&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV&index=45", "Spillforeningen the Fellowship", 1)

    hobbit_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s4.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(hobbit_s4f1, 1,  1, [ thorin ])
    _declare_role_figure(hobbit_s4f1, 1,  2, [ balin ])
    _declare_role_figure(hobbit_s4f1, 1,  3, [ dwalin ])
    _declare_role_figure(hobbit_s4f1, 1,  4, [ fili ])
    _declare_role_figure(hobbit_s4f1, 1,  5, [ kili ])
    _declare_role_figure(hobbit_s4f1, 1,  6, [ oin ])
    _declare_role_figure(hobbit_s4f1, 1,  7, [ gloin ])
    _declare_role_figure(hobbit_s4f1, 1,  8, [ ori ])
    _declare_role_figure(hobbit_s4f1, 1,  9, [ nori ])
    _declare_role_figure(hobbit_s4f1, 1, 10, [ dori ])
    _declare_role_figure(hobbit_s4f1, 1, 11, [ bifur ])
    _declare_role_figure(hobbit_s4f1, 1, 12, [ bofur ])
    _declare_role_figure(hobbit_s4f1, 1, 13, [ bombur ])
    _declare_role_figure(hobbit_s4f1, 1, 14, "Gandalf the Grey", gandalf_grey_foot_all)

    hobbit_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s4.id, faction: :goblintown, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(hobbit_s4f2,  1, 1, [ goblin_king ])
    _declare_role_figure(hobbit_s4f2,  1, 2, [ grinnah ])
    _declare_role_figure(hobbit_s4f2,  1, 3, [ goblin_scribe ])
    _declare_role_figure(hobbit_s4f2, 36, 4, [ goblintown_g ])

    #========================================================================
    hobbit_s5 = Repo.insert! %Scenario{
      name: "Breakout",
      blurb: "Thorin's company continues their escape from Goblintown.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 45,
      map_width: 48, map_height: 48, location: :goblintown
    }

    Repo.insert! %ScenarioResource{scenario_id: hobbit_s5.id, resource_type: :source, book: :hobbit, title: "The Hobbit", sort_order: 5, page: 122}

    hobbit_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s5.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(hobbit_s5f1, 1,  1, [ thorin ])
    _declare_role_figure(hobbit_s5f1, 1,  2, [ balin ])
    _declare_role_figure(hobbit_s5f1, 1,  3, [ dwalin ])
    _declare_role_figure(hobbit_s5f1, 1,  4, [ fili ])
    _declare_role_figure(hobbit_s5f1, 1,  5, [ kili ])
    _declare_role_figure(hobbit_s5f1, 1,  6, [ oin ])
    _declare_role_figure(hobbit_s5f1, 1,  7, [ gloin ])
    _declare_role_figure(hobbit_s5f1, 1,  8, [ ori ])
    _declare_role_figure(hobbit_s5f1, 1,  9, [ nori ])
    _declare_role_figure(hobbit_s5f1, 1, 10, [ dori ])
    _declare_role_figure(hobbit_s5f1, 1, 11, [ bifur ])
    _declare_role_figure(hobbit_s5f1, 1, 12, [ bofur ])
    _declare_role_figure(hobbit_s5f1, 1, 13, [ bombur ])
    _declare_role_figure(hobbit_s5f1, 1, 14, "Gandalf the Grey", gandalf_grey_foot_all)

    hobbit_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s5.id, faction: :goblintown, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(hobbit_s5f2,  1, 1, [ goblin_king ])
    _declare_role_figure(hobbit_s5f2,  1, 2, [ grinnah ])
    _declare_role_figure(hobbit_s5f2, 36, 4, [ goblintown_g ])

    #========================================================================
    hobbit_s6 = Repo.insert! %Scenario{
      name: "Out of the Frying Pan",
      blurb: "Azog's Hunters resume chasing Thorin's company on the far side of the Misty Mountains.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 41,
      map_width: 48, map_height: 48, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: hobbit_s6.id, resource_type: :source, book: :hobbit, title: "The Hobbit", sort_order: 7, page: 126}

    hobbit_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s6.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(hobbit_s6f1, 1,  1, [ thorin ])
    _declare_role_figure(hobbit_s6f1, 1,  2, [ balin ])
    _declare_role_figure(hobbit_s6f1, 1,  3, [ dwalin ])
    _declare_role_figure(hobbit_s6f1, 1,  4, [ fili ])
    _declare_role_figure(hobbit_s6f1, 1,  5, [ kili ])
    _declare_role_figure(hobbit_s6f1, 1,  6, [ oin ])
    _declare_role_figure(hobbit_s6f1, 1,  7, [ gloin ])
    _declare_role_figure(hobbit_s6f1, 1,  8, [ ori ])
    _declare_role_figure(hobbit_s6f1, 1,  9, [ nori ])
    _declare_role_figure(hobbit_s6f1, 1, 10, [ dori ])
    _declare_role_figure(hobbit_s6f1, 1, 11, [ bifur ])
    _declare_role_figure(hobbit_s6f1, 1, 12, [ bofur ])
    _declare_role_figure(hobbit_s6f1, 1, 13, [ bombur ])
    _declare_role_figure(hobbit_s6f1, 1, 14, [ young_bilbo ])
    _declare_role_figure(hobbit_s6f1, 1, 15, "Gandalf the Grey", gandalf_grey_foot_all)

    hobbit_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s6.id, faction: :azogs_hunters, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(hobbit_s6f2,  1, 1, [ azog_warg ])
    _declare_role_figure(hobbit_s6f2,  1, 2, [ narzug_warg ])
    _declare_role_figure(hobbit_s6f2,  1, 3, [ fimbul_warg ])
    _declare_role_figure(hobbit_s6f2,  6, 4, [ hunter_orc_warg ])
    _declare_role_figure(hobbit_s6f2,  6, 5, [ fell_warg ])

    #========================================================================
    hobbit_s7 = Repo.insert! %Scenario{
      name: "Into the Fire",
      blurb: "Thorin defends his company against Azog himself.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 45,
      map_width: 48, map_height: 48, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: hobbit_s7.id, resource_type: :source, book: :hobbit, title: "The Hobbit", sort_order: 7, page: 126}

    hobbit_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s7.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(hobbit_s7f1, 1,  1, [ thorin ])
    _declare_role_figure(hobbit_s7f1, 1,  2, [ young_bilbo ])
    _declare_role_figure(hobbit_s7f1, 1,  3, [ gwaihir ])
    _declare_role_figure(hobbit_s7f1, 4,  4, [ eagle ])

    hobbit_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s7.id, faction: :goblintown, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(hobbit_s7f2,  1, 1, [ fimbul_warg ])

    #========================================================================
    hobbit_s8 = Repo.insert! %Scenario{
      name: "The Last Alliance",
      blurb: "Sauron is defeated at Mount Doom by elves and men.",
      date_age: 2, date_year: 3441, date_month: 0, date_day: 0, size: 113,
      map_width: 72, map_height: 48, location: :mordor
    }

    Repo.insert! %ScenarioResource{scenario_id: hobbit_s8.id, resource_type: :source, book: :hobbit, title: "The Hobbit", sort_order: 8, page: 136}
    _declare_video_replay(hobbit_s8.id, "https://www.youtube.com/watch?v=I8S4Li4e88c&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV&index=9", "Spillforeningen the Fellowship", 1)

    hobbit_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s8.id, faction: :rivendell, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(hobbit_s8f1,  1,  1, [ gil_galad ])
    _declare_role_figure(hobbit_s8f1,  1,  2, [ elrond ])
    _declare_role_figure(hobbit_s8f1, 10,  3, [ high_elf_w_blade ])
    _declare_role_figure(hobbit_s8f1, 10,  4, [ high_elf_w_bow ])
    _declare_role_figure(hobbit_s8f1,  9,  5, [ high_elf_w_spear_shield ])
    _declare_role_figure(hobbit_s8f1,  1,  6, [ high_elf_w_banner ])
    _declare_role_figure(hobbit_s8f1,  1,  7, [ elendil ])
    _declare_role_figure(hobbit_s8f1,  1,  8, [ isildur ])
    _declare_role_figure(hobbit_s8f1,  1,  9, "Numenor Captain with heavy armour and shield", [ numenor_captain ])
    _declare_role_figure(hobbit_s8f1,  7, 10, [ numenor_w_shield ])
    _declare_role_figure(hobbit_s8f1,  7, 11, [ numenor_w_bow ])
    _declare_role_figure(hobbit_s8f1,  6, 12, [ numenor_w_shield_spear ])
    _declare_role_figure(hobbit_s8f1,  1, 13, [ numenor_w_banner ])

    hobbit_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s8.id, faction: :barad_dur, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(hobbit_s8f2,  1,  1, [ sauron ])
    _declare_role_figure(hobbit_s8f2,  1,  2, "Witch-King of Angmar on horse (full M/W/F)", [ witch_king_horse ])
    _declare_role_figure(hobbit_s8f2,  2,  3, "Ringwraiths on horse (full M/W/F)", [ ringwraith_horse ])
    _declare_role_figure(hobbit_s8f2,  1,  4, [ troll_chieftain ])
    _declare_role_figure(hobbit_s8f2,  2,  5, [ orc_captain ])
    _declare_role_figure(hobbit_s8f2, 12,  6, [ orc_w_shield ])
    _declare_role_figure(hobbit_s8f2, 12,  7, [ orc_w_spear ])
    _declare_role_figure(hobbit_s8f2,  6,  8, [ orc_w_bow ])
    _declare_role_figure(hobbit_s8f2,  6,  9, [ orc_w_2h ])
    _declare_role_figure(hobbit_s8f2,  4, 10, [ warg_rider_bow ])
    _declare_role_figure(hobbit_s8f2,  4, 11, [ warg_rider_shield ])
    _declare_role_figure(hobbit_s8f2,  4, 12, [ warg_rider_shield_spear ])
    _declare_role_figure(hobbit_s8f2,  2, 13, [ mordor_troll ])

    #========================================================================
    hobbit_s9 = Repo.insert! %Scenario{
      name: "The Attack at Weathertop",
      blurb: "The Witch-King and his minions attempt to seize the One Ring from Frodo.",
      date_age: 3, date_year: 3018, date_month: 10, date_day: 6, size: 10,
      map_width: 48, map_height: 48, location: :eriador
    }

    Repo.insert! %ScenarioResource{scenario_id: hobbit_s9.id, resource_type: :source, book: :hobbit, title: "The Hobbit", sort_order: 9, page: 140}

    hobbit_s9f1 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s9.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(hobbit_s9f1, 1, 1, [ frodo ])
    _declare_role_figure(hobbit_s9f1, 1, 2, [ sam ])
    _declare_role_figure(hobbit_s9f1, 1, 3, [ merry ])
    _declare_role_figure(hobbit_s9f1, 1, 4, [ pippin ])
    _declare_role_figure(hobbit_s9f1, 1, 5, [ aragorn ])

    hobbit_s9f2 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s9.id, faction: :nazgul, suggested_points: 330, actual_points: 330, sort_order: 2}
    _declare_role_figure(hobbit_s9f2, 1, 1, [ witch_king ])
    _declare_role_figure(hobbit_s9f2, 4, 2, [ ringwraith ])

    #========================================================================
    hobbit_s10 = Repo.insert! %Scenario{
      name: "Balin's Tomb",
      blurb: "The Fellowship takes a break on their trek through Moria ... and are cornered in Balin's Tomb.",
      date_age: 3, date_year: 3019, date_month: 1, date_day: 14, size: 48,
      map_width: 24, map_height: 24, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: hobbit_s10.id, resource_type: :source, book: :hobbit, title: "The Hobbit", sort_order: 10, page: 142}

    hobbit_s10f1 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s10.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(hobbit_s10f1, 1, 1, [ frodo ])
    _declare_role_figure(hobbit_s10f1, 1, 2, [ sam ])
    _declare_role_figure(hobbit_s10f1, 1, 3, [ merry ])
    _declare_role_figure(hobbit_s10f1, 1, 4, [ pippin ])
    _declare_role_figure(hobbit_s10f1, 1, 5, [ aragorn ])
    _declare_role_figure(hobbit_s10f1, 1, 6, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(hobbit_s10f1, 1, 7, [ boromir ])
    _declare_role_figure(hobbit_s10f1, 1, 8, [ legolas ])
    _declare_role_figure(hobbit_s10f1, 1, 9, "Gimli", gimli_all_foot)

    hobbit_s10f2 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s10.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(hobbit_s10f2,  2, 1, [ moria_captain ])
    _declare_role_figure(hobbit_s10f2, 12, 2, [ moria_g_shield ])
    _declare_role_figure(hobbit_s10f2, 12, 3, [ moria_g_spear ])
    _declare_role_figure(hobbit_s10f2, 12, 4, [ moria_g_bow ])
    _declare_role_figure(hobbit_s10f2,  1, 5, "Cave Troll", [ cave_troll_spear, cave_troll_chain ])

    #========================================================================
    hobbit_s11 = Repo.insert! %Scenario{
      name: "The Bridge of Khazad-dûm",
      blurb: "The Fellowship escape from the Balrog, but not without some heartbreak.",
      date_age: 3, date_year: 3019, date_month: 1, date_day: 15, size: 48,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: hobbit_s11.id, resource_type: :source, book: :hobbit, title: "The Hobbit", sort_order: 11, page: 144}

    hobbit_s11f1 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s11.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(hobbit_s11f1, 1, 1, [ frodo ])
    _declare_role_figure(hobbit_s11f1, 1, 2, [ sam ])
    _declare_role_figure(hobbit_s11f1, 1, 3, [ merry ])
    _declare_role_figure(hobbit_s11f1, 1, 4, [ pippin ])
    _declare_role_figure(hobbit_s11f1, 1, 5, [ aragorn ])
    _declare_role_figure(hobbit_s11f1, 1, 6, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(hobbit_s11f1, 1, 7, [ boromir ])
    _declare_role_figure(hobbit_s11f1, 1, 8, [ legolas ])
    _declare_role_figure(hobbit_s11f1, 1, 9, "Gimli", gimli_all_foot)

    hobbit_s11f2 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s11.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(hobbit_s11f2,  1, 1, "Balrog", [ balrog, balrog_plastic, balrog_whip ])
    _declare_role_figure(hobbit_s11f2,  2, 2, [ moria_captain ])
    _declare_role_figure(hobbit_s11f2, 12, 3, [ moria_g_shield ])
    _declare_role_figure(hobbit_s11f2, 12, 4, [ moria_g_spear ])
    _declare_role_figure(hobbit_s11f2, 12, 5, [ moria_g_bow ])

    #========================================================================
    hobbit_s12 = Repo.insert! %Scenario{
      name: "Ambush at Amon Hen",
      blurb: "The Uruk-hai attempt to run off with the hobbits.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 26, size: 38,
      map_width: 72, map_height: 48, location: :amon_hen
    }

    Repo.insert! %ScenarioResource{scenario_id: hobbit_s12.id, resource_type: :source, book: :hobbit, title: "The Hobbit", sort_order: 12, page: 146}

    hobbit_s12f1 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s12.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(hobbit_s12f1, 1, 1, [ frodo ])
    _declare_role_figure(hobbit_s12f1, 1, 2, [ sam ])
    _declare_role_figure(hobbit_s12f1, 1, 3, [ merry ])
    _declare_role_figure(hobbit_s12f1, 1, 4, [ pippin ])
    _declare_role_figure(hobbit_s12f1, 1, 5, [ aragorn ])
    _declare_role_figure(hobbit_s12f1, 1, 6, [ boromir ])
    _declare_role_figure(hobbit_s12f1, 1, 7, [ legolas ])
    _declare_role_figure(hobbit_s12f1, 1, 8, "Gimli", gimli_all_foot)

    hobbit_s12f2 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s12.id, faction: :isengard, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(hobbit_s12f2,  1, 1, [ lurtz ])
    _declare_role_figure(hobbit_s12f2,  1, 2, [ ugluk ])
    _declare_role_figure(hobbit_s12f2,  1, 3, [ uruk_hai_captain_shield ])
    _declare_role_figure(hobbit_s12f2, 14, 3, [ uruk_hai_s_sword_shield ])
    _declare_role_figure(hobbit_s12f2, 13, 3, [ uruk_hai_s_bow ])

    #========================================================================
    hobbit_s13 = Repo.insert! %Scenario{
      name: "The Siege of Helm's Deep",
      blurb: "The Rohirrim hold their fortress against the attacks of the Uruk-hai.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 152,
      map_width: 72, map_height: 48, location: :helms_deep
    }

    Repo.insert! %ScenarioResource{scenario_id: hobbit_s13.id, resource_type: :source, book: :hobbit, title: "The Hobbit", sort_order: 13, page: 148}

    hobbit_s13f1 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s13.id, faction: :rohan, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(hobbit_s13f1,  1, 1, [ theoden ])
    _declare_role_figure(hobbit_s13f1,  1, 2, [ aragorn ])
    _declare_role_figure(hobbit_s13f1,  1, 3, [ legolas ])
    _declare_role_figure(hobbit_s13f1,  1, 4, "Gimli", gimli_all_foot)
    _declare_role_figure(hobbit_s13f1,  2, 5, "Captains of Rohan with heavy armour and shield", [ rohan_captain ])
    _declare_role_figure(hobbit_s13f1,  9, 6, [ rohan_gd_spear ])
    _declare_role_figure(hobbit_s13f1, 12, 7, [ rohan_w_spear_shield ])
    _declare_role_figure(hobbit_s13f1, 12, 8, [ rohan_w_shield ])
    _declare_role_figure(hobbit_s13f1, 12, 9, [ rohan_w_bow ])

    hobbit_s13f2 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s13.id, faction: :isengard, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(hobbit_s13f2,  5,  1, [ uruk_hai_captain_shield ])
    _declare_role_figure(hobbit_s13f2, 27,  2, [ uruk_hai_w_shield ])
    _declare_role_figure(hobbit_s13f2, 27,  3, [ uruk_hai_w_pike ])
    _declare_role_figure(hobbit_s13f2,  6,  4, [ uruk_hai_w_crossbow ])
    _declare_role_figure(hobbit_s13f2, 12,  5, [ uruk_hai_berserker ])
    _declare_role_figure(hobbit_s13f2,  3,  6, [ uruk_hai_ballista ])
    _declare_role_figure(hobbit_s13f2,  9,  7, [ uruk_hai_ballista_crew ])
    _declare_role_figure(hobbit_s13f2,  3,  8, [ uruk_hai_demo_charge ])
    _declare_role_figure(hobbit_s13f2,  6,  9, [ uruk_hai_demo_crew ])
    _declare_role_figure(hobbit_s13f2,  3, 10, [ uruk_hai_demo_berserker ])

    #========================================================================
    hobbit_s14 = Repo.insert! %Scenario{
      name: "The Battle of Pelennor Fields",
      blurb: "The forces of Good counterattack the Evil forces besieging Minas Tirith.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 257,
      map_width: 120, map_height: 72, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: hobbit_s14.id, resource_type: :source, book: :hobbit, title: "The Hobbit", sort_order: 14, page: 152}

    hobbit_s14f1 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s14.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(hobbit_s14f1,  1,  1, "Gandalf the White on Shadowfax", [ gandalf_white_horse, gandalf_white_horse_mt ])
    _declare_role_figure(hobbit_s14f1,  1,  2, "Captain of Minas Tirith on horse with lance and shield", [ gondor_captain_mt_horse ])
    _declare_role_figure(hobbit_s14f1, 12,  3, [ gondor_womt_spear_shield ])
    _declare_role_figure(hobbit_s14f1, 12,  4, [ gondor_womt_shield ])
    _declare_role_figure(hobbit_s14f1, 12,  5, [ gondor_womt_bow ])
    _declare_role_figure(hobbit_s14f1,  1,  6, [ imrahil_horse ])
    _declare_role_figure(hobbit_s14f1,  1,  7, [ forlong_horse ])
    _declare_role_figure(hobbit_s14f1,  1,  8, [ angbor ])
    _declare_role_figure(hobbit_s14f1,  6,  9, "Knights of Dol Amroth with armoured horse and lance",[ gondor_knight_da_horse ])
    _declare_role_figure(hobbit_s14f1, 12, 10, [ maa_da ])
    _declare_role_figure(hobbit_s14f1,  9, 11, [ axemen_lossarnach ])
    _declare_role_figure(hobbit_s14f1,  9, 12, [ clansmen_lamedon ])
    _declare_role_figure(hobbit_s14f1,  1, 13, [ aragorn ])
    _declare_role_figure(hobbit_s14f1,  1, 14, [ legolas ])
    _declare_role_figure(hobbit_s14f1,  1, 15, "Gimli", gimli_all_foot)
    _declare_role_figure(hobbit_s14f1,  1, 16, [ king_dead ])
    _declare_role_figure(hobbit_s14f1,  6, 17, [ dead_rider ])
    _declare_role_figure(hobbit_s14f1, 16, 18, [ dead_w ])
    _declare_role_figure(hobbit_s14f1,  1, 19, [ theoden_armor_horse ])
    _declare_role_figure(hobbit_s14f1,  1, 20, "Éomer, Knight of the Pelennor on horse", [ eomer_horse ])
    _declare_role_figure(hobbit_s14f1,  1, 21, [ gamling_horse ])
    _declare_role_figure(hobbit_s14f1,  1, 22, [ eowyn_horse ])
    _declare_role_figure(hobbit_s14f1,  1, 23, [ merry_rohan ])
    _declare_role_figure(hobbit_s14f1,  3, 24, "Rohan Royal Guard on horse with throwing spears", [ rohan_gd_horse_spear ])
    _declare_role_figure(hobbit_s14f1, 16, 25, [ rohan_rider ])
    _declare_role_figure(hobbit_s14f1,  8, 26, [ rohan_rider_spear ])

    hobbit_s14f2 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s14.id, faction: :isengard, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(hobbit_s14f2,  1,  1, "Witch-King of Angmar on horse (full M/W/F)", [ witch_king_horse ])
    _declare_role_figure(hobbit_s14f2,  3,  2, "Ringwraiths on horse (full M/W/F)", [ ringwraith_horse ])
    _declare_role_figure(hobbit_s14f2,  1,  3, [ troll_chieftain ])
    _declare_role_figure(hobbit_s14f2,  5,  4, [ orc_captain ])
    _declare_role_figure(hobbit_s14f2,  2,  5, [ m_orc_captain ])
    _declare_role_figure(hobbit_s14f2, 20,  6, [ orc_w_shield ])
    _declare_role_figure(hobbit_s14f2, 20,  7, [ orc_w_spear ])
    _declare_role_figure(hobbit_s14f2, 10,  8, [ orc_w_bow ])
    _declare_role_figure(hobbit_s14f2, 10,  9, [ orc_w_2h ])
    _declare_role_figure(hobbit_s14f2, 12, 10, [ orc_m_shield ])
    _declare_role_figure(hobbit_s14f2, 12, 11, [ orc_m_spear ])
    _declare_role_figure(hobbit_s14f2,  7, 12, [ warg_rider_bow ])
    _declare_role_figure(hobbit_s14f2,  8, 13, [ warg_rider_shield ])
    _declare_role_figure(hobbit_s14f2,  8, 14, [ warg_rider_shield_spear ])
    _declare_role_figure(hobbit_s14f2,  4, 15, [ mordor_troll ])
    _declare_role_figure(hobbit_s14f2,  2, 16, [ harad_chieftain ])
    _declare_role_figure(hobbit_s14f2,  2, 17, [ mumak ])
    _declare_role_figure(hobbit_s14f2, 18, 18, [ harad_w_spear ])
    _declare_role_figure(hobbit_s14f2, 18, 19, [ harad_w_bow ])
    _declare_role_figure(hobbit_s14f2,  4, 20, [ harad_raider ])
    _declare_role_figure(hobbit_s14f2,  4, 21, [ harad_raider_lance ])

    #========================================================================
    hobbit_s15 = Repo.insert! %Scenario{
      name: "The Black Gate Opens",
      blurb: "Can the forces of Good distract Sauron from detecting Frodo's mission?",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 25, size: 234,
      map_width: 48, map_height: 48, location: :mordor
    }

    Repo.insert! %ScenarioResource{scenario_id: hobbit_s15.id, resource_type: :source, book: :hobbit, title: "The Hobbit", sort_order: 15, page: 156}

    hobbit_s15f1 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s15.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(hobbit_s15f1,  1,  1, "Gandalf the White on Shadowfax", [ gandalf_white_horse, gandalf_white_horse_mt ])
    _declare_role_figure(hobbit_s15f1,  1,  2, [ aragorn ])
    _declare_role_figure(hobbit_s15f1,  1,  3, [ legolas ])
    _declare_role_figure(hobbit_s15f1,  1,  4, "Gimli", gimli_all_foot)
    _declare_role_figure(hobbit_s15f1,  1,  5, [ pippin_gondor ])
    _declare_role_figure(hobbit_s15f1,  2,  6, [ gondor_captain_mt ])
    _declare_role_figure(hobbit_s15f1, 12,  7, [ gondor_womt_spear_shield ])
    _declare_role_figure(hobbit_s15f1, 12,  8, [ gondor_womt_shield ])
    _declare_role_figure(hobbit_s15f1, 12,  9, [ gondor_womt_bow ])
    _declare_role_figure(hobbit_s15f1, 12, 10, [ gondor_rog ])
    _declare_role_figure(hobbit_s15f1,  1, 11, [ imrahil ])
    _declare_role_figure(hobbit_s15f1,  1, 12, [ forlong ])
    _declare_role_figure(hobbit_s15f1,  1, 13, [ angbor ])
    _declare_role_figure(hobbit_s15f1,  9, 14, [ maa_da ])
    _declare_role_figure(hobbit_s15f1,  6, 15, [ axemen_lossarnach ])
    _declare_role_figure(hobbit_s15f1,  6, 16, [ clansmen_lamedon ])
    _declare_role_figure(hobbit_s15f1,  1, 17, "Éomer, Knight of the Pelennor", [ eomer ])
    _declare_role_figure(hobbit_s15f1,  1, 18, "Captain of Rohan with shield", [ rohan_captain ])
    _declare_role_figure(hobbit_s15f1,  7, 19, [ rohan_gd ])
    _declare_role_figure(hobbit_s15f1,  8, 20, [ rohan_w_shield ])
    _declare_role_figure(hobbit_s15f1,  8, 21, [ rohan_w_spear_shield ])
    _declare_role_figure(hobbit_s15f1,  8, 22, [ rohan_w_bow ])
    _declare_role_figure(hobbit_s15f1,  1, 23, [ gwaihir ])
    _declare_role_figure(hobbit_s15f1,  4, 24, [ eagle ])

    hobbit_s15f2 = Repo.insert! %ScenarioFaction{scenario_id: hobbit_s15.id, faction: :black_gate, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(hobbit_s15f2,  3,  1, [ ringwraith_fellbeast ])
    _declare_role_figure(hobbit_s15f2,  1,  2, [ troll_chieftain ])
    _declare_role_figure(hobbit_s15f2,  3,  3, [ orc_captain ])
    _declare_role_figure(hobbit_s15f2, 12,  4, [ orc_w_shield ])
    _declare_role_figure(hobbit_s15f2, 12,  5, [ orc_w_spear ])
    _declare_role_figure(hobbit_s15f2,  6,  6, [ orc_w_bow ])
    _declare_role_figure(hobbit_s15f2,  6,  7, [ orc_w_2h ])
    _declare_role_figure(hobbit_s15f2, 12,  8, [ orc_m_shield ])
    _declare_role_figure(hobbit_s15f2, 12,  9, [ orc_w_spear ])
    _declare_role_figure(hobbit_s15f2,  2, 10, [ mordor_troll ])
    _declare_role_figure(hobbit_s15f2,  2, 11, [ easterling_captain ])
    _declare_role_figure(hobbit_s15f2,  8, 12, [ easterling_w_shield ])
    _declare_role_figure(hobbit_s15f2,  8, 13, [ easterling_w_bow ])
    _declare_role_figure(hobbit_s15f2,  4, 14, [ easterling_w_shield_spear ])
    _declare_role_figure(hobbit_s15f2,  2, 15, [ harad_chieftain ])
    _declare_role_figure(hobbit_s15f2, 12, 16, [ harad_w_spear ])
    _declare_role_figure(hobbit_s15f2, 12, 17, [ harad_w_bow ])

    #########################################################################
    # KHAZAD-DÛM
    #########################################################################

    #========================================================================
    kd_s1 = Repo.insert! %Scenario{
      name: "Durin's Tower",
      blurb: "A Dragon attacks the topmost outpost of the Dwarven realm of Moria.",
      date_age: 3, date_year: 1970, date_month: 0, date_day: 0, size: 39,
      map_width: 24, map_height: 24, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: kd_s1.id, resource_type: :source, book: :kd, title: "Khazad-dûm", sort_order: 1, page: 54}

    kd_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: kd_s1.id, faction: :durins_folk, suggested_points: 500, actual_points: 0, sort_order: 1}
    _declare_role_figure(kd_s1f1, 1,  1, [ dwarf_captain_shield ])
    _declare_role_figure(kd_s1f1, 3,  2, [ vault_team_shield ])
    _declare_role_figure(kd_s1f1, 3,  3, [ vault_team_spear ])
    _declare_role_figure(kd_s1f1, 4,  4, [ dwarf_r_axe ])
    _declare_role_figure(kd_s1f1, 4,  5, [ dwarf_r_bow ])
    _declare_role_figure(kd_s1f1, 4,  6, [ dwarf_r_2h ])
    _declare_role_figure(kd_s1f1, 6,  7, [ dwarf_iron_gd ])
    _declare_role_figure(kd_s1f1, 4,  8, [ dwarf_w_bow ])
    _declare_role_figure(kd_s1f1, 4,  9, [ dwarf_w_shield ])
    _declare_role_figure(kd_s1f1, 4, 10, [ dwarf_w_2h ])
    _declare_role_figure(kd_s1f1, 1, 11, [ dwarf_w_banner ])

    kd_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: kd_s1.id, faction: :moria, suggested_points: 350, actual_points: 350, sort_order: 2}
    _declare_role_figure(kd_s1f2, 1, 1, [ dragon ])

    #========================================================================
    kd_s2 = Repo.insert! %Scenario{
      name: "Attack on the East Gate",
      blurb: "A Dragon attacks the topmost outpost of the Dwarven realm of Moria.",
      date_age: 3, date_year: 1971, date_month: 0, date_day: 0, size: 34,
      map_width: 24, map_height: 24, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: kd_s2.id, resource_type: :source, book: :kd, title: "Khazad-dûm", sort_order: 2, page: 56}

    kd_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: kd_s2.id, faction: :durins_folk, suggested_points: 200, actual_points: 0, sort_order: 1}
    _declare_role_figure(kd_s2f1, 1,  1, [ dwarf_captain_shield ])
    _declare_role_figure(kd_s2f1, 4,  2, [ dwarf_w_shield ])
    _declare_role_figure(kd_s2f1, 4,  3, [ dwarf_w_bow ])
    _declare_role_figure(kd_s2f1, 4,  4, [ dwarf_w_2h ])
    _declare_role_figure(kd_s2f1, 1,  5, [ dwarf_w_banner ])

    kd_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: kd_s2.id, faction: :moria, suggested_points: 150, actual_points: 0, sort_order: 2}
    _declare_role_figure(kd_s2f2, 1,  1, [ moria_captain ])
    _declare_role_figure(kd_s2f2, 1,  2, [ moria_captain_bow ])
    _declare_role_figure(kd_s2f2, 2,  3, [ moria_p_bow ])
    _declare_role_figure(kd_s2f2, 2,  4, [ moria_p_shield ])
    _declare_role_figure(kd_s2f2, 2,  5, [ moria_p_2h ])
    _declare_role_figure(kd_s2f2, 4,  6, [ moria_g_shield ])
    _declare_role_figure(kd_s2f2, 4,  7, [ moria_g_spear ])
    _declare_role_figure(kd_s2f2, 4,  8, [ moria_g_bow ])

    #========================================================================
    kd_s3 = Repo.insert! %Scenario{
      name: "Battle of the Barazinbar Deeps",
      blurb: "The forces of King Durin have awoken a nameless terror.",
      date_age: 3, date_year: 1980, date_month: 0, date_day: 0, size: 133,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: kd_s3.id, resource_type: :source, book: :kd, title: "Khazad-dûm", sort_order: 3, page: 58}

    kd_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: kd_s3.id, faction: :durins_folk, suggested_points: 985, actual_points: 0, sort_order: 1}
    _declare_role_figure(kd_s3f1, 1,  1, [ durin ])
    _declare_role_figure(kd_s3f1, 1,  2, [ mardin ])
    _declare_role_figure(kd_s3f1, 1,  3, [ dwarf_captain_shield ])
    _declare_role_figure(kd_s3f1, 8,  4, [ dwarf_w_shield ])
    _declare_role_figure(kd_s3f1, 8,  5, [ dwarf_w_bow ])
    _declare_role_figure(kd_s3f1, 8,  6, [ dwarf_w_2h ])
    _declare_role_figure(kd_s3f1, 9,  7, [ dwarf_khazad_gd ])
    _declare_role_figure(kd_s3f1, 6,  8, [ dwarf_iron_gd ])
    _declare_role_figure(kd_s3f1, 3,  9, [ vault_team_shield ])
    _declare_role_figure(kd_s3f1, 3, 10, [ vault_team_spear ])
    _declare_role_figure(kd_s3f1, 2, 11, [ dwarf_ballista ])
    _declare_role_figure(kd_s3f1, 4, 11, [ dwarf_ballista_crew ])
    _declare_role_figure(kd_s3f1, 4, 12, [ dwarf_r_2h ])
    _declare_role_figure(kd_s3f1, 4, 13, [ dwarf_r_bow ])
    _declare_role_figure(kd_s3f1, 4, 14, [ dwarf_r_axe ])

    kd_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: kd_s3.id, faction: :moria, suggested_points: 1000, actual_points: 0, sort_order: 2}
    _declare_role_figure(kd_s3f2,  1,  1, "Balrog", [ balrog, balrog_plastic, balrog_whip ])
    _declare_role_figure(kd_s3f2,  1,  2, [ moria_captain ])
    _declare_role_figure(kd_s3f2,  1,  3, [ moria_captain_bow ])
    _declare_role_figure(kd_s3f2,  2,  4, [ moria_shaman ])
    _declare_role_figure(kd_s3f2, 16,  5, [ moria_g_shield ])
    _declare_role_figure(kd_s3f2, 16,  6, [ moria_g_spear ])
    _declare_role_figure(kd_s3f2, 16,  7, [ moria_g_bow ])
    _declare_role_figure(kd_s3f2,  2,  8, [ moria_p_2h ])
    _declare_role_figure(kd_s3f2,  2,  9, [ moria_p_bow ])
    _declare_role_figure(kd_s3f2,  2, 10, [ moria_p_shield ])
    _declare_role_figure(kd_s3f2,  2, 11, "Cave Trolls", [ cave_troll_chain, cave_troll_spear ])
    _declare_role_figure(kd_s3f2,  3, 12, [ bat_swarm ])
    _declare_role_figure(kd_s3f2,  1, 13, [ moria_drum ])
    _declare_role_figure(kd_s3f2,  2, 14, [ moria_drummer ])

    #========================================================================
    kd_s4 = Repo.insert! %Scenario{
      name: "Ambush at the Crossroads",
      blurb: "Durburz sets a trap for Balin and his expedition to reclaim the kingdom of Khazad-dûm.",
      date_age: 3, date_year: 2989, date_month: 0, date_day: 0, size: 79,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: kd_s4.id, resource_type: :source, book: :kd, title: "Khazad-dûm", sort_order: 4, page: 60}

    kd_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: kd_s4.id, faction: :durins_folk, suggested_points: 595, actual_points: 0, sort_order: 1}
    _declare_role_figure(kd_s4f1, 1,  1, "Balin with Durin's Axe", [ balin ])
    _declare_role_figure(kd_s4f1, 1,  2, [ dwarf_captain_shield ])
    _declare_role_figure(kd_s3f1, 4,  3, [ dwarf_w_shield ])
    _declare_role_figure(kd_s3f1, 4,  4, [ dwarf_w_bow ])
    _declare_role_figure(kd_s3f1, 4,  5, [ dwarf_w_2h ])
    _declare_role_figure(kd_s4f1, 4,  6, [ dwarf_r_2h ])
    _declare_role_figure(kd_s4f1, 4,  7, [ dwarf_r_axe ])
    _declare_role_figure(kd_s4f1, 4,  8, [ dwarf_r_bow ])
    _declare_role_figure(kd_s4f1, 1,  9, [ dwarf_w_banner ])
    _declare_role_figure(kd_s4f1, 6, 10, [ dwarf_khazad_gd ])
    _declare_role_figure(kd_s4f1, 6, 11, [ dwarf_iron_gd ])

    kd_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: kd_s4.id, faction: :moria, suggested_points: 560, actual_points: 0, sort_order: 2}
    _declare_role_figure(kd_s4f2, 1,  1, [ durburz ])
    _declare_role_figure(kd_s4f2, 1,  2, [ moria_captain_bow ])
    _declare_role_figure(kd_s4f2, 1,  3, [ moria_shaman ])
    _declare_role_figure(kd_s4f2, 1,  4, [ moria_drum ])
    _declare_role_figure(kd_s4f2, 2,  5, [ moria_drummer ])
    _declare_role_figure(kd_s4f2, 2,  6, [ moria_p_2h ])
    _declare_role_figure(kd_s4f2, 2,  7, [ moria_p_bow ])
    _declare_role_figure(kd_s4f2, 2,  8, [ moria_p_shield ])
    _declare_role_figure(kd_s4f2, 8,  9, [ moria_g_shield ])
    _declare_role_figure(kd_s4f2, 8, 10, [ moria_g_spear ])
    _declare_role_figure(kd_s4f2, 8, 11, [ moria_g_bow ])
    _declare_role_figure(kd_s4f2, 2, 12, "Cave Trolls", [ cave_troll_chain, cave_troll_spear ])

    #========================================================================
    kd_s5 = Repo.insert! %Scenario{
      name: "The Razing of High Water",
      blurb: "A dragon-led Goblin force attacks the dwarven town of High Water.",
      date_age: 3, date_year: 2954, date_month: 0, date_day: 0, size: 58,
      map_width: 48, map_height: 48, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: kd_s5.id, resource_type: :source, book: :kd, title: "Khazad-dûm", sort_order: 5, page: 62}

    kd_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: kd_s5.id, faction: :durins_folk, suggested_points: 600, actual_points: 0, sort_order: 1}
    _declare_role_figure(kd_s5f1, 1,  1, [ dwarf_king_2h ])
    _declare_role_figure(kd_s5f1, 1,  2, [ dwarf_captain_shield ])
    _declare_role_figure(kd_s5f1, 1,  3, [ murin ])
    _declare_role_figure(kd_s5f1, 1,  4, [ drar ])
    _declare_role_figure(kd_s5f1, 3,  5, [ dwarf_khazad_gd ])
    _declare_role_figure(kd_s5f1, 7,  6, [ dwarf_w_bow ])
    _declare_role_figure(kd_s5f1, 7,  7, [ dwarf_w_shield ])
    _declare_role_figure(kd_s5f1, 6,  8, [ dwarf_w_2h ])
    _declare_role_figure(kd_s5f1, 1,  9, [ dwarf_w_banner ])
    _declare_role_figure(kd_s5f1, 1, 10, [ dwarf_ballista ])
    _declare_role_figure(kd_s5f1, 2, 11, [ dwarf_ballista_crew ])

    kd_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: kd_s5.id, faction: :moria, suggested_points: 600, actual_points: 0, sort_order: 2}
    _declare_role_figure(kd_s5f2, 1,  1, "Dragon with Fly and Wyrmtongue", [ dragon ])
    _declare_role_figure(kd_s5f2, 1,  2, [ moria_captain ])
    _declare_role_figure(kd_s5f2, 1,  3, [ warg_chieftain ])
    _declare_role_figure(kd_s5f2, 6,  4, [ warg ])
    _declare_role_figure(kd_s5f2, 6,  5, [ moria_g_spear ])
    _declare_role_figure(kd_s5f2, 6,  6, [ moria_g_bow ])
    _declare_role_figure(kd_s5f2, 6,  7, [ moria_g_shield ])

    #########################################################################
    # KINGDOMS OF MEN
    #########################################################################

    #========================================================================
    km_s1 = Repo.insert! %Scenario{
      name: "The Gladden Fields",
      blurb: "Isildur discovers that the forces of Evil have not been entirely defeated.",
      date_age: 3, date_year: 2, date_month: 0, date_day: 0, size: 71,
      map_width: 72, map_height: 48, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: km_s1.id, resource_type: :source, book: :km, title: "Kingdoms of Men", sort_order: 1, page: 44}
    _declare_video_replay(km_s1.id, "https://www.youtube.com/watch?v=wxTz2OQqNz0&index=10&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV", "Spillforeningen the Fellowship", 1)

    km_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: km_s1.id, faction: :numenor, suggested_points: 300, actual_points: 300, sort_order: 1}
    _declare_role_figure(km_s1f1, 1,  1, "Isildur with the One Ring", [ isildur ])
    _declare_role_figure(km_s1f1, 9,  2, [ numenor_w_shield ])
    _declare_role_figure(km_s1f1, 8,  3, [ numenor_w_shield_spear ])
    _declare_role_figure(km_s1f1, 8,  4, [ numenor_w_bow ])

    km_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: km_s1.id, faction: :cirith_ungol, suggested_points: 300, actual_points: 399, sort_order: 2}
    _declare_role_figure(km_s1f2,  2,  1, "Mordor Orc Captains with shield", [ orc_captain ])
    _declare_role_figure(km_s1f2, 12,  2, [ orc_w_shield ])
    _declare_role_figure(km_s1f2, 12,  3, [ orc_w_spear ])
    _declare_role_figure(km_s1f2,  6,  4, [ orc_w_bow ])
    _declare_role_figure(km_s1f2,  6,  5, [ orc_w_2h ])
    _declare_role_figure(km_s1f2,  2,  6, [ warg_rider_shield_spear ])
    _declare_role_figure(km_s1f2,  2,  7, [ warg_rider_shield ])
    _declare_role_figure(km_s1f2,  3,  8, [ warg_rider_bow ])

    #========================================================================
    km_s2 = Repo.insert! %Scenario{
      name: "Ambush in Ithilien",
      blurb: "Faramir's Rangers encounter a Mûmak.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 7, size: 47,
      map_width: 72, map_height: 48, location: :ithilien
    }

    Repo.insert! %ScenarioResource{scenario_id: km_s2.id, resource_type: :source, book: :km, title: "Kingdoms of Men", sort_order: 2, page: 45}

    km_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: km_s2.id, faction: :minas_tirith, suggested_points: 300, actual_points: 294, sort_order: 1}
    _declare_role_figure(km_s2f1,  1,  1, [ faramir ])
    _declare_role_figure(km_s2f1,  1,  2, [ madril ])
    _declare_role_figure(km_s2f1,  1,  3, [ damrod ])
    _declare_role_figure(km_s2f1, 18,  4, [ gondor_rog ])

    km_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: km_s2.id, faction: :harad, suggested_points: 500, actual_points: 493, sort_order: 2}
    _declare_role_figure(km_s2f2,  1,  1, [ harad_chieftain ])
    _declare_role_figure(km_s2f2, 12,  2, [ harad_w_bow ])
    _declare_role_figure(km_s2f2, 12,  3, [ harad_w_spear ])
    _declare_role_figure(km_s2f2,  1,  4, [ mumak ])

    #========================================================================
    km_s3 = Repo.insert! %Scenario{
      name: "Relief of Helm's Deep",
      blurb: "The besiegers at Helm's Deep are enveloped.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 77,
      map_width: 48, map_height: 48, location: :helms_deep
    }

    Repo.insert! %ScenarioResource{scenario_id: km_s3.id, resource_type: :source, book: :km, title: "Kingdoms of Men", sort_order: 3, page: 46}

    km_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: km_s3.id, faction: :rohan, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(km_s3f1,  1,  1, [ aragorn_horse ])
    _declare_role_figure(km_s3f1,  1,  2, "Gandalf the White on Shadowfax", [ gandalf_white_horse, gandalf_white_horse_mt ])
    _declare_role_figure(km_s3f1,  1,  3, [ legolas_horse ])
    _declare_role_figure(km_s3f1,  1,  4, "Gimli", gimli_all_foot)
    _declare_role_figure(km_s3f1,  1,  5, [ theoden_horse ])
    _declare_role_figure(km_s3f1,  1,  6, [ gamling_horse ])
    _declare_role_figure(km_s3f1,  1,  7, [ eomer_horse ])
    _declare_role_figure(km_s3f1,  5,  8, [ rohan_gd_horse_spear ])
    _declare_role_figure(km_s3f1,  1,  9, [ rohan_gd_horse_banner ])
    _declare_role_figure(km_s3f1, 10, 10, [ rohan_rider ])
    _declare_role_figure(km_s3f1,  9, 11, [ rohan_rider_spear ])

    km_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: km_s3.id, faction: :isengard, suggested_points: 600, actual_points: 0, sort_order: 2}
    _declare_role_figure(km_s3f2,  3,  1, [ uruk_hai_captain_shield ])
    _declare_role_figure(km_s3f2,  9,  2, [ uruk_hai_w_crossbow ])
    _declare_role_figure(km_s3f2, 11,  3, [ uruk_hai_w_shield ])
    _declare_role_figure(km_s3f2, 22,  4, [ uruk_hai_w_pike ])

    #========================================================================
    km_s4 = Repo.insert! %Scenario{
      name: "The Wrath of Rohan",
      blurb: "Éomer's warband unwittingly helps Merry and Pippin escape to Fangorn forest.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 29, size: 53,
      map_width: 72, map_height: 48, location: :rohan
    }

    Repo.insert! %ScenarioResource{scenario_id: km_s4.id, resource_type: :source, book: :km, title: "Kingdoms of Men", sort_order: 4, page: 47}

    km_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: km_s4.id, faction: :rohan, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(km_s4f1,  1,  1, [ eomer_horse ])
    _declare_role_figure(km_s4f1,  1,  2, "Rohan Captain on horse with shield", [ rohan_captain_horse ])
    _declare_role_figure(km_s4f1,  1,  3, [ merry ])
    _declare_role_figure(km_s4f1,  1,  4, [ pippin ])
    _declare_role_figure(km_s4f1,  4,  5, [ rohan_rider_spear ])
    _declare_role_figure(km_s4f1, 10,  6, [ rohan_rider ])

    km_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: km_s4.id, faction: :isengard, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(km_s4f1,  1,  1, [ ugluk ])
    _declare_role_figure(km_s4f1,  1,  2, [ mauhur ])
    _declare_role_figure(km_s4f1, 17,  3, [ uruk_hai_s_sword_shield ])
    _declare_role_figure(km_s4f1, 16,  4, [ uruk_hai_s_bow ])

    #########################################################################
    # MORIA AND ANGMAR
    #########################################################################

    #========================================================================
    ma_s1 = Repo.insert! %Scenario{
      name: "They Are Coming...",
      blurb: "A Balrog-led Goblin force defeats the last remnants of Balin's Kingdom of Moria.",
      date_age: 3, date_year: 2994, date_month: 0, date_day: 0, size: 47,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: ma_s1.id, resource_type: :source, book: :ma, title: "Moria & Angmar", sort_order: 1, page: 44}

    ma_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: ma_s1.id, faction: :durins_folk, suggested_points: 300, actual_points: 293, sort_order: 1}
    _declare_role_figure(ma_s1f1, 1,  1, [ dwarf_captain_shield ])
    _declare_role_figure(ma_s1f1, 4,  2, [ dwarf_w_shield ])
    _declare_role_figure(ma_s1f1, 4,  3, [ dwarf_w_bow ])
    _declare_role_figure(ma_s1f1, 4,  4, [ dwarf_w_2h ])
    _declare_role_figure(ma_s1f1, 5,  5, [ dwarf_khazad_gd ])

    ma_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: ma_s1.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(ma_s1f2, 1,  1, "Balrog", [ balrog, balrog_plastic, balrog_whip ])
    _declare_role_figure(ma_s1f2, 3,  2, "Moria Goblin Captains with shield", [ moria_captain ])
    _declare_role_figure(ma_s1f2, 8,  3, [ moria_g_spear ])
    _declare_role_figure(ma_s1f2, 8,  4, [ moria_g_bow ])
    _declare_role_figure(ma_s1f2, 9,  5, [ moria_g_shield ])

    #========================================================================
    ma_s2 = Repo.insert! %Scenario{
      name: "The Bridge of Khazad-dûm",
      blurb: "Gandalf faces down the Balrog.",
      date_age: 3, date_year: 3019, date_month: 1, date_day: 15, size: 38,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: ma_s2.id, resource_type: :source, book: :ma, title: "Moria & Angmar", sort_order: 2, page: 45}

    ma_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: ma_s2.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(ma_s2f1, 1,  1, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(ma_s2f1, 1,  2, "Aragorn with bow", [ aragorn ])
    _declare_role_figure(ma_s2f1, 1,  3, [ boromir ])
    _declare_role_figure(ma_s2f1, 1,  4, [ legolas ])
    _declare_role_figure(ma_s2f1, 1,  5, "Gimli", gimli_all_foot)
    _declare_role_figure(ma_s2f1, 1,  6, "Frodo with Sting and mithril coat", [ frodo ])
    _declare_role_figure(ma_s2f1, 1,  7, [ sam ])
    _declare_role_figure(ma_s2f1, 1,  8, [ merry ])
    _declare_role_figure(ma_s2f1, 1,  9, [ pippin ])

    ma_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: ma_s2.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(ma_s2f2, 1,  1, "Balrog", [ balrog, balrog_plastic, balrog_whip ])
    _declare_role_figure(ma_s2f2, 2,  2, "Moria Goblin Captains with shield", [ moria_captain ])
    _declare_role_figure(ma_s2f2, 1,  1, [ moria_shaman ])
    _declare_role_figure(ma_s2f2, 8,  5, [ moria_g_spear ])
    _declare_role_figure(ma_s2f2, 8,  6, [ moria_g_bow ])
    _declare_role_figure(ma_s2f2, 9,  7, [ moria_g_shield ])

    #========================================================================
    ma_s3 = Repo.insert! %Scenario{
      name: "Flight to Lothlórien",
      blurb: "The Moria force hunting for the Fellowship become the hunted.",
      date_age: 3, date_year: 3019, date_month: 1, date_day: 15, size: 93,
      map_width: 48, map_height: 48, location: :lothlorien
    }

    Repo.insert! %ScenarioResource{scenario_id: ma_s3.id, resource_type: :source, book: :ma, title: "Moria & Angmar", sort_order: 3, page: 46}

    ma_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: ma_s3.id, faction: :lothlorien, suggested_points: 500, actual_points: 494, sort_order: 1}
    _declare_role_figure(ma_s3f1, 2,  1, "Galadhrim Captains with Elven blade", [ galadhrim_captain ])
    _declare_role_figure(ma_s3f1, 1,  2, "Wood Elf Captain with Elf bow", [ wood_elf_captain ])
    _declare_role_figure(ma_s3f1, 5,  3, [ galadhrim_w_bow ])
    _declare_role_figure(ma_s3f1, 4,  4, [ galadhrim_w_blade ])
    _declare_role_figure(ma_s3f1, 8,  5, [ wood_elf_w_blade ])
    _declare_role_figure(ma_s3f1, 8,  6, [ wood_elf_w_spear ])
    _declare_role_figure(ma_s3f1, 8,  7, [ wood_elf_w_bow ])

    ma_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: ma_s3.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(ma_s3f2,  3,  1, "Moria Captains with shield", [ moria_captain ])
    _declare_role_figure(ma_s3f2,  1,  2, [ warg_chieftain ])
    _declare_role_figure(ma_s3f2, 12,  3, [ moria_g_shield ])
    _declare_role_figure(ma_s3f2, 12,  4, [ moria_g_spear ])
    _declare_role_figure(ma_s3f2, 12,  5, [ moria_g_bow ])
    _declare_role_figure(ma_s3f2, 15,  6, [ warg ])

    #========================================================================
    ma_s4 = Repo.insert! %Scenario{
      name: "Fog on the Barrow Downs",
      blurb: "The wights of Angmar attack Frodo's band.",
      date_age: 3, date_year: 3018, date_month: 9, date_day: 28, size: 9,
      map_width: 48, map_height: 48, location: :eriador
    }

    Repo.insert! %ScenarioResource{scenario_id: ma_s4.id, resource_type: :source, book: :ma, title: "Moria & Angmar", sort_order: 4, page: 47}

    ma_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: ma_s4.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(ma_s4f1, 1,  1, [ frodo ])
    _declare_role_figure(ma_s4f1, 1,  1, [ sam ])
    _declare_role_figure(ma_s4f1, 1,  1, [ merry ])
    _declare_role_figure(ma_s4f1, 1,  1, [ pippin ])
    _declare_role_figure(ma_s4f1, 1,  1, [ tom_bombadil ])

    ma_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: ma_s4.id, faction: :angmar, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(ma_s4f2, 4,  1, [ barrow_wight ])

    #########################################################################
    # THE RETURN OF THE KING
    #########################################################################

    #========================================================================
    rotk_s1 = Repo.insert! %Scenario{
      name: "Skirmish in Osgiliath",
      blurb: "Gondor repulses a minor Orc incursion",
      date_age: 3, date_year: 3018, date_month: 6, date_day: 20, size: 48,
      map_width: 48, map_height: 48, location: :osgiliath
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s1.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 1, page: 99}

    rotk_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s1.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s1f1, 8, 1, [ gondor_womt_shield ])
    _declare_role_figure(rotk_s1f1, 8, 2, [ gondor_womt_spear_shield ])
    _declare_role_figure(rotk_s1f1, 8, 3, [ gondor_womt_bow])

    rotk_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s1.id, faction: :minas_morgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s1f2, 8, 1, [ orc_w_shield ])
    _declare_role_figure(rotk_s1f2, 8, 2, [ orc_w_spear ])
    _declare_role_figure(rotk_s1f2, 4, 3, [ orc_w_bow ])
    _declare_role_figure(rotk_s1f2, 4, 4, [ orc_w_2h ])

    #========================================================================
    rotk_s2 = Repo.insert! %Scenario{
      name: "Rearguard",
      blurb: "The remnants of Gondor's Osgiliath troops fight to delay Mordor's army as long as possible.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 10, size: 48,
      map_width: 48, map_height: 48, location: :osgiliath
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s2.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 2, page: 100}

    rotk_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s2.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s2f1, 8, 1, [ gondor_womt_shield ])
    _declare_role_figure(rotk_s2f1, 8, 2, [ gondor_womt_spear_shield ])
    _declare_role_figure(rotk_s2f1, 8, 3, [ gondor_womt_bow])

    rotk_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s2.id, faction: :minas_morgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s2f2, 8, 1, [ orc_w_shield ])
    _declare_role_figure(rotk_s2f2, 8, 2, [ orc_w_spear ])
    _declare_role_figure(rotk_s2f2, 4, 3, [ orc_w_bow ])
    _declare_role_figure(rotk_s2f2, 4, 4, [ orc_w_2h ])

    #========================================================================
    rotk_s3 = Repo.insert! %Scenario{
      name: "In the Clutches of Shelob",
      blurb: "Sam and Frodo try to escape from Shelob's lair.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 12, size: 3,
      map_width: 48, map_height: 48, location: :minas_morgul
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s3.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 3, page: 101}

    rotk_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s3.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s3f1, 1, 1, [ frodo ])
    _declare_role_figure(rotk_s3f1, 1, 2, [ sam ])

    rotk_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s3.id, faction: :cirith_ungol, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s3f2, 1, 1, [ shelob ])

    #========================================================================
    rotk_s4 = Repo.insert! %Scenario{
      name: "The Pride of Gondor",
      blurb: "Faramir makes a doomed attempt to recapture Osgiliath.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 13, size: 37,
      map_width: 72, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s4.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 4, page: 102}

    rotk_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s4.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s4f1,  1, 1, [ faramir_armor_horse ])
    _declare_role_figure(rotk_s4f1, 14, 2, [ gondor_knight ])
    _declare_role_figure(rotk_s4f1,  1, 3, [ gondor_knight_banner ])

    rotk_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s4.id, faction: :minas_morgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s4f2,  1, 1, [ ringwraith_fellbeast ])
    _declare_role_figure(rotk_s4f2, 19, 2, [ orc_w_bow ])
    _declare_role_figure(rotk_s4f2,  1, 3, [ orc_w_banner ])

    #========================================================================
    rotk_s5 = Repo.insert! %Scenario{
      name: "The White Rider",
      blurb: "Gandalf leads a charge out to rescue Faramir.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 13, size: 8,
      map_width: 72, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s5.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 5, page: 103}
    _declare_video_replay(rotk_s5.id, "https://www.youtube.com/watch?v=DzIvlS3QmaU&list=PLa_Dq2-Vx86KjLv5JCpygwNALLzzh5zG9&index=6", "Mid-Sussex Wargamers", 1)

    rotk_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s5.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s5f1,  1, 1, "Gandalf the White on Shadowfax", [ gandalf_white_horse, gandalf_white_horse_mt ])
    _declare_role_figure(rotk_s5f1,  1, 2, [ faramir_armor_horse ])
    _declare_role_figure(rotk_s5f1,  4, 3, [ gondor_knight ])

    rotk_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s5.id, faction: :nazgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s5f2,  2, 1, [ ringwraith_fellbeast ])

    #========================================================================
    rotk_s6 = Repo.insert! %Scenario{
      name: "Minas Tirith",
      blurb: "The garrison of Minas Tirith defends their city against the invading army of Mordor.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 14, size: 72,
      map_width: 72, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s6.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 6, page: 104}

    rotk_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s6.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s6f1,  1, 1, "Gandalf the White on Shadowfax", [ gandalf_white_horse, gandalf_white_horse_mt ])
    _declare_role_figure(rotk_s6f1,  1, 2, [ pippin_gondor ])
    _declare_role_figure(rotk_s6f1,  1, 3, [ gondor_captain_mt ])
    _declare_role_figure(rotk_s6f1,  8, 4, [ fountain_court_gd ])
    _declare_role_figure(rotk_s6f1,  6, 5, [ gondor_womt_shield ])
    _declare_role_figure(rotk_s6f1,  8, 6, [ gondor_womt_spear_shield ])
    _declare_role_figure(rotk_s6f1,  8, 7, [ gondor_womt_bow ])
    _declare_role_figure(rotk_s6f1,  2, 8, [ gondor_womt_banner ])

    rotk_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s6.id, faction: :minas_morgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s6f2,  1,  1, [ witch_king_fellbeast ])
    _declare_role_figure(rotk_s6f2,  1,  2, [ orc_captain ])
    _declare_role_figure(rotk_s6f2,  1,  3, [ mordor_troll ])
    _declare_role_figure(rotk_s6f2,  5,  4, [ easterling_w_shield_spear ])
    _declare_role_figure(rotk_s6f2,  5,  5, [ easterling_w_shield ])
    _declare_role_figure(rotk_s6f2,  6,  6, [ orc_w_shield ])
    _declare_role_figure(rotk_s6f2,  8,  7, [ orc_w_spear ])
    _declare_role_figure(rotk_s6f2,  4,  8, [ orc_w_bow ])
    _declare_role_figure(rotk_s6f2,  4,  9, [ orc_w_2h ])
    _declare_role_figure(rotk_s6f2,  2, 10, [ orc_w_banner ])

    #========================================================================
    rotk_s7 = Repo.insert! %Scenario{
      name: "The Charge of the Rohirrim",
      blurb: "Théoden arrives just in time to save Minas Tirith.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 72,
      map_width: 72, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s7.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 7, page: 105}

    rotk_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s7.id, faction: :rohan, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s7f1,  1,  1, [ eomer_horse ])
    _declare_role_figure(rotk_s7f1,  1,  2, [ theoden_horse ])
    _declare_role_figure(rotk_s7f1,  1,  3, [ gamling_horse ])
    _declare_role_figure(rotk_s7f1,  1,  4, [ eowyn_horse ])
    _declare_role_figure(rotk_s7f1,  1,  5, [ merry_rohan ])
    _declare_role_figure(rotk_s7f1,  1,  6, [ rohan_captain_horse ])
    _declare_role_figure(rotk_s7f1,  5,  7, [ rohan_gd_horse_spear ])
    _declare_role_figure(rotk_s7f1,  1,  8, [ rohan_gd_horse_banner ])
    _declare_role_figure(rotk_s7f1, 11,  9, [ rohan_rider ])
    _declare_role_figure(rotk_s7f1,  6, 10, [ rohan_rider_spear ])
    _declare_role_figure(rotk_s7f1,  1, 11, [ rohan_rider_banner ])

    rotk_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s7.id, faction: :minas_morgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s7f2,  4,  1, [ orc_captain ])
    _declare_role_figure(rotk_s7f2,  2,  2, [ mordor_troll ])
    _declare_role_figure(rotk_s7f2, 10,  3, [ orc_w_shield ])
    _declare_role_figure(rotk_s7f2, 12,  4, [ orc_w_spear ])
    _declare_role_figure(rotk_s7f2,  6,  5, [ orc_w_bow ])
    _declare_role_figure(rotk_s7f2,  6,  6, [ orc_w_2h ])
    _declare_role_figure(rotk_s7f2,  2,  7, [ orc_w_banner ])

    #========================================================================
    rotk_s8 = Repo.insert! %Scenario{
      name: "The Fate of Théoden",
      blurb: "Théoden tries to face down the Witch-King of Angmar.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 4,
      map_width: 48, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s8.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 8, page: 106}

    rotk_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s8.id, faction: :rohan, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s8f1,  1,  1, [ theoden_horse ])
    _declare_role_figure(rotk_s8f1,  1,  2, [ eowyn_horse ])
    _declare_role_figure(rotk_s8f1,  1,  3, [ merry_rohan ])

    rotk_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s8.id, faction: :nazgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s8f2,  1,  1, [ witch_king_fellbeast ])

    #========================================================================
    rotk_s9 = Repo.insert! %Scenario{
      name: "The Army of the Dead",
      blurb: "The Army of the Dead aids Aragorn on the Pelennor Fields.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 59,
      map_width: 72, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s9.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 9, page: 107}

    rotk_s9f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s9.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s9f1,  1,  1, [ aragorn ])
    _declare_role_figure(rotk_s9f1,  1,  2, [ legolas ])
    _declare_role_figure(rotk_s9f1,  1,  3, "Gimli", gimli_all_foot)
    _declare_role_figure(rotk_s9f1,  1,  4, [ king_dead ])
    _declare_role_figure(rotk_s9f1, 15,  5, [ dead_w ])

    rotk_s9f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s9.id, faction: :minas_morgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s9f2,  2,  1, [ orc_captain ])
    _declare_role_figure(rotk_s9f2,  2,  2, [ mordor_troll ])
    _declare_role_figure(rotk_s9f2, 10,  3, [ orc_w_shield ])
    _declare_role_figure(rotk_s9f2, 12,  4, [ orc_w_spear ])
    _declare_role_figure(rotk_s9f2,  6,  5, [ orc_w_2h ])
    _declare_role_figure(rotk_s9f2,  6,  6, [ orc_w_bow ])
    _declare_role_figure(rotk_s9f2,  2,  7, [ orc_w_banner ])

    #========================================================================
    rotk_s10 = Repo.insert! %Scenario{
      name: "The Battle of the Pelennor Fields",
      blurb: "The climax of the siege of Minas Tirith.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 117,
      map_width: 72, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s10.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 10, page: 108}

    rotk_s10f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s10.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s10f1,  1,  1, [ aragorn ])
    _declare_role_figure(rotk_s10f1,  1,  2, [ legolas ])
    _declare_role_figure(rotk_s10f1,  1,  3, "Gimli", gimli_all_foot)
    _declare_role_figure(rotk_s10f1,  1,  4, [ king_dead ])
    _declare_role_figure(rotk_s10f1,  9,  5, [ dead_w ])
    _declare_role_figure(rotk_s10f1,  1,  6, [ eomer_horse ])
    _declare_role_figure(rotk_s10f1,  1,  7, [ gamling_horse ])
    _declare_role_figure(rotk_s10f1,  7,  8, [ rohan_rider ])
    _declare_role_figure(rotk_s10f1,  4,  9, [ rohan_rider_spear ])
    _declare_role_figure(rotk_s10f1,  4, 10, [ rohan_gd_horse_spear ])
    _declare_role_figure(rotk_s10f1,  1, 11, [ rohan_rider_banner ])
    _declare_role_figure(rotk_s10f1,  1, 12, "Gandalf the White on Shadowfax", [ gandalf_white_horse, gandalf_white_horse_mt ])
    _declare_role_figure(rotk_s10f1,  1, 13, [ pippin_gondor ])
    _declare_role_figure(rotk_s10f1,  7, 14, [ gondor_womt_shield ])
    _declare_role_figure(rotk_s10f1,  8, 15, [ gondor_womt_spear_shield ])
    _declare_role_figure(rotk_s10f1,  8, 16, [ gondor_womt_bow ])
    _declare_role_figure(rotk_s10f1,  1, 17, [ gondor_womt_banner ])

    rotk_s10f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s10.id, faction: :minas_morgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s10f2,  2,  1, [ ringwraith_fellbeast ])
    _declare_role_figure(rotk_s10f2,  2,  2, [ orc_captain ])
    _declare_role_figure(rotk_s10f2,  1,  3, [ easterling_captain ])
    _declare_role_figure(rotk_s10f2,  2,  4, [ mordor_troll ])
    _declare_role_figure(rotk_s10f2,  5,  5, [ easterling_w_shield ])
    _declare_role_figure(rotk_s10f2,  9,  6, [ easterling_w_shield_spear ])
    _declare_role_figure(rotk_s10f2,  1,  7, [ easterling_w_banner ])
    _declare_role_figure(rotk_s10f2, 10,  8, [ orc_w_shield ])
    _declare_role_figure(rotk_s10f2, 12,  9, [ orc_w_spear ])
    _declare_role_figure(rotk_s10f2,  6, 10, [ orc_w_2h ])
    _declare_role_figure(rotk_s10f2,  6, 11, [ orc_w_bow ])
    _declare_role_figure(rotk_s10f2,  2, 12, [ orc_w_banner ])

    #========================================================================
    rotk_s11 = Repo.insert! %Scenario{
      name: "The Tower of Cirith Ungol",
      blurb: "Sam rescues Frodo as the garrison of Cirith Ungol destroys itself.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 14, size: 43,
      map_width: 48, map_height: 48, location: :minas_morgul
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s11.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 11, page: 110}

    rotk_s11f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s11.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s11f1,  1,  1, [ frodo ])
    _declare_role_figure(rotk_s11f1,  1,  2, [ sam ])
    _declare_role_figure(rotk_s11f1,  1,  3, [ shagrat ])
    _declare_role_figure(rotk_s11f1, 10,  4, [ m_uruk_hai_shield ])
    _declare_role_figure(rotk_s11f1,  5,  5, [ m_uruk_hai_2h ])

    rotk_s11f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s11.id, faction: :cirith_ungol, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s11f2,  1,  1, [ gorbag ])
    _declare_role_figure(rotk_s11f2,  8,  2, [ orc_w_shield ])
    _declare_role_figure(rotk_s11f2,  8,  3, [ orc_w_spear ])
    _declare_role_figure(rotk_s11f2,  4,  4, [ orc_w_2h ])
    _declare_role_figure(rotk_s11f2,  4,  5, [ orc_w_bow ])

    #========================================================================
    rotk_s12 = Repo.insert! %Scenario{
      name: "The Black Gate Opens",
      blurb: "The remnants of the Good forces at Minas Tirith at the the gates of Mordor to distract Sauron from Frodo's mission.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 25, size: 97,
      map_width: 48, map_height: 48, location: :mordor
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s12.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 12, page: 112}

    rotk_s12f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s12.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s12f1,  1,  1, [ aragorn ])
    _declare_role_figure(rotk_s12f1,  1,  2, "Gandalf the White", [ gandalf_white, gandalf_white_bgime, gandalf_white_pelennor ])
    _declare_role_figure(rotk_s12f1,  1,  3, [ legolas ])
    _declare_role_figure(rotk_s12f1,  1,  4, "Gimli", gimli_all_foot)
    _declare_role_figure(rotk_s12f1,  1,  5, [ eomer ])
    _declare_role_figure(rotk_s12f1,  1,  6, [ gamling ])
    _declare_role_figure(rotk_s12f1,  1,  7, [ pippin_gondor ])
    _declare_role_figure(rotk_s12f1,  1,  8, [ merry_rohan ])
    _declare_role_figure(rotk_s12f1,  1,  9, [ sam ])
    _declare_role_figure(rotk_s12f1,  1, 10, [ frodo ])
    _declare_role_figure(rotk_s12f1,  7, 11, [ rohan_rider ])
    _declare_role_figure(rotk_s12f1,  4, 12, [ rohan_rider_spear ])
    _declare_role_figure(rotk_s12f1,  1, 13, [ rohan_rider_banner ])
    _declare_role_figure(rotk_s12f1,  4, 14, [ rohan_gd_horse_spear ])
    _declare_role_figure(rotk_s12f1,  4, 15, [ gondor_knight ])
    _declare_role_figure(rotk_s12f1,  3, 16, [ gondor_womt_shield ])
    _declare_role_figure(rotk_s12f1,  4, 17, [ gondor_womt_spear_shield ])
    _declare_role_figure(rotk_s12f1,  4, 18, [ gondor_womt_bow ])
    _declare_role_figure(rotk_s12f1,  1, 19, [ gondor_womt_banner ])

    rotk_s12f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s12.id, faction: :black_gate, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s12f2,  1,  1, [ mouth ])
    _declare_role_figure(rotk_s12f2,  2,  1, [ ringwraith_fellbeast ])
    _declare_role_figure(rotk_s12f2,  1,  1, [ troll_chieftain ])
    _declare_role_figure(rotk_s12f2,  1,  1, [ orc_captain ])
    _declare_role_figure(rotk_s12f2,  1,  1, [ easterling_captain ])
    _declare_role_figure(rotk_s12f2,  1,  1, [ mordor_troll ])
    _declare_role_figure(rotk_s12f2, 11,  1, [ easterling_w_shield_spear ])
    _declare_role_figure(rotk_s12f2,  1,  1, [ easterling_w_banner ])
    _declare_role_figure(rotk_s12f2, 11,  2, [ orc_w_shield ])
    _declare_role_figure(rotk_s12f2, 12,  3, [ orc_w_spear ])
    _declare_role_figure(rotk_s12f2,  6,  4, [ orc_w_2h ])
    _declare_role_figure(rotk_s12f2,  6,  5, [ orc_w_bow ])
    _declare_role_figure(rotk_s12f2,  1,  5, [ orc_w_banner ])

    #========================================================================
    rotk_s13 = Repo.insert! %Scenario{
      name: "The Long Night",
      blurb: "A Dwarven trading party aids the locals in defending a northern village.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 11, size: 42,
      map_width: 48, map_height: 48, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s13.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 13, page: 122}

    rotk_s13f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s13.id, faction: :durins_folk, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s13f1,  1,  1, [ dwarf_captain ])
    _declare_role_figure(rotk_s13f1,  2,  2, [ dwarf_khazad_gd ])
    _declare_role_figure(rotk_s13f1,  4,  3, [ dwarf_w_shield ])
    _declare_role_figure(rotk_s13f1,  6,  4, [ dwarf_w_bow ])
    _declare_role_figure(rotk_s13f1,  1,  5, [ rohan_captain ])
    _declare_role_figure(rotk_s13f1,  4,  6, [ rohan_w_shield ])
    _declare_role_figure(rotk_s13f1,  4,  7, [ rohan_w_spear_shield ])
    _declare_role_figure(rotk_s13f1,  4,  8, [ rohan_w_bow ])

    rotk_s13f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s13.id, faction: :isengard, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s13f2,  1,  1, "Uruk-hai Captain", [ uruk_hai_captain_shield, uruk_hai_captain_2h ])
    _declare_role_figure(rotk_s13f2, 10,  2, [ uruk_hai_s_sword_shield ])
    _declare_role_figure(rotk_s13f2,  5,  3, [ uruk_hai_s_bow ])

    #========================================================================
    rotk_s14 = Repo.insert! %Scenario{
      name: "A Rock & a Hard Place",
      blurb: "Elves ambush a Goblin warband as they try to finish off a Dwarven king.",
      date_age: 3, date_year: 3017, date_month: 0, date_day: 0, size: 69,
      map_width: 72, map_height: 48, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s14.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 14, page: 124}

    rotk_s14f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s14.id, faction: :durins_folk, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s14f1,  1,  1, [ dwarf_king ])
    _declare_role_figure(rotk_s14f1,  1,  2, [ dwarf_captain ])
    _declare_role_figure(rotk_s14f1,  4,  3, [ dwarf_khazad_gd ])
    _declare_role_figure(rotk_s14f1,  6,  4, [ dwarf_w_shield ])
    _declare_role_figure(rotk_s14f1,  2,  5, [ dwarf_w_2h ])
    _declare_role_figure(rotk_s14f1,  4,  6, [ dwarf_w_bow ])
    _declare_role_figure(rotk_s14f1,  2,  7, [ dwarf_w_banner ])
    _declare_role_figure(rotk_s14f1, 10,  8, [ wood_elf_w_bow ])

    rotk_s14f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s14.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s14f2,  3,  1, [ moria_captain ])
    _declare_role_figure(rotk_s14f2, 12,  2, [ moria_g_spear ])
    _declare_role_figure(rotk_s14f2, 12,  3, [ moria_g_shield ])
    _declare_role_figure(rotk_s14f2, 12,  4, [ moria_g_bow ])

    #========================================================================
    rotk_s15 = Repo.insert! %Scenario{
      name: "Baruk Khâzad!",
      blurb: "Dáin Ironfoot (old version) leads a retaliatory raid against a marauding band of Orcs.",
      date_age: 3, date_year: 2980, date_month: 0, date_day: 0, size: 72,
      map_width: 48, map_height: 48, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s15.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 15, page: 126}

    rotk_s15f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s15.id, faction: :durins_folk, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s15f1,  1,  1, [ dain ])
    _declare_role_figure(rotk_s15f1,  1,  2, "Radagast the Brown", [ radagast_goblintown, radagast_lotr, radagast_sebastian ])
    _declare_role_figure(rotk_s15f1,  2,  3, [ dwarf_captain ])
    _declare_role_figure(rotk_s15f1,  6,  4, [ dwarf_khazad_gd ])
    _declare_role_figure(rotk_s15f1,  6,  5, [ dwarf_w_shield ])
    _declare_role_figure(rotk_s15f1,  4,  6, [ dwarf_w_2h ])
    _declare_role_figure(rotk_s15f1,  6,  7, [ dwarf_w_bow ])
    _declare_role_figure(rotk_s15f1,  2,  8, [ dwarf_w_banner ])

    rotk_s15f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s15.id, faction: :cirith_ungol, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s15f2,  2,  1, [ orc_captain ])
    _declare_role_figure(rotk_s15f2,  2,  2, [ orc_captain_warg ])
    _declare_role_figure(rotk_s15f2, 10,  3, [ orc_w_shield ])
    _declare_role_figure(rotk_s15f2,  6,  4, [ orc_w_bow ])
    _declare_role_figure(rotk_s15f2,  6,  5, [ orc_w_spear ])
    _declare_role_figure(rotk_s15f2,  6,  6, [ orc_w_2h ])
    _declare_role_figure(rotk_s15f2,  2,  7, [ orc_w_banner ])
    _declare_role_figure(rotk_s15f2,  5,  8, [ warg_rider_shield_spear ])
    _declare_role_figure(rotk_s15f2,  5,  9, [ warg_rider_bow ])

    #========================================================================
    rotk_s16 = Repo.insert! %Scenario{
      name: "Dáin's Last Stand",
      blurb: "The climactic battle of the War of the Ring in the north.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 25, size: 139,
      map_width: 48, map_height: 48, location: :erebor
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s16.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 16, page: 128}

    rotk_s16f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s16.id, faction: :durins_folk, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s16f1,  1,  1, [ dain ])
    _declare_role_figure(rotk_s16f1,  2,  2, [ dwarf_captain ])
    _declare_role_figure(rotk_s16f1,  8,  3, [ dwarf_khazad_gd ])
    _declare_role_figure(rotk_s16f1,  8,  4, [ dwarf_w_shield ])
    _declare_role_figure(rotk_s16f1,  5,  5, [ dwarf_w_2h ])
    _declare_role_figure(rotk_s16f1, 10,  6, [ dwarf_w_bow ])
    _declare_role_figure(rotk_s16f1,  2,  7, [ dwarf_w_banner ])
    _declare_role_figure(rotk_s16f1,  1,  8, [ king_of_men ])
    _declare_role_figure(rotk_s16f1,  8,  9, [ rohan_w_spear_shield ])
    _declare_role_figure(rotk_s16f1,  6, 10, [ rohan_w_shield ])
    _declare_role_figure(rotk_s16f1,  8, 11, [ rohan_w_bow ])
    _declare_role_figure(rotk_s16f1,  2, 12, [ rohan_w_banner ])

    rotk_s16f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s16.id, faction: :cirith_ungol, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s16f2,  2,  1, [ orc_captain ])
    _declare_role_figure(rotk_s16f2,  1,  2, "Uruk-hai Captain", [ uruk_hai_captain_shield, uruk_hai_captain_2h ])
    _declare_role_figure(rotk_s16f2,  1,  3, [ easterling_captain ])
    _declare_role_figure(rotk_s16f2,  6,  4, [ orc_w_shield ])
    _declare_role_figure(rotk_s16f2,  8,  5, [ orc_w_spear ])
    _declare_role_figure(rotk_s16f2,  4,  6, [ orc_w_bow ])
    _declare_role_figure(rotk_s16f2,  4,  7, [ orc_w_2h ])
    _declare_role_figure(rotk_s16f2,  2,  8, [ orc_w_banner ])
    _declare_role_figure(rotk_s16f2,  9,  9, [ uruk_hai_s_sword_shield ])
    _declare_role_figure(rotk_s16f2,  5, 10, [ uruk_hai_s_bow ])
    _declare_role_figure(rotk_s16f2,  1, 11, [ uruk_hai_w_banner ])
    _declare_role_figure(rotk_s16f2,  4, 12, [ uruk_hai_berserker ])
    _declare_role_figure(rotk_s16f2, 12, 13, [ warg_rider_shield_spear ])
    _declare_role_figure(rotk_s16f2,  8, 14, [ warg_rider_bow ])
    _declare_role_figure(rotk_s16f2, 10, 15, [ easterling_w_shield ])
    _declare_role_figure(rotk_s16f2,  5, 16, [ easterling_w_shield_spear ])
    _declare_role_figure(rotk_s16f2,  2, 17, [ mordor_troll ])

    #========================================================================
    rotk_s17 = Repo.insert! %Scenario{
      name: "Assault on Lothlorien",
      blurb: "The War of the Ring comes to Lothlorien.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 25, size: 117,
      map_width: 72, map_height: 48, location: :lothlorien
    }

    Repo.insert! %ScenarioResource{scenario_id: rotk_s17.id, resource_type: :source, book: :rotk, title: "Return of the King", sort_order: 17, page: 130}

    rotk_s17f1 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s17.id, faction: :lothlorien, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotk_s17f1,  1,  1, [ galadriel ])
    _declare_role_figure(rotk_s17f1,  1,  2, [ celeborn ])
    _declare_role_figure(rotk_s17f1,  2,  3, [ wood_elf_captain ])
    _declare_role_figure(rotk_s17f1, 10,  4, [ wood_elf_w_armor_bow ])
    _declare_role_figure(rotk_s17f1, 10,  5, [ wood_elf_w_armor_blade ])
    _declare_role_figure(rotk_s17f1, 17,  6, [ wood_elf_w_bow ])
    _declare_role_figure(rotk_s17f1,  3, 12, [ wood_elf_w_banner ])

    rotk_s17f2 = Repo.insert! %ScenarioFaction{scenario_id: rotk_s17.id, faction: :isengard, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotk_s17f2,  2,  1, "Uruk-hai Captain", [ uruk_hai_captain_shield, uruk_hai_captain_2h ])
    _declare_role_figure(rotk_s17f2,  2,  2, [ orc_captain ])
    _declare_role_figure(rotk_s17f2, 10,  3, [ uruk_hai_s_bow ])
    _declare_role_figure(rotk_s17f2,  8,  4, [ uruk_hai_s_sword_shield ])
    _declare_role_figure(rotk_s17f2,  2,  5, [ uruk_hai_w_banner ])
    _declare_role_figure(rotk_s17f2,  5,  6, [ uruk_hai_berserker ])
    _declare_role_figure(rotk_s17f2,  6,  7, [ orc_w_shield ])
    _declare_role_figure(rotk_s17f2,  8,  8, [ orc_w_spear ])
    _declare_role_figure(rotk_s17f2,  4,  9, [ orc_w_bow ])
    _declare_role_figure(rotk_s17f2,  4, 10, [ orc_w_2h ])
    _declare_role_figure(rotk_s17f2,  2, 11, [ orc_w_banner ])
    _declare_role_figure(rotk_s17f2,  6, 12, [ warg_rider_shield_spear ])
    _declare_role_figure(rotk_s17f2,  6, 13, [ warg_rider_bow ])
    _declare_role_figure(rotk_s17f2,  2, 14, [ mordor_troll ])

    #########################################################################
    # THE RETURN OF THE KING JOURNEYBOOK
    #########################################################################

    #========================================================================
    rotkjb_s1 = Repo.insert! %Scenario{
      name: "Shelob's Lair",
      blurb: "Gollum leads Frodo and Sam into the lair of the giant spider.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 12, size: 4,
      map_width: 48, map_height: 48, location: :minas_morgul
    }

    Repo.insert! %ScenarioResource{scenario_id: rotkjb_s1.id, resource_type: :source, book: :rotk_jb, title: "Return of the King Journeybook", sort_order: 1, page: 12}

    rotkjb_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s1.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s1f1, 1, 1, [ frodo ])
    _declare_role_figure(rotkjb_s1f1, 1, 2, [ sam ])

    rotkjb_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s1.id, faction: :cirith_ungol, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s1f2, 1, 1, [ shelob ])
    _declare_role_figure(rotkjb_s1f2, 1, 2, [ gollum ])

    #========================================================================
    rotkjb_s2 = Repo.insert! %Scenario{
      name: "Ride of the Rohirrim",
      blurb: "The Druadan help the Rohirrim through their forest to bypass the bulk of the Mordor forces.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 13, size: 91,
      map_width: 48, map_height: 24, location: :gondor
    }

    Repo.insert! %ScenarioResource{scenario_id: rotkjb_s2.id, resource_type: :source, book: :rotk_jb, title: "Return of the King Journeybook", sort_order: 2, page: 20}

    rotkjb_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s2.id, faction: :rohan, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s2f1,  1, 1, [ theoden_armor_horse ])
    _declare_role_figure(rotkjb_s2f1,  1, 2, [ ghan_buri_ghan ])
    _declare_role_figure(rotkjb_s2f1,  9, 3, [ wose ])
    _declare_role_figure(rotkjb_s2f1,  1, 4, [ eomer_horse ])
    _declare_role_figure(rotkjb_s2f1, 13, 5, [ rohan_rider ])
    _declare_role_figure(rotkjb_s2f1,  3, 6, [ rohan_rider_spear ])

    rotkjb_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s2.id, faction: :minas_morgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s2f2,  3,  1, "Orc Captains with shield", [ orc_captain ])
    _declare_role_figure(rotkjb_s2f2, 12,  2, [ orc_w_shield ])
    _declare_role_figure(rotkjb_s2f2, 12,  3, [ orc_w_spear ])
    _declare_role_figure(rotkjb_s2f2,  6,  4, [ orc_w_bow ])
    _declare_role_figure(rotkjb_s2f2,  6,  5, [ orc_w_2h ])
    _declare_role_figure(rotkjb_s2f2,  6,  6, [ orc_m_shield ])
    _declare_role_figure(rotkjb_s2f2,  6,  7, [ orc_m_spear ])
    _declare_role_figure(rotkjb_s2f2,  4,  8, [ warg_rider_shield ])
    _declare_role_figure(rotkjb_s2f2,  4,  9, [ warg_rider_spear ])
    _declare_role_figure(rotkjb_s2f2,  4, 10, [ warg_rider_bow ])

    #========================================================================
    rotkjb_s3 = Repo.insert! %Scenario{
      name: "The Rescue of Faramir",
      blurb: "Gandalf and Imrahil ride out to save Faramir and his troops from a Ringwraith on a Fell beast.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 13, size: 106,
      map_width: 48, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotkjb_s3.id, resource_type: :source, book: :rotk_jb, title: "Return of the King Journeybook", sort_order: 3, page: 34}

    rotkjb_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s3.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s3f1,  1,  1, [ faramir_armor_horse ])
    _declare_role_figure(rotkjb_s3f1,  1,  2, "Gandalf the White on Shadowfax", [ gandalf_white_horse, gandalf_white_horse_mt ])
    _declare_role_figure(rotkjb_s3f1,  1,  3, [ imrahil_horse ])
    _declare_role_figure(rotkjb_s3f1,  1,  4, [ gondor_captain_mt ])
    _declare_role_figure(rotkjb_s3f1,  8,  5, [ gondor_womt_spear_shield ])
    _declare_role_figure(rotkjb_s3f1,  8,  6, [ gondor_womt_shield ])
    _declare_role_figure(rotkjb_s3f1,  8,  7, [ gondor_womt_bow ])
    _declare_role_figure(rotkjb_s3f1,  4,  8, [ gondor_rog ])
    _declare_role_figure(rotkjb_s3f1,  5,  9, [ gondor_knight_shield ])
    _declare_role_figure(rotkjb_s3f1,  1, 10, [ gondor_knight_banner ])
    _declare_role_figure(rotkjb_s3f1,  6, 11, "Knight of Dol Amroth on horse with lance", [ gondor_knight_da_horse ])

    rotkjb_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s3.id, faction: :minas_morgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s3f2,  1,  1, [ ringwraith_fellbeast ])
    _declare_role_figure(rotkjb_s3f2,  2,  2, "Orc Captains with shield", [ orc_captain ])
    _declare_role_figure(rotkjb_s3f2,  8,  3, [ orc_w_shield ])
    _declare_role_figure(rotkjb_s3f2,  8,  4, [ orc_w_spear ])
    _declare_role_figure(rotkjb_s3f2,  4,  5, [ orc_w_bow ])
    _declare_role_figure(rotkjb_s3f2,  4,  6, [ orc_w_2h ])
    _declare_role_figure(rotkjb_s3f2,  5,  7, [ orc_m_shield ])
    _declare_role_figure(rotkjb_s3f2,  5,  8, [ orc_m_spear ])
    _declare_role_figure(rotkjb_s3f2,  2,  9, [ warg_rider_shield ])
    _declare_role_figure(rotkjb_s3f2,  2, 10, [ warg_rider_spear ])
    _declare_role_figure(rotkjb_s3f2,  2, 11, [ warg_rider_bow ])
    _declare_role_figure(rotkjb_s3f2,  1, 12, "Haradrim Chieftain with spear", [ harad_chieftain ])
    _declare_role_figure(rotkjb_s3f2,  6, 13, [ harad_w_spear ])
    _declare_role_figure(rotkjb_s3f2,  6, 14, [ harad_w_bow ])
    _declare_role_figure(rotkjb_s3f2,  3, 15, [ harad_raider ])
    _declare_role_figure(rotkjb_s3f2,  3, 16, [ harad_raider_lance ])

    #========================================================================
    rotkjb_s4 = Repo.insert! %Scenario{
      name: "The Walls of Minas Tirith",
      blurb: "The forces of Mordor lay siege to Minas Tirith.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 14, size: 67,
      map_width: 48, map_height: 24, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotkjb_s4.id, resource_type: :source, book: :rotk_jb, title: "Return of the King Journeybook", sort_order: 4, page: 48}

    rotkjb_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s4.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s4f1,  1,  1, "Gandalf the White", [ gandalf_white, gandalf_white_bgime, gandalf_white_pelennor ])
    _declare_role_figure(rotkjb_s4f1,  1,  2, [ pippin_gondor ])
    _declare_role_figure(rotkjb_s4f1,  1,  3, [ forlong ])
    _declare_role_figure(rotkjb_s4f1,  8,  4, [ gondor_womt_shield ])
    _declare_role_figure(rotkjb_s4f1,  8,  5, [ gondor_womt_spear_shield ])
    _declare_role_figure(rotkjb_s4f1,  8,  6, [ gondor_womt_bow ])
    _declare_role_figure(rotkjb_s4f1,  1,  7, [ gondor_womt_banner ])
    _declare_role_figure(rotkjb_s4f1,  3,  8, [ axemen_lossarnach ])
    _declare_role_figure(rotkjb_s4f1,  6,  9, [ clansmen_lamedon ])

    rotkjb_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s4.id, faction: :minas_morgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s4f2,  1,  1, "Orc Captain with shield", [ orc_captain ])
    _declare_role_figure(rotkjb_s4f2,  4,  2, [ orc_w_spear ])
    _declare_role_figure(rotkjb_s4f2,  4,  3, [ orc_w_shield ])
    _declare_role_figure(rotkjb_s4f2,  2,  4, [ orc_w_bow ])
    _declare_role_figure(rotkjb_s4f2,  2,  5, [ orc_w_2h ])
    _declare_role_figure(rotkjb_s4f2,  3,  6, [ orc_m_shield ])
    _declare_role_figure(rotkjb_s4f2,  3,  7, [ orc_m_spear ])
    _declare_role_figure(rotkjb_s4f2,  1,  8, [ easterling_captain ])
    _declare_role_figure(rotkjb_s4f2,  4,  9, [ easterling_w_shield ])
    _declare_role_figure(rotkjb_s4f2,  4, 10, [ easterling_w_bow ])
    _declare_role_figure(rotkjb_s4f2,  2, 11, [ easterling_w_shield_spear ])
    _declare_role_figure(rotkjb_s4f2,  1, 12, [ war_catapult ])
    _declare_role_figure(rotkjb_s4f2,  3, 13, [ war_catapult_orc ])
    _declare_role_figure(rotkjb_s4f2,  1, 14, [ war_catapult_troll ])

    #========================================================================
    rotkjb_s5 = Repo.insert! %Scenario{
      name: "The White Rider and the Black",
      blurb: "The Witch-King of Angmar confronts Gandalf at the Gate of Minas Tirith.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 83,
      map_width: 48, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotkjb_s5.id, resource_type: :source, book: :rotk_jb, title: "Return of the King Journeybook", sort_order: 5, page: 50}

    rotkjb_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s5.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s5f1,  1,  1, "Gandalf the White", [ gandalf_white, gandalf_white_bgime, gandalf_white_pelennor ])
    _declare_role_figure(rotkjb_s5f1,  1,  2, [ pippin_gondor ])
    _declare_role_figure(rotkjb_s5f1,  1,  3, [ imrahil ])
    _declare_role_figure(rotkjb_s5f1,  7,  4, [ gondor_womt_shield ])
    _declare_role_figure(rotkjb_s5f1,  8,  5, [ gondor_womt_spear_shield ])
    _declare_role_figure(rotkjb_s5f1,  8,  6, [ gondor_womt_bow ])
    _declare_role_figure(rotkjb_s5f1,  1,  7, [ gondor_womt_banner ])
    _declare_role_figure(rotkjb_s5f1,  9,  8, [ gondor_knight_da_foot ])

    rotkjb_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s5.id, faction: :minas_morgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s5f2,  1,  1, [ witch_king_horse ])
    _declare_role_figure(rotkjb_s5f2,  2,  1, "Orc Captains with shield", [ orc_captain ])
    _declare_role_figure(rotkjb_s5f2,  8,  2, [ orc_w_spear ])
    _declare_role_figure(rotkjb_s5f2,  8,  3, [ orc_w_shield ])
    _declare_role_figure(rotkjb_s5f2,  4,  4, [ orc_w_bow ])
    _declare_role_figure(rotkjb_s5f2,  4,  5, [ orc_w_2h ])
    _declare_role_figure(rotkjb_s5f2,  4,  6, [ orc_m_shield ])
    _declare_role_figure(rotkjb_s5f2,  4,  7, [ orc_m_spear ])
    _declare_role_figure(rotkjb_s5f2,  1,  8, [ easterling_captain ])
    _declare_role_figure(rotkjb_s5f2,  4,  9, [ easterling_w_shield ])
    _declare_role_figure(rotkjb_s5f2,  4, 10, [ easterling_w_bow ])
    _declare_role_figure(rotkjb_s5f2,  2, 11, [ easterling_w_shield_spear ])

    #========================================================================
    rotkjb_s6 = Repo.insert! %Scenario{
      name: "The Horse and the Serpent",
      blurb: "The Rohirrim encounter the Southrons on the Pelennor Fields.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 46,
      map_width: 48, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotkjb_s6.id, resource_type: :source, book: :rotk_jb, title: "Return of the King Journeybook", sort_order: 6, page: 52}

    rotkjb_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s6.id, faction: :rohan, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s6f1,  1,  1, [ theoden_armor_horse ])
    _declare_role_figure(rotkjb_s6f1,  1,  2, [ gamling_horse ])
    _declare_role_figure(rotkjb_s6f1,  1,  3, [ eowyn_horse ])
    _declare_role_figure(rotkjb_s6f1,  1,  4, [ merry_rohan ])
    _declare_role_figure(rotkjb_s6f1,  1,  5, [ eomer_horse ])
    _declare_role_figure(rotkjb_s6f1, 13,  6, [ rohan_rider ])
    _declare_role_figure(rotkjb_s6f1,  3,  7, [ rohan_rider_spear ])

    rotkjb_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s6.id, faction: :harad, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s6f2,  1,  1, "Suladân the Serpent Lord on horse with lance", [ suladan_horse ])
    _declare_role_figure(rotkjb_s6f2,  2,  2, "Haradrim Chieftain on horse with lance", [ harad_chieftain_horse ])
    _declare_role_figure(rotkjb_s6f2,  6,  3, [ harad_raider ])
    _declare_role_figure(rotkjb_s6f2,  6,  4, [ harad_raider_lance ])
    _declare_role_figure(rotkjb_s6f2, 10,  5, [ serpent_rider ])

    #========================================================================
    rotkjb_s7 = Repo.insert! %Scenario{
      name: "The Death of Kings",
      blurb: "Théoden faces off against the Witch-King of Angmar.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 4,
      map_width: 48, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotkjb_s7.id, resource_type: :source, book: :rotk_jb, title: "Return of the King Journeybook", sort_order: 7, page: 54}

    rotkjb_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s7.id, faction: :rohan, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s7f1,  1,  1, [ theoden_armor_horse ])
    _declare_role_figure(rotkjb_s7f1,  1,  2, [ eowyn_horse ])
    _declare_role_figure(rotkjb_s7f1,  1,  3, [ merry_rohan ])

    rotkjb_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s7.id, faction: :nazgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s7f2,  1,  1, [ witch_king_fellbeast ])

    #========================================================================
    rotkjb_s8 = Repo.insert! %Scenario{
      name: "The Glory of Dol Amroth",
      blurb: "Prince Imrahil rides out from Minas Tirith.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 140,
      map_width: 48, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotkjb_s8.id, resource_type: :source, book: :rotk_jb, title: "Return of the King Journeybook", sort_order: 8, page: 56}

    rotkjb_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s8.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s8f1,  1,  1, [ imrahil_horse ])
    _declare_role_figure(rotkjb_s8f1,  9,  2, [ gondor_knight_shield ])
    _declare_role_figure(rotkjb_s8f1,  9,  3, "Knights of Dol Amroth on horse with lance", [ gondor_knight_da_horse ])
    _declare_role_figure(rotkjb_s8f1,  8,  4, [ gondor_womt_shield ])
    _declare_role_figure(rotkjb_s8f1,  8,  5, [ gondor_womt_spear_shield ])
    _declare_role_figure(rotkjb_s8f1,  8,  6, [ gondor_womt_bow ])
    _declare_role_figure(rotkjb_s8f1, 12,  7, "Men-at-arms of Dol Amroth with lance", [ maa_da ])

    rotkjb_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s8.id, faction: :easterlings, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s8f2,  1,  1, "Orc Captain with shield", [ orc_captain ])
    _declare_role_figure(rotkjb_s8f2,  1,  2, "Khandish Chieftain with bow", [ khandish_chieftain ])
    _declare_role_figure(rotkjb_s8f2,  1,  3, [ easterling_captain ])
    _declare_role_figure(rotkjb_s8f2, 12,  4, [ orc_w_shield ])
    _declare_role_figure(rotkjb_s8f2, 12,  5, [ orc_w_spear ])
    _declare_role_figure(rotkjb_s8f2,  6,  6, [ orc_w_bow ])
    _declare_role_figure(rotkjb_s8f2,  6,  7, [ orc_w_2h ])
    _declare_role_figure(rotkjb_s8f2,  5,  8, [ orc_m_spear ])
    _declare_role_figure(rotkjb_s8f2,  5,  9, [ orc_m_shield ])
    _declare_role_figure(rotkjb_s8f2,  8, 10, [ easterling_w_shield ])
    _declare_role_figure(rotkjb_s8f2,  8, 11, [ easterling_w_bow ])
    _declare_role_figure(rotkjb_s8f2,  4, 12, [ easterling_w_shield_spear ])
    _declare_role_figure(rotkjb_s8f2, 10, 13, [ khandish_w_axe ])
    _declare_role_figure(rotkjb_s8f2,  6, 14, [ khandish_w_bow ])

    #========================================================================
    rotkjb_s9 = Repo.insert! %Scenario{
      name: "Charge of the Mûmakil",
      blurb: "Éomer and the Rohirrim are counterattacked by Oliphaunts.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 61,
      map_width: 48, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotkjb_s9.id, resource_type: :source, book: :rotk_jb, title: "Return of the King Journeybook", sort_order: 9, page: 60}

    rotkjb_s9f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s9.id, faction: :rohan, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s9f1,  1,  1, "Éomer, Marshal of the Riddermark on horse", [ eomer_horse ])
    _declare_role_figure(rotkjb_s9f1,  2,  2, "Captain of Rohan on horse with shield", [ rohan_captain_horse ])
    _declare_role_figure(rotkjb_s9f1, 18,  3, [ rohan_rider ])
    _declare_role_figure(rotkjb_s9f1,  6,  4, [ rohan_rider_spear ])
    _declare_role_figure(rotkjb_s9f1,  5,  5, [ rohan_gd_horse_spear ])
    _declare_role_figure(rotkjb_s9f1,  1,  6, [ rohan_gd_horse_banner ])

    rotkjb_s9f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s9.id, faction: :harad, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s9f2,  2,  1,  [ mumak ])
    _declare_role_figure(rotkjb_s9f2,  2,  2,  [ mumak_mahud ])
    _declare_role_figure(rotkjb_s9f2, 12,  3,  [ harad_w_spear ])
    _declare_role_figure(rotkjb_s9f2, 12,  4,  [ harad_w_bow ])

    #========================================================================
    rotkjb_s10 = Repo.insert! %Scenario{
      name: "The Return of the King",
      blurb: "Aragorn arrives at the Pelennor Fields just in the nick of time.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 92,
      map_width: 48, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotkjb_s10.id, resource_type: :source, book: :rotk_jb, title: "Return of the King Journeybook", sort_order: 10, page: 66}

    rotkjb_s10f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s10.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s10f1,  1,  1, "Aragorn with Andúril", [ aragorn ])
    _declare_role_figure(rotkjb_s10f1,  1,  2, [ legolas ])
    _declare_role_figure(rotkjb_s10f1,  1,  3, "Gimli", gimli_all_foot)
    _declare_role_figure(rotkjb_s10f1,  1,  4, [ angbor ])
    _declare_role_figure(rotkjb_s10f1,  8,  5, [ ranger_north ])
    _declare_role_figure(rotkjb_s10f1,  4,  6, [ ranger_north_spear ])
    _declare_role_figure(rotkjb_s10f1, 12,  7, [ axemen_lossarnach ])
    _declare_role_figure(rotkjb_s10f1, 11,  8, [ clansmen_lamedon ])

    rotkjb_s10f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s10.id, faction: :minas_morgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s10f2,  1,  1, [ gothmog ])
    _declare_role_figure(rotkjb_s10f2,  1,  2, [ troll_chieftain ])
    _declare_role_figure(rotkjb_s10f2,  1,  3, [ m_orc_captain ])
    _declare_role_figure(rotkjb_s10f2,  8,  4, [ orc_w_shield ])
    _declare_role_figure(rotkjb_s10f2,  8,  5, [ orc_w_spear ])
    _declare_role_figure(rotkjb_s10f2,  4,  6, [ orc_w_bow ])
    _declare_role_figure(rotkjb_s10f2,  4,  7, [ orc_w_2h ])
    _declare_role_figure(rotkjb_s10f2, 12,  8, [ orc_m_spear ])
    _declare_role_figure(rotkjb_s10f2, 12,  9, [ orc_m_shield ])
    _declare_role_figure(rotkjb_s10f2,  2, 10, [ mordor_troll ])

    #========================================================================
    rotkjb_s11 = Repo.insert! %Scenario{
      name: "The Pyre of Denethor",
      blurb: "Driven to madness, Denethor tries to burn the not-dead-yet-Faramir.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 7,
      map_width: 12, map_height: 12, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotkjb_s11.id, resource_type: :source, book: :rotk_jb, title: "Return of the King Journeybook", sort_order: 11, page: 70}

    rotkjb_s11f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s11.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s11f1,  1,  1, "Gandalf the White on Shadowfax", [ gandalf_white_horse, gandalf_white_horse_mt ])
    _declare_role_figure(rotkjb_s11f1,  1,  2, [ pippin_gondor ])
    _declare_role_figure(rotkjb_s11f1,  1,  3, [ beregond ])

    rotkjb_s11f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s11.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s11f2,  1,  1, [ denethor ])
    _declare_role_figure(rotkjb_s11f2,  3,  2, "Citadel Guard", [ gondor_citadel_gd_spear, gondor_citadel_gd_bow ])

    #========================================================================
    rotkjb_s12 = Repo.insert! %Scenario{
      name: "The Tower of Cirith Ungol",
      blurb: "The guards of Cirith Ungol fight over the captured Frodo and Sam and their gear.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 40,
      map_width: 48, map_height: 24, location: :minas_morgul
    }

    Repo.insert! %ScenarioResource{scenario_id: rotkjb_s12.id, resource_type: :source, book: :rotk_jb, title: "Return of the King Journeybook", sort_order: 12, page: 74}

    rotkjb_s12f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s12.id, faction: :cirith_ungol, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s12f1,  1,  1, [ frodo ])
    _declare_role_figure(rotkjb_s12f1,  1,  2, "Samwise the Brave with Elven cloak", [ sam ])
    _declare_role_figure(rotkjb_s12f1,  1,  3, [ shagrat ])
    _declare_role_figure(rotkjb_s12f1,  8,  4, [ m_uruk_hai ])
    _declare_role_figure(rotkjb_s12f1,  4,  5, [ m_uruk_hai_2h ])

    rotkjb_s12f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s12.id, faction: :cirith_ungol, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s12f2,  1,  1, [ gorbag ])
    _declare_role_figure(rotkjb_s12f2,  8,  2, [ orc_w_shield ])
    _declare_role_figure(rotkjb_s12f2,  8,  3, [ orc_w_spear ])
    _declare_role_figure(rotkjb_s12f2,  4,  4, [ orc_w_bow ])
    _declare_role_figure(rotkjb_s12f2,  4,  5, [ orc_w_2h ])

    #========================================================================
    rotkjb_s13 = Repo.insert! %Scenario{
      name: "The Black Gate Opens",
      blurb: "Aragorn and the bravest of the brave march to the very gates of Mordor to win time for Frodo to complete his quest.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 25, size: 37,
      map_width: 48, map_height: 48, location: :morannon
    }

    Repo.insert! %ScenarioResource{scenario_id: rotkjb_s13.id, resource_type: :source, book: :rotk_jb, title: "Return of the King Journeybook", sort_order: 13, page: 78}

    rotkjb_s13f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s13.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s13f1,  1,  1, "Aragorn the King", [ aragorn ])
    _declare_role_figure(rotkjb_s13f1,  1,  2, [ gwaihir ])
    _declare_role_figure(rotkjb_s13f1,  1,  3, "Gandalf the White", [ gandalf_white, gandalf_white_bgime, gandalf_white_pelennor ])
    _declare_role_figure(rotkjb_s13f1,  1,  4, "Éomer, Knight of the Pelennor", [ eomer ])
    _declare_role_figure(rotkjb_s13f1,  1,  5, [ eowyn_armor ])
    _declare_role_figure(rotkjb_s13f1,  1,  6, "Meriadoc, Knight of the Mark with Elven cloak and shield", [ merry_rohan ])
    _declare_role_figure(rotkjb_s13f1,  1,  7, [ erkenbrand ])
    _declare_role_figure(rotkjb_s13f1,  1,  8, "Peregrin, Guard of the Citade with Elven cloak", [ pippin_gondor ])
    _declare_role_figure(rotkjb_s13f1,  1,  9, [ imrahil ])
    _declare_role_figure(rotkjb_s13f1,  1, 10, [ forlong ])
    _declare_role_figure(rotkjb_s13f1,  1, 11, [ angbor ])
    _declare_role_figure(rotkjb_s13f1,  1, 12, [ elladan ])
    _declare_role_figure(rotkjb_s13f1,  1, 13, [ elrohir ])
    _declare_role_figure(rotkjb_s13f1,  1, 14, "Halbarad with Banner of Arwen Evenstar", [ halbarad ])

    rotkjb_s13f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s13.id, faction: :black_gate, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s13f2,  1,  1, [ troll_chieftain ])
    _declare_role_figure(rotkjb_s13f2,  3,  2, [ ringwraith_fellbeast ])
    _declare_role_figure(rotkjb_s13f2,  1,  3, [ mouth ])
    _declare_role_figure(rotkjb_s13f2, 13,  4, "Orc Captains with shield", [ orc_captain ])
    _declare_role_figure(rotkjb_s13f2,  2,  5, [ m_orc_captain ])
    _declare_role_figure(rotkjb_s13f2,  1,  6, [ m_orc_captain_2h ])
    _declare_role_figure(rotkjb_s13f2,  2,  7, [ mordor_troll ])

    #########################################################################
    # THE RUIN OF ARNOR
    #########################################################################

    #========================================================================
    roa_s1 = Repo.insert! %Scenario{
      name: "To Kill a King",
      blurb: "Arvedui and Malbeth try to survive an eerie assault on Fornost.",
      date_age: 3, date_year: 1974, date_month: 0, date_day: 0, size: 21,
      map_width: 36, map_height: 36, location: :fornost
    }

    Repo.insert! %ScenarioResource{scenario_id: roa_s1.id, resource_type: :source, book: :roa, title: "The Ruin of Arnor", sort_order: 1, page: 50}
    _declare_podcast(roa_s1.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-15-to-kill-a-king", "The Green Dragon", 1)
    _declare_video_replay(roa_s1.id, "https://www.youtube.com/watch?v=r-6UorJyEcU&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV&index=19", "Spillforeningen the Fellowship", 2)

    roa_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: roa_s1.id, faction: :arnor, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(roa_s1f1, 1, 1, [ arvedui ])
    _declare_role_figure(roa_s1f1, 1, 2, [ malbeth ])
    _declare_role_figure(roa_s1f1, 1, 3, [ arnor_captain ])
    _declare_role_figure(roa_s1f1, 9, 4, [ arnor_w ])

    roa_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: roa_s1.id, faction: :angmar, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(roa_s1f2, 1, 1, [ shade ])
    _declare_role_figure(roa_s1f2, 2, 2, [ barrow_wight ])
    _declare_role_figure(roa_s1f2, 6, 3, [ spectre ])

    #========================================================================
    roa_s2 = Repo.insert! %Scenario{
      name: "Flight Into the North",
      blurb: "Arvedui flees before the horror of Gûlavhar, the Terror of Arnor.",
      date_age: 3, date_year: 1975, date_month: 0, date_day: 0, size: 36,
      map_width: 72, map_height: 48, location: :arnor
    }

    Repo.insert! %ScenarioResource{scenario_id: roa_s2.id, resource_type: :source, book: :roa, title: "The Ruin of Arnor", sort_order: 2, page: 52}
    _declare_video_replay(roa_s2.id, "https://www.youtube.com/watch?v=8GYVVKw2qdg&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV&index=20", "Spillforeningen the Fellowship", 1)

    roa_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: roa_s2.id, faction: :arnor, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(roa_s2f1, 1, 1, [ arvedui ])
    _declare_role_figure(roa_s2f1, 1, 2, [ arnor_captain ])
    _declare_role_figure(roa_s2f1, 9, 3, [ arnor_w ])
    _declare_role_figure(roa_s2f1, 8, 4, [ ranger_north ])
    _declare_role_figure(roa_s2f1, 4, 5, [ ranger_north_spear ])

    roa_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: roa_s2.id, faction: :angmar, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(roa_s2f2, 1, 1, [ gulavhar ])
    _declare_role_figure(roa_s2f2, 1, 2, [ barrow_wight ])
    _declare_role_figure(roa_s2f2, 1, 3, [ warg_chieftain ])
    _declare_role_figure(roa_s2f2, 6, 4, [ warg ])
    _declare_role_figure(roa_s2f2, 2, 5, [ orc_w_shield ])
    _declare_role_figure(roa_s2f2, 2, 6, [ orc_w_bow ])

    #========================================================================
    roa_s3 = Repo.insert! %Scenario{
      name: "The Battle of Fornost",
      blurb: "A coalition of free peoples combine to end the rule of the Witch-King in the North.",
      date_age: 3, date_year: 1975, date_month: 0, date_day: 0, size: 112,
      map_width: 48, map_height: 48, location: :fornost
    }

    Repo.insert! %ScenarioResource{scenario_id: roa_s3.id, resource_type: :source, book: :roa, title: "The Ruin of Arnor", sort_order: 3, page: 54}
    _declare_video_replay(roa_s3.id, "https://www.youtube.com/watch?v=JYwRNv5aoro&index=21&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV", "Spillforeningen the Fellowship", 1)

    roa_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: roa_s3.id, faction: :arnor, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(roa_s3f1, 1,  1, [ arnor_captain ])
    _declare_role_figure(roa_s3f1, 8,  2, [ ranger_north ])
    _declare_role_figure(roa_s3f1, 4,  3, [ hobbit_archer ])
    _declare_role_figure(roa_s3f1, 1,  4, [ gondor_captain_mt ])
    _declare_role_figure(roa_s3f1, 8,  5, [ gondor_womt_shield ])
    _declare_role_figure(roa_s3f1, 8,  6, [ gondor_womt_spear_shield ])
    _declare_role_figure(roa_s3f1, 8,  7, [ gondor_womt_bow ])
    _declare_role_figure(roa_s3f1, 1,  8, [ gondor_womt_banner ])
    _declare_role_figure(roa_s3f1, 1,  9, [ high_elf_captain ])
    _declare_role_figure(roa_s3f1, 8, 10, [ high_elf_w_spear_shield ])
    _declare_role_figure(roa_s3f1, 6, 11, [ high_elf_w_blade ])
    _declare_role_figure(roa_s3f1, 6, 12, [ high_elf_w_bow ])

    roa_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: roa_s3.id, faction: :angmar, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(roa_s3f2,  1,  1, [ witch_king_horse ])
    _declare_role_figure(roa_s3f2,  1,  2, [ gulavhar ])
    _declare_role_figure(roa_s3f2,  1,  3, [ shade ])
    _declare_role_figure(roa_s3f2,  1,  4, [ barrow_wight ])
    _declare_role_figure(roa_s3f2,  1,  5, [ warg_chieftain ])
    _declare_role_figure(roa_s3f2,  5,  6, [ warg ])
    _declare_role_figure(roa_s3f2, 12,  7, [ orc_w_spear ])
    _declare_role_figure(roa_s3f2, 12,  8, [ orc_w_shield ])
    _declare_role_figure(roa_s3f2,  6,  9, [ orc_w_bow ])
    _declare_role_figure(roa_s3f2,  6, 10, [ orc_w_2h ])
    _declare_role_figure(roa_s3f2,  1, 11, [ cave_troll_chain ])
    _declare_role_figure(roa_s3f2,  5, 12, [ spectre ])

    #========================================================================
    roa_s4 = Repo.insert! %Scenario{
      name: "Ambush in Rhudaur",
      blurb: "Aragorn's father Arathorn is ambushed by villains in the wild.",
      date_age: 3, date_year: 2933, date_month: 0, date_day: 0, size: 40,
      map_width: 48, map_height: 48, location: :arnor
    }

    Repo.insert! %ScenarioResource{scenario_id: roa_s4.id, resource_type: :source, book: :roa, title: "The Ruin of Arnor", sort_order: 4, page: 56}

    roa_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: roa_s4.id, faction: :arnor, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(roa_s4f1, 1,  1, [ arathorn ])
    _declare_role_figure(roa_s4f1, 1,  2, [ elladan_armor ])
    _declare_role_figure(roa_s4f1, 1,  3, [ elrohir_armor ])
    _declare_role_figure(roa_s4f1, 8,  4, [ ranger_north ])
    _declare_role_figure(roa_s4f1, 4,  5, [ ranger_north_spear ])

    roa_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: roa_s4.id, faction: :angmar, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(roa_s4f2, 1,  1, [ buhrdur ])
    _declare_role_figure(roa_s4f2, 1,  2, [ warg_chieftain ])
    _declare_role_figure(roa_s4f2, 4,  3, [ orc_w_spear ])
    _declare_role_figure(roa_s4f2, 4,  4, [ orc_w_shield ])
    _declare_role_figure(roa_s4f2, 2,  5, [ orc_w_bow ])
    _declare_role_figure(roa_s4f2, 2,  6, [ orc_w_2h ])
    _declare_role_figure(roa_s4f2, 1,  7, [ orc_w_banner ])
    _declare_role_figure(roa_s4f2, 6,  8, [ warg ])
    _declare_role_figure(roa_s4f2, 2,  9, [ cave_troll_chain ])

    #========================================================================
    roa_s5 = Repo.insert! %Scenario{
      name: "Aragorn's Revenge",
      blurb: "Aragorn sets out to avenge his father by slaying Bûhrdur.",
      date_age: 3, date_year: 2957, date_month: 0, date_day: 0, size: 53,
      map_width: 48, map_height: 48, location: :arnor
    }

    Repo.insert! %ScenarioResource{scenario_id: roa_s5.id, resource_type: :source, book: :roa, title: "The Ruin of Arnor", sort_order: 5, page: 58}

    roa_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: roa_s5.id, faction: :arnor, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(roa_s5f1, 1,  1, [ aragorn ])
    _declare_role_figure(roa_s5f1, 1,  1, [ halbarad ])
    _declare_role_figure(roa_s5f1, 1,  3, [ elladan_armor ])
    _declare_role_figure(roa_s5f1, 1,  4, [ elrohir_armor ])
    _declare_role_figure(roa_s5f1, 8,  5, [ ranger_north ])
    _declare_role_figure(roa_s5f1, 4,  6, [ ranger_north_spear ])

    roa_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: roa_s5.id, faction: :angmar, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(roa_s5f2,  1,  1, [ buhrdur ])
    _declare_role_figure(roa_s5f2,  2,  2, [ cave_troll_chain ])
    _declare_role_figure(roa_s5f2,  1,  3, [ warg_chieftain ])
    _declare_role_figure(roa_s5f2,  8,  4, [ orc_w_spear ])
    _declare_role_figure(roa_s5f2,  8,  5, [ orc_w_shield ])
    _declare_role_figure(roa_s5f2,  2,  6, [ orc_w_bow ])
    _declare_role_figure(roa_s5f2,  2,  7, [ orc_w_2h ])
    _declare_role_figure(roa_s5f2,  1,  8, [ orc_w_banner ])
    _declare_role_figure(roa_s5f2, 12,  9, [ warg ])

    #========================================================================
    roa_s6 = Repo.insert! %Scenario{
      name: "The Terror of Arnor",
      blurb: "Aragorn leads the Dúnedain against Gûlavhar.",
      date_age: 3, date_year: 2958, date_month: 0, date_day: 0, size: 24,
      map_width: 48, map_height: 48, location: :fornost
    }

    Repo.insert! %ScenarioResource{scenario_id: roa_s6.id, resource_type: :source, book: :roa, title: "The Ruin of Arnor", sort_order: 6, page: 60}

    roa_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: roa_s6.id, faction: :arnor, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(roa_s6f1, 1,  1, [ aragorn ])
    _declare_role_figure(roa_s6f1, 1,  2, [ halbarad ])
    _declare_role_figure(roa_s6f1, 5,  3, [ dunedain ])
    _declare_role_figure(roa_s6f1, 8,  4, [ ranger_north ])
    _declare_role_figure(roa_s6f1, 4,  5, [ ranger_north_spear ])

    roa_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: roa_s6.id, faction: :angmar, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(roa_s6f2, 1,  1, [ gulavhar ])
    _declare_role_figure(roa_s6f2, 4,  2, [ spectre ])

    #########################################################################
    # SCOURING OF THE SHIRE
    #########################################################################

    #========================================================================
    sots_s1 = Repo.insert! %Scenario{
      name: "Maggot's Farm",
      blurb: "Sharkey's ruffians begin infiltrating the Shire.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 9,
      map_width: 48, map_height: 24, location: :the_shire,
    }

    Repo.insert! %ScenarioResource{scenario_id: sots_s1.id, resource_type: :source, book: :sots, title: "The Scouring of the Shire", sort_order: 1, page: 18}
    _declare_web_replay(sots_s1.id, "http://davetownsend.org/Battles/LotR-20070619/", "DaveT", 1)
    _declare_web_replay(sots_s1.id, "http://davetownsend.org/Battles/LotR-20141115/", "DaveT", 2)

    sots_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: sots_s1.id, faction: :shire, suggested_points: 50, actual_points: 50, sort_order: 1}
    _declare_role_figure(sots_s1f1, 1, 1, [ maggot ])
    _declare_role_figure(sots_s1f1, 1, 2, [ grip ])
    _declare_role_figure(sots_s1f1, 1, 3, [ fang ])
    _declare_role_figure(sots_s1f1, 1, 4, [ wolf ])

    sots_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: sots_s1.id, faction: :isengard, suggested_points: 25, actual_points: 25, sort_order: 2}
    _declare_role_figure(sots_s1f2, 1, 1, [ ruffian_bow ])
    _declare_role_figure(sots_s1f2, 4, 2, [ ruffian_whip ])

    #========================================================================
    sots_s2 = Repo.insert! %Scenario{
      name: "Beating the Bounds",
      blurb: "The Shire's militia tries to keep out the Ruffians.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 18, size: 15,
      map_width: 48, map_height: 24, location: :the_shire
    }

    Repo.insert! %ScenarioResource{scenario_id: sots_s2.id, resource_type: :source, book: :sots, title: "The Scouring of the Shire", sort_order: 2, page: 22}
    _declare_web_replay(sots_s2.id, "http://davetownsend.org/Battles/LotR-20151120/", "DaveT", 1)

    sots_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: sots_s2.id, faction: :shire, suggested_points: 17, actual_points: 17, sort_order: 1}
    _declare_role_figure(sots_s2f1, 2, 1, [ hobbit_archer ])
    _declare_role_figure(sots_s2f1, 3, 2, [ hobbit_militia ])

    sots_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: sots_s2.id, faction: :isengard, suggested_points: 50, actual_points: 50, sort_order: 2}
    _declare_role_figure(sots_s2f2, 5, 1, [ ruffian_bow ])
    _declare_role_figure(sots_s2f2, 5, 2, [ ruffian_whip ])

    #========================================================================
    sots_s3 = Repo.insert! %Scenario{
      name: "Brockenborings",
      blurb: "Sharkey breaks up a meeting led by Fatty and Lobelia.",
      date_age: 3, date_year: 3019, date_month: 6, date_day: 15, size: 18,
      map_width: 48, map_height: 48, location: :the_shire
    }

    Repo.insert! %ScenarioResource{scenario_id: sots_s3.id, resource_type: :source, book: :sots, title: "The Scouring of the Shite", sort_order: 3, page: 26}
    _declare_web_replay(sots_s3.id, "http://davetownsend.org/Battles/LotR-20151123/", "DaveT", 1)

    sots_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: sots_s3.id, faction: :shire, suggested_points: 39, actual_points: 39, sort_order: 1}
    _declare_role_figure(sots_s3f1, 1, 1, [ fatty ])
    _declare_role_figure(sots_s3f1, 1, 2, [ lobelia ])
    _declare_role_figure(sots_s3f1, 8, 3, [ hobbit_militia ])

    sots_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: sots_s3.id, faction: :isengard, suggested_points: 90, actual_points: 90, sort_order: 2}
    _declare_role_figure(sots_s3f2, 1, 1, [ sharkey ])
    _declare_role_figure(sots_s3f2, 1, 1, [ worm ])
    _declare_role_figure(sots_s3f2, 3, 3, [ ruffian_whip ])
    _declare_role_figure(sots_s3f2, 3, 4, [ ruffian_bow ])

    #========================================================================
    sots_s4 = Repo.insert! %Scenario{
      name: "The Old Store House",
      blurb: "The hobbits try to get some of the food \"gathered\" by the ruffians.",
      date_age: 3, date_year: 3019, date_month: 8, date_day: 16, size: 20,
      map_width: 48, map_height: 48, location: :the_shire
    }

    Repo.insert! %ScenarioResource{scenario_id: sots_s4.id, resource_type: :source, book: :sots, title: "The Scouring of the Shire", sort_order: 4, page: 28}

    sots_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: sots_s4.id, faction: :shire, suggested_points: 40, actual_points: 40, sort_order: 1}
    _declare_role_figure(sots_s4f1, 4, 1, [ hobbit_shirriff ])
    _declare_role_figure(sots_s4f1, 8, 2, [ hobbit_militia ])

    sots_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: sots_s4.id, faction: :isengard, suggested_points: 40, actual_points: 40, sort_order: 2}
    _declare_role_figure(sots_s4f2, 8, 1, [ ruffian_whip ])

    #========================================================================
    sots_s5 = Repo.insert! %Scenario{
      name: "The Southfarthing",
      blurb: "Paladin Took leads the revolt against the ruffians in the Southfarthing.",
      date_age: 3, date_year: 3019, date_month: 10, date_day: 30, size: 32,
      map_width: 48, map_height: 48, location: :the_shire
    }

    Repo.insert! %ScenarioResource{scenario_id: sots_s5.id, resource_type: :source, book: :sots, title: "The Scouring of the Shire", sort_order: 5, page: 28}

    sots_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: sots_s5.id, faction: :shire, suggested_points: 101, actual_points: 101, sort_order: 1}
    _declare_role_figure(sots_s5f1, 1, 1, [ paladin ])
    _declare_role_figure(sots_s5f1, 4, 2, [ hobbit_shirriff ])
    _declare_role_figure(sots_s5f1, 3, 3, [ hobbit_archer ])
    _declare_role_figure(sots_s5f1, 1, 4, [ hobbit_archer_horn ])
    _declare_role_figure(sots_s5f1, 8, 5, [ hobbit_militia ])

    sots_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: sots_s5.id, faction: :isengard, suggested_points: 72, actual_points: 72, sort_order: 2}
    _declare_role_figure(sots_s5f2, 6, 1, [ ruffian_bow ])
    _declare_role_figure(sots_s5f2, 6, 2, [ ruffian_whip ])
    _declare_role_figure(sots_s5f2, 3, 3, [ ruffian ])

    #========================================================================
    sots_s6 = Repo.insert! %Scenario{
      name: "The Battle of Bywater",
      blurb: "The last battle of the War of the Ring.",
      date_age: 3, date_year: 3019, date_month: 11, date_day: 1, size: 44,
      map_width: 36, map_height: 24, location: :the_shire
    }

    Repo.insert! %ScenarioResource{scenario_id: sots_s6.id, resource_type: :source, book: :sots, title: "The Scouring of the Shire", sort_order: 6, page: 40}
    _declare_podcast(sots_s6.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-6-the-battle-of-bywater", "The Green Dragon", 1)

    sots_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: sots_s6.id, faction: :shire, suggested_points: 269, actual_points: 269, sort_order: 1}
    _declare_role_figure(sots_s6f1,  1, 1, [ frodo_pony ])
    _declare_role_figure(sots_s6f1,  1, 2, [ sam_pony ])
    _declare_role_figure(sots_s6f1,  1, 3, [ merry_pony ])
    _declare_role_figure(sots_s6f1,  1, 4, [ pippin_pony ])
    _declare_role_figure(sots_s6f1,  4, 5, [ hobbit_shirriff ])
    _declare_role_figure(sots_s6f1,  8, 6, [ hobbit_archer ])
    _declare_role_figure(sots_s6f1, 12, 7, [ hobbit_militia ])

    sots_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: sots_s6.id, faction: :isengard, suggested_points: 135, actual_points: 135, sort_order: 2}
    _declare_role_figure(sots_s6f2, 1, 1, [ sharkey ])
    _declare_role_figure(sots_s6f2, 1, 2, [ worm ])
    _declare_role_figure(sots_s6f2, 9, 3, [ ruffian_whip ])
    _declare_role_figure(sots_s6f2, 6, 4, [ ruffian_bow ])

    #========================================================================
    sots_s7 = Repo.insert! %Scenario{
      name: "The Founding of the Shire",
      blurb: "The hobbits move in to the area that will become the Shire ... if they can overcome the local goblins.",
      date_age: 3, date_year: 1601, date_month: 0, date_day: 0, size: 38,
      map_width: 48, map_height: 48, location: :the_shire
    }

    Repo.insert! %ScenarioResource{scenario_id: sots_s7.id, resource_type: :source, book: :sots, title: "The Scouring of the Shire", sort_order: 7, page: 50}
    _declare_video_replay(sots_s7.id, "https://www.youtube.com/watch?v=wCPbwSPgm2I&index=11&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV", "Spillforeningen the Fellowship", 1)
    _declare_video_replay(sots_s7.id, "https://www.youtube.com/watch?v=ILWmWjvhF7Q&list=PLa_Dq2-Vx86KjLv5JCpygwNALLzzh5zG9&index=15", "Mid-Sussex Wargamers", 2)

    sots_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: sots_s7.id, faction: :shire, suggested_points: 84, actual_points: 84, sort_order: 1}
    _declare_role_figure(sots_s7f1,  4, 1, [ hobbit_shirriff ])
    _declare_role_figure(sots_s7f1,  7, 2, [ hobbit_archer ])
    _declare_role_figure(sots_s7f1,  1, 3, [ hobbit_archer_horn ])
    _declare_role_figure(sots_s7f1, 12, 4, [ hobbit_militia ])

    sots_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: sots_s7.id, faction: :moria, suggested_points: 190, actual_points: 190, sort_order: 2}
    _declare_role_figure(sots_s7f2,  1, 1, [ moria_shaman ])
    _declare_role_figure(sots_s7f2,  4, 2, [ moria_g_bow ])
    _declare_role_figure(sots_s7f2,  4, 3, [ moria_g_spear ])
    _declare_role_figure(sots_s7f2,  4, 4, [ moria_g_shield ])
    _declare_role_figure(sots_s7f2,  1, 5, [ cave_troll_chain ])

    #========================================================================
    sots_s8 = Repo.insert! %Scenario{
      name: "Whatever Happened to Halfast?",
      blurb: "Halfast Bracegirdle goes exploring with some of his hobbit friends, and runs into trouble.",
      date_age: 3, date_year: 1903, date_month: 0, date_day: 0, size: 21,
      map_width: 48, map_height: 48, location: :eriador
    }

    Repo.insert! %ScenarioResource{scenario_id: sots_s8.id, resource_type: :source, book: :sots, title: "The Scouring of the Shire", sort_order: 8, page: 54}
    _declare_video_replay(sots_s8.id, "https://www.youtube.com/watch?v=6qOxisagAgw&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV&index=12", "Spillforeningen the Fellowship", 1)

    sots_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: sots_s8.id, faction: :shire, suggested_points: 50, actual_points: 44, sort_order: 1}
    _declare_role_figure(sots_s8f1, 1, 1, "Halfast Bracegirdle (Shirriff)", [ hobbit_shirriff ])
    _declare_role_figure(sots_s8f1, 4, 2, [ hobbit_archer ])
    _declare_role_figure(sots_s8f1, 8, 3, [ hobbit_militia ])

    sots_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: sots_s8.id, faction: :angmar, suggested_points: 250, actual_points: 232, sort_order: 2}
    _declare_role_figure(sots_s8f2, 4, 1, [ barrow_wight ])
    _declare_role_figure(sots_s8f2, 4, 2, [ warg ])

    #========================================================================
    sots_s9 = Repo.insert! %Scenario{
      name: "The Battle of Greenfields",
      blurb: "Bandobras Took protects the Shire against goblins lead by Golfimbul, and invents the game of golf.",
      date_age: 3, date_year: 2747, date_month: 0, date_day: 0, size: 33,
      map_width: 48, map_height: 24, location: :the_shire
    }

    Repo.insert! %ScenarioResource{scenario_id: sots_s9.id, resource_type: :source, book: :sots, title: "The Scouring of the Shire", sort_order: 9, page: 56}
    _declare_video_replay(sots_s9.id, "https://www.youtube.com/watch?v=H8CbzycqD7M&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV&index=13", "Spillforeningen the Fellowship", 1)

    sots_s9f1 = Repo.insert! %ScenarioFaction{scenario_id: sots_s9.id, faction: :shire, suggested_points: 175, actual_points: 171, sort_order: 1}
    _declare_role_figure(sots_s9f1, 1, 1, [ bandobras_pony ])
    _declare_role_figure(sots_s9f1, 3, 2, [ ranger_north ])
    _declare_role_figure(sots_s9f1, 8, 3, [ hobbit_militia ])
    _declare_role_figure(sots_s9f1, 4, 4, [ hobbit_archer ])
    _declare_role_figure(sots_s9f1, 4, 5, [ hobbit_shirriff ])

    sots_s9f2 = Repo.insert! %ScenarioFaction{scenario_id: sots_s9.id, faction: :moria, suggested_points: 175, actual_points: 171, sort_order: 2}
    _declare_role_figure(sots_s9f2, 1, 1, [ golfimbul_warg ])
    _declare_role_figure(sots_s9f2, 6, 2, [ warg_rider_shield_spear ])
    _declare_role_figure(sots_s9f2, 6, 3, [ warg_rider_bow ])

    #========================================================================
    sots_s10 = Repo.insert! %Scenario{
      name: "The Wolves of Winter",
      blurb: "Gandalf helps the Shirefolk during the long winter.",
      date_age: 3, date_year: 2911, date_month: 0, date_day: 0, size: 26,
      map_width: 48, map_height: 48, location: :the_shire
    }

    Repo.insert! %ScenarioResource{scenario_id: sots_s10.id, resource_type: :source, book: :sots, title: "The Scouring of the Shire", sort_order: 10, page: 58}
    _declare_video_replay(sots_s10.id, "https://www.youtube.com/watch?v=KVl5PT_kTj4&index=15&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV", "Spillforeningen the Fellowship", 1)

    sots_s10f1 = Repo.insert! %ScenarioFaction{scenario_id: sots_s10.id, faction: :shire, suggested_points: 200, actual_points: 126, sort_order: 1}
    _declare_role_figure(sots_s10f1, 1, 1, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(sots_s10f1, 8, 2, [ hobbit_militia ])
    _declare_role_figure(sots_s10f1, 4, 3, [ hobbit_archer ])
    _declare_role_figure(sots_s10f1, 4, 4, [ hobbit_shirriff ])

    sots_s10f2 = Repo.insert! %ScenarioFaction{scenario_id: sots_s10.id, faction: :angmar, suggested_points: 200, actual_points: 139, sort_order: 2}
    _declare_role_figure(sots_s10f2, 1, 1, [ warg_chieftain ])
    _declare_role_figure(sots_s10f2, 8, 1, [ warg ])

    #========================================================================
    sots_s11 = Repo.insert! %Scenario{
      name: "Odovacar Bolger's Promenade",
      blurb: "A jolly picnic in the Old Forest turns into the stuff of nighmares.",
      date_age: 3, date_year: 2981, date_month: 0, date_day: 0, size: 10,
      map_width: 48, map_height: 48, location: :eriador
    }

    Repo.insert! %ScenarioResource{scenario_id: sots_s11.id, resource_type: :source, book: :sots, title: "The Scouring of the Shire", sort_order: 11, page: 60}
    _declare_video_replay(sots_s11.id, "https://www.youtube.com/watch?v=VjADcBDmtzw&index=16&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV", "Spillforeningen the Fellowship", 1)

    sots_s11f1 = Repo.insert! %ScenarioFaction{scenario_id: sots_s11.id, faction: :shire, suggested_points: 175, actual_points: 174, sort_order: 1}
    _declare_role_figure(sots_s11f1, 1, 1, [ tom_bombadil ])
    _declare_role_figure(sots_s11f1, 1, 2, [ goldberry ])
    _declare_role_figure(sots_s11f1, 8, 3, [ hobbit_militia ])

    Repo.insert! %ScenarioFaction{scenario_id: sots_s11.id, faction: :angmar, suggested_points: 0, actual_points: 0, sort_order: 2}

    #========================================================================
    sots_s12 = Repo.insert! %Scenario{
      name: "The Road to Rivendell",
      blurb: "Bilbo's journey to Rivendell is discovered by a Moria force. Fortunately some friends are around to help him.",
      date_age: 3, date_year: 3001, date_month: 0, date_day: 0, size: 35,
      map_width: 48, map_height: 48, location: :eriador
    }

    Repo.insert! %ScenarioResource{scenario_id: sots_s12.id, resource_type: :source, book: :sots, title: "The Scouring of the Shire", sort_order: 12, page: 62}

    sots_s12f1 = Repo.insert! %ScenarioFaction{scenario_id: sots_s12.id, faction: :wanderers, suggested_points: 400, actual_points: 397, sort_order: 1}
    _declare_role_figure(sots_s12f1, 1, 1, [ bilbo ])
    _declare_role_figure(sots_s12f1, 1, 2, [ aragorn ])
    _declare_role_figure(sots_s12f1, 3, 3, [ wood_elf_w_armor_blade ])
    _declare_role_figure(sots_s12f1, 3, 4, [ wood_elf_w_armor_bow ])
    _declare_role_figure(sots_s12f1, 3, 5, [ ranger_north ])

    sots_s12f2 = Repo.insert! %ScenarioFaction{scenario_id: sots_s12.id, faction: :moria, suggested_points: 200, actual_points: 397, sort_order: 2}
    _declare_role_figure(sots_s12f2, 4, 1, [ warg_rider_bow ])
    _declare_role_figure(sots_s12f2, 4, 2, [ warg_rider_shield_spear ])
    _declare_role_figure(sots_s12f2, 4, 3, [ warg_rider_shield ])
    _declare_role_figure(sots_s12f2, 4, 4, [ moria_g_shield ])
    _declare_role_figure(sots_s12f2, 4, 5, [ moria_g_bow ])
    _declare_role_figure(sots_s12f2, 4, 6, [ moria_g_spear ])

    #########################################################################
    # SHADOW & FLAME
    #########################################################################

    #========================================================================
    saf_s1 = Repo.insert! %Scenario{
      name: "The Eastgate",
      blurb: "Balin's dwarves assault the east gate of Moria.",
      date_age: 3, date_year: 2989, date_month: 0, date_day: 0, size: 43,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: saf_s1.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 1, page: 14}

    saf_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: saf_s1.id, faction: :durins_folk, suggested_points: 200, actual_points: 0, sort_order: 1}
    _declare_role_figure(saf_s1f1, 1, 1, [ balin ])
    _declare_role_figure(saf_s1f1, 4, 2, [ dwarf_khazad_gd ])
    _declare_role_figure(saf_s1f1, 4, 3, [ dwarf_w_shield ])
    _declare_role_figure(saf_s1f1, 6, 4, [ dwarf_w_bow ])
    _declare_role_figure(saf_s1f1, 2, 5, [ dwarf_w_2h ])

    saf_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: saf_s1.id, faction: :moria,   suggested_points: 200, actual_points: 0, sort_order: 2}
    _declare_role_figure(saf_s1f2, 2, 1, [ moria_captain ])
    _declare_role_figure(saf_s1f2, 8, 2, [ moria_g_spear ])
    _declare_role_figure(saf_s1f2, 8, 3, [ moria_g_shield ])
    _declare_role_figure(saf_s1f2, 8, 4, [ moria_g_bow ])

    #========================================================================
    saf_s2 = Repo.insert! %Scenario{
      name: "Battle for the Dwarrowdelf",
      blurb: "Balin faces off against Durbûrz deep within Moria.",
      date_age: 3, date_year: 2990, date_month: 0, date_day: 0, size: 79,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: saf_s2.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 2, page: 20}

    saf_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: saf_s2.id, faction: :durins_folk, suggested_points: 600, actual_points: 0, sort_order: 1}
    _declare_role_figure(saf_s2f1,  1, 1, "Balin with Durin's Axe", [ balin ])
    _declare_role_figure(saf_s2f1,  2, 2, [ dwarf_captain ])
    _declare_role_figure(saf_s2f1,  8, 3, [ dwarf_khazad_gd ])
    _declare_role_figure(saf_s2f1, 10, 4, [ dwarf_w_shield ])
    _declare_role_figure(saf_s2f1,  9, 5, [ dwarf_w_bow ])
    _declare_role_figure(saf_s2f1,  5, 6, [ dwarf_w_2h ])

    saf_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: saf_s2.id, faction: :moria,   suggested_points: 600, actual_points: 0, sort_order: 2}
    _declare_role_figure(saf_s2f2,  1, 1, [ durburz ])
    _declare_role_figure(saf_s2f2,  1, 2, [ moria_drum ])
    _declare_role_figure(saf_s2f2,  2, 3, [ moria_drummer ])
    _declare_role_figure(saf_s2f2,  1, 4, [ moria_captain ])
    _declare_role_figure(saf_s2f2,  2, 5, [ moria_shaman ])
    _declare_role_figure(saf_s2f2, 12, 6, [ moria_g_shield ])
    _declare_role_figure(saf_s2f2, 12, 7, [ moria_g_spear ])
    _declare_role_figure(saf_s2f2, 12, 8, [ moria_g_bow ])
    _declare_role_figure(saf_s2f2,  1, 9, [ cave_troll_chain, cave_troll_spear ])

    #========================================================================
    saf_s3 = Repo.insert! %Scenario{
      name: "Mirrormere",
      blurb: "The Goblins ambush Balin as he gazes into the waters of the Kheled-zâram.",
      date_age: 3, date_year: 2993, date_month: 0, date_day: 0, size: 51,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: saf_s3.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 3, page: 24}

    saf_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: saf_s3.id, faction: :durins_folk, suggested_points: 300, actual_points: 0, sort_order: 1}
    _declare_role_figure(saf_s3f1,  1, 1, "Balin with Durin's Axe", [ balin ])
    _declare_role_figure(saf_s3f1,  1, 2, [ dwarf_captain ])
    _declare_role_figure(saf_s3f1,  8, 3, [ dwarf_khazad_gd ])
    _declare_role_figure(saf_s3f1,  2, 4, [ dwarf_w_shield ])
    _declare_role_figure(saf_s3f1,  3, 5, [ dwarf_w_bow ])
    _declare_role_figure(saf_s3f1,  1, 6, [ dwarf_w_2h ])

    saf_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: saf_s3.id, faction: :moria,   suggested_points: 300, actual_points: 0, sort_order: 2}
    _declare_role_figure(saf_s3f2,  1, 1, [ moria_captain ])
    _declare_role_figure(saf_s3f2,  1, 2, [ moria_shaman ])
    _declare_role_figure(saf_s3f2, 16, 3, [ moria_g_bow ])
    _declare_role_figure(saf_s3f2,  8, 4, [ moria_g_shield ])
    _declare_role_figure(saf_s3f2,  8, 5, [ moria_g_spear ])
    _declare_role_figure(saf_s3f2,  1, 6, [ cave_troll_chain ])

    #========================================================================
    saf_s4 = Repo.insert! %Scenario{
      name: "They Are Coming",
      blurb: "The last dwarves in Moria face the Balrog.",
      date_age: 3, date_year: 2994, date_month: 0, date_day: 0, size: 55,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: saf_s4.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 4, page: 28}

    saf_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: saf_s4.id, faction: :durins_folk, suggested_points: 500, actual_points: 0, sort_order: 1}
    _declare_role_figure(saf_s4f1,  2, 1, [ dwarf_captain ])
    _declare_role_figure(saf_s4f1,  5, 2, [ dwarf_khazad_gd ])
    _declare_role_figure(saf_s4f1, 10, 3, [ dwarf_w_shield ])
    _declare_role_figure(saf_s4f1,  5, 4, [ dwarf_w_bow ])
    _declare_role_figure(saf_s4f1,  5, 5, [ dwarf_w_2h ])

    saf_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: saf_s4.id, faction: :moria,   suggested_points: 500, actual_points: 0, sort_order: 2}
    _declare_role_figure(saf_s4f2, 1, 1, "Balrog", [ balrog, balrog_plastic, balrog_whip ])
    _declare_role_figure(saf_s4f2, 2, 2, [ moria_captain ])
    _declare_role_figure(saf_s4f2, 1, 3, [ moria_shaman ])
    _declare_role_figure(saf_s4f2, 8, 4, [ moria_g_bow ])
    _declare_role_figure(saf_s4f2, 8, 5, [ moria_g_shield ])
    _declare_role_figure(saf_s4f2, 8, 6, [ moria_g_spear ])

    #========================================================================
    saf_s5 = Repo.insert! %Scenario{
      name: "Fog on the Barrow Downs",
      blurb: "Frodo and friends are attacked by the Barrow Wights.",
      date_age: 3, date_year: 3018, date_month: 9, date_day: 28, size: 9,
      map_width: 48, map_height: 48, location: :eriador
    }

    Repo.insert! %ScenarioResource{scenario_id: saf_s5.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 5, page: 36}
    _declare_web_replay(saf_s5.id, "http://davetownsend.org/Battles/LotR-20070809/", "DaveT", 1)

    saf_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: saf_s5.id, faction: :fellowship, suggested_points: 200, actual_points: 0, sort_order: 1}
    _declare_role_figure(saf_s5f1, 1, 1, [ frodo ])
    _declare_role_figure(saf_s5f1, 1, 2, [ sam ])
    _declare_role_figure(saf_s5f1, 1, 3, [ merry ])
    _declare_role_figure(saf_s5f1, 1, 4, [ pippin ])
    _declare_role_figure(saf_s5f1, 1, 5, [ tom_bombadil ])

    saf_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: saf_s5.id, faction: :angmar,     suggested_points: 200, actual_points: 0, sort_order: 2}
    _declare_role_figure(saf_s5f2, 4, 1, [ barrow_wight ])

    #========================================================================
    saf_s6 = Repo.insert! %Scenario{
      name: "Surrounded!",
      blurb: "Elves under Glorfindel are surrounded by Orcs on one side and Goblins on the other.",
      date_age: 3, date_year: 2925, date_month: 0, date_day: 0, size: 101,
      map_width: 48, map_height: 48, location: :eriador
    }

    Repo.insert! %ScenarioResource{scenario_id: saf_s6.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 6, page: 42}

    saf_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: saf_s6.id, faction: :rivendell, suggested_points: 650, actual_points: 0, sort_order: 1}
    _declare_role_figure(saf_s6f1,  1, 1, [ glorfindel ])
    _declare_role_figure(saf_s6f1,  1, 2, [ elladan ])
    _declare_role_figure(saf_s6f1,  1, 3, [ elrohir ])
    _declare_role_figure(saf_s6f1,  1, 4, [ arwen, arwen2 ])
    _declare_role_figure(saf_s6f1, 15, 5, [ wood_elf_w_armor_bow ])
    _declare_role_figure(saf_s6f1, 18, 6, "Wood Elf Warriors with armour and Elven blades or spears", [ wood_elf_w_armor_blade, wood_elf_w_armor_spear ])

    saf_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: saf_s6.id, faction: :angmar,    suggested_points: 700, actual_points: 0, sort_order: 2}
    _declare_role_figure(saf_s6f2,  2,  1, [ orc_captain ])
    _declare_role_figure(saf_s6f2,  1,  2, [ orc_captain_warg ])
    _declare_role_figure(saf_s6f2,  5,  3, [ orc_w_2h ])
    _declare_role_figure(saf_s6f2, 10,  4, [ orc_w_shield ])
    _declare_role_figure(saf_s6f2,  5,  5, [ orc_w_bow ])
    _declare_role_figure(saf_s6f2,  4,  6, [ warg_rider_bow ])
    _declare_role_figure(saf_s6f2,  4,  7, [ warg_rider_shield_spear ])
    _declare_role_figure(saf_s6f2,  2,  8, [ moria_captain ])
    _declare_role_figure(saf_s6f2,  1,  9, [ cave_troll_chain ])
    _declare_role_figure(saf_s6f2,  1, 10, [ cave_troll_spear])
    _declare_role_figure(saf_s6f2,  8, 11, [ moria_g_spear ])
    _declare_role_figure(saf_s6f2,  8, 12, [ moria_g_shield ])
    _declare_role_figure(saf_s6f2,  8, 13, [ moria_g_bow ])

    #========================================================================
    saf_s7 = Repo.insert! %Scenario{
      name: "Fangorn",
      blurb: "The Rohirrim, chasing down an Orcish raiding party, get some unexpected help.",
      date_age: 3, date_year: 3016, date_month: 0, date_day: 0, size: 53,
      map_width: 48, map_height: 48, location: :fangorn
    }

    Repo.insert! %ScenarioResource{scenario_id: saf_s7.id, resource_type: :source, book: :saf, title: "Shadow & Flame", sort_order: 7, page: 46}

    saf_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: saf_s7.id, faction: :rohan,    suggested_points: 500, actual_points: 0, sort_order: 1}
    _declare_role_figure(saf_s7f1,  1, 1, "Radagast the Brown", [ radagast_goblintown, radagast_lotr, radagast_sebastian ])
    _declare_role_figure(saf_s7f1,  1, 2, [ gwaihir ])
    _declare_role_figure(saf_s7f1,  1, 3, [ treebeard ])
    _declare_role_figure(saf_s7f1,  1, 4, [ rohan_captain_horse ])
    _declare_role_figure(saf_s7f1,  8, 5, [ rohan_rider ])
    _declare_role_figure(saf_s7f1,  8, 6, [ rohan_rider_spear ])

    saf_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: saf_s7.id, faction: :isengard, suggested_points: 500, actual_points: 0, sort_order: 2}
    _declare_role_figure(saf_s7f2,  2, 1, [ uruk_hai_shaman ])
    _declare_role_figure(saf_s7f2,  2, 2, [ uruk_hai_captain_shield ])
    _declare_role_figure(saf_s7f2, 12, 3, [ uruk_hai_w_shield ])
    _declare_role_figure(saf_s7f2,  4, 4, [ uruk_hai_w_crossbow ])
    _declare_role_figure(saf_s7f2,  5, 5, [ uruk_hai_berserker ])
    _declare_role_figure(saf_s7f2,  4, 6, [ warg_rider_shield_spear ])
    _declare_role_figure(saf_s7f2,  4, 7, [ warg_rider_bow ])

    #########################################################################
    # A SHADOW IN THE EAST
    #########################################################################

    #========================================================================
    site_s1 = Repo.insert! %Scenario{
      name: "The Fall of Amon Barad",
      blurb: "Easterlings under Khamûl launch a surprise attack on a Gondorian outpost in Ithilien.",
      date_age: 3, date_year: 2998, date_month: -4, date_day: 0, size: 30,
      map_width: 48, map_height: 48, location: :ithilien
    }

    Repo.insert! %ScenarioResource{scenario_id: site_s1.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 1, page: 14}
    _declare_web_replay(site_s1.id, "http://www.davetownsend.org/Battles/LotR-20160604/", "DaveT", 1)

    site_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s1.id, faction: :minas_tirith, suggested_points: 200, actual_points: 203, sort_order: 1}
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
      date_age: 3, date_year: 2998, date_month: -3, date_day: 0, size: 28,
      map_width: 48, map_height: 24, location: :ithilien
    }

    Repo.insert! %ScenarioResource{scenario_id: site_s2.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 2, page: 16}
    _declare_web_replay(site_s2.id, "http://davetownsend.org/Battles/LotR-20160727/", "DaveT", 1)

    site_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s2.id, faction: :minas_tirith, suggested_points: 275, actual_points: 279, sort_order: 1}
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
      date_age: 3, date_year: 2998, date_month: -2, date_day: 0, size: 47,
      map_width: 48, map_height: 48, location: :ithilien
    }

    Repo.insert! %ScenarioResource{scenario_id: site_s3.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 3, page: 28}
    _declare_web_replay(site_s3.id, "http://davetownsend.org/Battles/LotR-20161021/", "DaveT", 1)

    site_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s3.id, faction: :minas_tirith, suggested_points: 350, actual_points: 329, sort_order: 1}
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
      date_age: 3, date_year: 2998, date_month: -1, date_day: 0, size: 121,
      map_width: 48, map_height: 48, location: :ithilien
    }

    Repo.insert! %ScenarioResource{scenario_id: site_s4.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 4, page: 30}

    site_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s4.id, faction: :minas_tirith, suggested_points: 900, actual_points: 849, sort_order: 1}
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
      date_age: 3, date_year: 3001, date_month: 0, date_day: 0, size: 71,
      map_width: 48, map_height: 48, location: :rhun
    }

    Repo.insert! %ScenarioResource{scenario_id: site_s5.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 5, page: 36}

    site_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s5.id, faction: :durins_folk, suggested_points: 500, actual_points: 460, sort_order: 1}
    _declare_role_figure(site_s5f1,  1, 1, [ dain ])
    _declare_role_figure(site_s5f1,  1, 2, [ dwarf_captain ])
    _declare_role_figure(site_s5f1,  6, 3, [ dwarf_khazad_gd ])
    _declare_role_figure(site_s5f1,  9, 4, [ dwarf_w_bow ])
    _declare_role_figure(site_s5f1,  7, 5, [ dwarf_w_shield ])
    _declare_role_figure(site_s5f1,  4, 6, [ dwarf_w_2h ])
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
      date_age: 3, date_year: 3002, date_month: 0, date_day: 0, size: 101,
      map_width: 72, map_height: 48, location: :rhun
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

    site_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: site_s6.id, faction: :cirith_ungol, suggested_points: 750, actual_points: 796, sort_order: 2}
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
      date_age: 3, date_year: 2510, date_month: 0, date_day: 0, size: 107,
      map_width: 48, map_height: 48, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: site_s7.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 7, page: 40}
    _declare_video_replay(site_s7.id, "https://www.youtube.com/watch?v=ybatWJnNcZE&index=27&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV", "Spillforeningen the Fellowship", 1)

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
      date_age: 3, date_year: 2520, date_month: 0, date_day: 0, size: 28,
      map_width: 48, map_height: 48, location: :fangorn
    }

    Repo.insert! %ScenarioResource{scenario_id: site_s8.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 8, page: 46}

    site_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s8.id, faction: :wanderers, suggested_points: 400, actual_points: 495, sort_order: 1}
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
      date_age: 3, date_year: 3018, date_month: 6, date_day: 20, size: 110,
      map_width: 48, map_height: 48, location: :osgiliath
    }

    Repo.insert! %ScenarioResource{scenario_id: sog_s1.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 1, page: 18}

    sog_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: sog_s1.id, faction: :minas_tirith, suggested_points: 400, actual_points: 0, sort_order: 1}
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

    sog_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: sog_s1.id, faction: :minas_morgul, suggested_points: 400, actual_points: 0, sort_order: 2}
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
      date_age: 3, date_year: 3018, date_month: 3, date_day: 9, size: 100,
      map_width: 48, map_height: 48, location: :gondor
    }

    Repo.insert %ScenarioResource{scenario_id: sog_s2.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 2, page: 32}

    sog_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: sog_s2.id, faction: :minas_tirith, suggested_points: 250, actual_points: 0, sort_order: 1}
    _declare_role_figure(sog_s2f1, 1, 1, "Faramir, Captain of Gondor", [ faramir ])
    _declare_role_figure(sog_s2f1, 1, 2, "Damrod, Captain of the Rangers of Gondor", [ beregond ])
    _declare_role_figure(sog_s2f1, 4, 3, [ gondor_rog ])
    _declare_role_figure(sog_s2f1, 6, 4, [ gondor_womt_bow ])
    _declare_role_figure(sog_s2f1, 6, 5, [ gondor_womt_spear_shield ])
    _declare_role_figure(sog_s2f1, 4, 6, [ gondor_womt_shield ])
    _declare_role_figure(sog_s2f1, 2, 7, [ gondor_womt_banner ])

    sog_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: sog_s2.id, faction: :minas_morgul, suggested_points: 750, actual_points: 0, sort_order: 2}
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
      date_age: 3, date_year: 3019, date_month: 3, date_day: 11, size: 69,
      map_width: 48, map_height: 48, location: :gondor
    }

    Repo.insert! %ScenarioResource{scenario_id: sog_s3.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 3, page: 40}

    sog_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: sog_s3.id, faction: :minas_tirith, suggested_points: 150, actual_points: 0, sort_order: 1}
    _declare_role_figure(sog_s3f1, 1, 1, [ gondor_captain_mt ])
    _declare_role_figure(sog_s3f1, 4, 2, [ gondor_rog ])
    _declare_role_figure(sog_s3f1, 4, 3, [ gondor_womt_bow ])
    _declare_role_figure(sog_s3f1, 4, 4, [ gondor_womt_spear_shield ])
    _declare_role_figure(sog_s3f1, 3, 5, [ gondor_womt_shield ])
    _declare_role_figure(sog_s3f1, 1, 6, [ gondor_womt_banner ])

    sog_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: sog_s3.id, faction: :minas_morgul, suggested_points: 600, actual_points: 0, sort_order: 2}
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
      date_age: 3, date_year: 3019, date_month: 3, date_day: 12, size: 87,
      map_width: 48, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: sog_s4.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 4, page: 46}

    sog_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: sog_s4.id, faction: :minas_tirith, suggested_points: 500, actual_points: 0, sort_order: 1}
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

    sog_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: sog_s4.id, faction: :minas_morgul, suggested_points: 500, actual_points: 0, sort_order: 2}
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
      date_age: 3, date_year: 3019, date_month: 3, date_day: 14, size: 112,
      map_width: 48, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: sog_s5.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 5, page: 48}

    sog_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: sog_s5.id, faction: :minas_tirith, suggested_points:  750, actual_points: 0, sort_order: 1}
    _declare_role_figure(sog_s5f1, 1,  1, "Gandalf the White", [ gandalf_white, gandalf_white_bgime, gandalf_white_pelennor ])
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

    sog_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: sog_s5.id, faction: :minas_morgul, suggested_points: 1000, actual_points: 0, sort_order: 2}
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
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 84,
      map_width: 72, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: sog_s6.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 5, page: 52}

    sog_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: sog_s6.id, faction: :minas_tirith, suggested_points:  750, actual_points: 0, sort_order: 1}
    _declare_role_figure(sog_s6f1, 1, 1, "Gandalf the White", [ gandalf_white, gandalf_white_bgime, gandalf_white_pelennor ])
    _declare_role_figure(sog_s6f1, 1, 2, [ pippin_gondor ])
    _declare_role_figure(sog_s6f1, 1, 3, [ beregond ])
    _declare_role_figure(sog_s6f1, 4, 4, [ gondor_citadel_gd_spear ])
    _declare_role_figure(sog_s6f1, 4, 5, [ gondor_citadel_gd_bow ])
    _declare_role_figure(sog_s6f1, 8, 6, [ gondor_womt_bow ])
    _declare_role_figure(sog_s6f1, 8, 7, [ gondor_womt_spear_shield ])
    _declare_role_figure(sog_s6f1, 6, 8, [ gondor_womt_shield ])
    _declare_role_figure(sog_s6f1, 2, 9, [ gondor_womt_banner ])

    sog_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: sog_s6.id, faction: :minas_morgul, suggested_points: 1000, actual_points: 0, sort_order: 2}
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
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 115,
      map_width: 48, map_height: 48, location: :helms_deep
    }

    Repo.insert! %ScenarioResource{scenario_id: sog_s7.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 6, page: 58}
    _declare_podcast(sog_s7.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-2-helms-deep", "The Green Dragon", 1)

    sog_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: sog_s7.id, faction: :rohan, suggested_points: 250, actual_points: 0, sort_order: 1}
    _declare_role_figure(sog_s7f1, 1,  1, [ aragorn ])
    _declare_role_figure(sog_s7f1, 1,  2, "Gimli", gimli_all_foot)
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

    sog_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: sog_s7.id, faction: :isengard, suggested_points: 375, actual_points: 0, sort_order: 2}
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
    _declare_role_figure(sog_s7f2,  3, 13, [ uruk_hai_demo_charge ])
    _declare_role_figure(sog_s7f2,  6, 14, [ uruk_hai_demo_crew ])
    _declare_role_figure(sog_s7f2,  3, 15, [ uruk_hai_demo_berserker ])

    #========================================================================
    sog_s8 = Repo.insert! %Scenario{
      name: "Forth Eorlingas!",
      blurb: "Theoden leads a mounted charge out from Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 4, size: 105,
      map_width: 72, map_height: 48, location: :helms_deep
    }

    Repo.insert! %ScenarioResource{scenario_id: sog_s8.id, resource_type: :source, book: :sog, title: "Siege of Gondor", sort_order: 7, page: 62}

    sog_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: sog_s8.id, faction: :rohan, suggested_points: 800, actual_points: 0, sort_order: 1}
    _declare_role_figure(sog_s8f1,  1,  1, [ aragorn_horse ])
    _declare_role_figure(sog_s8f1,  1,  2, [ legolas_horse ])
    _declare_role_figure(sog_s8f1,  1,  3, [ theoden_horse ])
    _declare_role_figure(sog_s8f1,  1,  4, [ gamling_horse ])
    _declare_role_figure(sog_s8f1,  1,  5, "Gandalf the White on Shadowfax", [ gandalf_white_horse, gandalf_white_horse_mt ])
    _declare_role_figure(sog_s8f1,  1,  6, [ eomer_horse ])
    _declare_role_figure(sog_s8f1,  5,  7, [ rohan_gd_horse_spear ])
    _declare_role_figure(sog_s8f1,  1,  8, [ rohan_gd_horse_banner ])
    _declare_role_figure(sog_s8f1, 17,  9, [ rohan_rider, rohan_rider_spear ])
    _declare_role_figure(sog_s8f1,  1, 10, [ rohan_rider_banner ])

    sog_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: sog_s8.id, faction: :isengard, suggested_points: 800, actual_points: 0, sort_order: 2}
    _declare_role_figure(sog_s8f2,  4,  1, [ uruk_hai_captain_shield ])
    _declare_role_figure(sog_s8f2,  1,  2, [ uruk_hai_shaman ])
    _declare_role_figure(sog_s8f2, 18,  3, [ uruk_hai_w_shield ])
    _declare_role_figure(sog_s8f2,  2,  4, [ uruk_hai_w_banner ])
    _declare_role_figure(sog_s8f2, 15,  5, [ uruk_hai_w_crossbow ])
    _declare_role_figure(sog_s8f2, 20,  6, [ uruk_hai_w_pike ])
    _declare_role_figure(sog_s8f2, 15,  7, [ uruk_hai_berserker ])

    #########################################################################
    # THERE AND BACK AGAIN
    #########################################################################

    #========================================================================
    tba_s1 = Repo.insert! %Scenario{
      name: "Flies and Spiders Part I",
      blurb: "Can Bilbo rescure Thorin's company from the spiders of Mirkwood?",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 7,
      map_width: 48, map_height: 48, location: :mirkwood
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s1.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 1, page: 10}

    tba_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s1.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s1f1,  1,  1, [ young_bilbo ])

    tba_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s1.id, faction: :dol_guldur, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s1f2,  6,  1, [ mirkwood_spider ])

    #========================================================================
    tba_s2 = Repo.insert! %Scenario{
      name: "Flies and Spiders, Part II",
      blurb: "Legolas and Tauriel attack the spiders attacking Thorin's company.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 54,
      map_width: 48, map_height: 48, location: :mirkwood
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s2.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 2, page: 12}

    tba_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s2.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s2f1,  1, 1, [ thorin ])
    _declare_role_figure(tba_s2f1,  1, 1, [ balin ])
    _declare_role_figure(tba_s2f1,  1, 1, [ dwalin ])
    _declare_role_figure(tba_s2f1,  1, 1, [ fili ])
    _declare_role_figure(tba_s2f1,  1, 1, [ kili ])
    _declare_role_figure(tba_s2f1,  1, 1, [ oin ])
    _declare_role_figure(tba_s2f1,  1, 1, [ gloin ])
    _declare_role_figure(tba_s2f1,  1, 1, [ ori ])
    _declare_role_figure(tba_s2f1,  1, 1, [ nori ])
    _declare_role_figure(tba_s2f1,  1, 1, [ dori ])
    _declare_role_figure(tba_s2f1,  1, 1, [ bifur ])
    _declare_role_figure(tba_s2f1,  1, 1, [ bofur ])
    _declare_role_figure(tba_s2f1,  1, 1, [ bombur ])
    _declare_role_figure(tba_s2f1,  1, 1, [ young_bilbo ])
    _declare_role_figure(tba_s2f1,  1, 1, [ legolas ])
    _declare_role_figure(tba_s2f1,  1, 1, [ tauriel ])
    _declare_role_figure(tba_s2f1, 20, 1, [ mirkwood_ranger ])

    tba_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s2.id, faction: :dol_guldur, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s2f2, 18, 1, [ mirkwood_spider ])

    #========================================================================
    tba_s3 = Repo.insert! %Scenario{
      name: "Barrels Out of Bond, Part I: Open the Gate",
      blurb: "Azog's troops catch up to the dwarves, who are escaping in barrels from the elves.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 74,
      map_width: 72, map_height: 48, location: :mirkwood
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s3.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 3, page: 14}

    tba_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s3.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s3f1,  1,  1, [ thorin_barrel ])
    _declare_role_figure(tba_s3f1,  1,  2, [ balin_barrel ])
    _declare_role_figure(tba_s3f1,  1,  3, [ dwalin_barrel ])
    _declare_role_figure(tba_s3f1,  1,  4, [ fili_barrel ])
    _declare_role_figure(tba_s3f1,  1,  5, [ kili_barrel ])
    _declare_role_figure(tba_s3f1,  1,  6, [ oin_barrel ])
    _declare_role_figure(tba_s3f1,  1,  7, [ gloin_barrel ])
    _declare_role_figure(tba_s3f1,  1,  8, [ ori_barrel ])
    _declare_role_figure(tba_s3f1,  1,  9, [ nori_barrel ])
    _declare_role_figure(tba_s3f1,  1, 10, [ dori_barrel ])
    _declare_role_figure(tba_s3f1,  1, 11, [ bifur_barrel ])
    _declare_role_figure(tba_s3f1,  1, 12, [ bofur_barrel ])
    _declare_role_figure(tba_s3f1,  1, 13, [ bombur_barrel ])
    _declare_role_figure(tba_s3f1,  1, 14, [ young_bilbo_barrel ])
    _declare_role_figure(tba_s3f1,  1, 15, [ legolas ])
    _declare_role_figure(tba_s3f1,  1, 16, [ tauriel ])
    _declare_role_figure(tba_s3f1,  1, 17, [ palace_gd_captain ])
    _declare_role_figure(tba_s3f1, 10, 18, [ mirkwood_ranger ])
    _declare_role_figure(tba_s3f1, 10, 19, [ mirkwood_palace_gd ])

    tba_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s3.id, faction: :azogs_hunters, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s3f2,  1, 1, [ bolg ])
    _declare_role_figure(tba_s3f2,  1, 2, [ narzug ])
    _declare_role_figure(tba_s3f2,  1, 3, [ fimbul ])
    _declare_role_figure(tba_s3f2, 24, 4, [ hunter_orc ])
    _declare_role_figure(tba_s3f2, 12, 5, [ hunter_orc_warg ])

    #========================================================================
    tba_s4 = Repo.insert! %Scenario{
      name: "Barrels Out of Bond, Part II: Down the Forest River",
      blurb: "Thorin's company continues its escape while the Elves try to capture an Orc hero for interrogation.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 76,
      map_width: 72, map_height: 48, location: :mirkwood
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s4.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 4, page: 16}

    tba_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s4.id, faction: :mirkwood, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s4f1,  1,  1, [ thorin_barrel ])
    _declare_role_figure(tba_s4f1,  1,  2, [ balin_barrel ])
    _declare_role_figure(tba_s4f1,  1,  3, [ dwalin_barrel ])
    _declare_role_figure(tba_s4f1,  1,  4, [ fili_barrel ])
    _declare_role_figure(tba_s4f1,  1,  5, [ kili_barrel ])
    _declare_role_figure(tba_s4f1,  1,  6, [ oin_barrel ])
    _declare_role_figure(tba_s4f1,  1,  7, [ gloin_barrel ])
    _declare_role_figure(tba_s4f1,  1,  8, [ ori_barrel ])
    _declare_role_figure(tba_s4f1,  1,  9, [ nori_barrel ])
    _declare_role_figure(tba_s4f1,  1, 10, [ dori_barrel ])
    _declare_role_figure(tba_s4f1,  1, 11, [ bifur_barrel ])
    _declare_role_figure(tba_s4f1,  1, 12, [ bofur_barrel ])
    _declare_role_figure(tba_s4f1,  1, 13, [ bombur_barrel ])
    _declare_role_figure(tba_s4f1,  1, 14, [ young_bilbo_barrel ])
    _declare_role_figure(tba_s4f1,  1, 15, [ legolas ])
    _declare_role_figure(tba_s4f1,  1, 16, [ tauriel ])
    _declare_role_figure(tba_s4f1,  1, 17, [ palace_gd_captain ])
    _declare_role_figure(tba_s4f1, 10, 18, [ mirkwood_ranger ])
    _declare_role_figure(tba_s4f1, 10, 19, [ mirkwood_palace_gd ])

    tba_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s4.id, faction: :azogs_hunters, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s4f2,  1, 1, [ bolg ])
    _declare_role_figure(tba_s4f2,  1, 2, [ fimbul ])
    _declare_role_figure(tba_s4f2,  1, 3, [ narzug ])
    _declare_role_figure(tba_s4f2, 24, 4, [ hunter_orc ])
    _declare_role_figure(tba_s4f2, 12, 5, [ hunter_orc_warg ])

    #========================================================================
    tba_s5 = Repo.insert! %Scenario{
      name: "Lake-town Chase",
      blurb: "Bard tries to prepare for Smaug's attack while being hindered by the Master of Lake-town.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 17,
      map_width: 48, map_height: 48, location: :laketown
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s5.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 5, page: 18}

    tba_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s5.id, faction: :laketown, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s5f1,  1,  1, [ bard ])
    _declare_role_figure(tba_s5f1,  1,  2, [ bain ])

    tba_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s5.id, faction: :laketown, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s5f2,  1, 1, [ master_laketown ])
    _declare_role_figure(tba_s5f2,  1, 2, [ alfrid ])
    _declare_role_figure(tba_s5f2,  1, 3, [ braga ])
    _declare_role_figure(tba_s5f2,  4, 4, [ laketown_gd_w_sword ])
    _declare_role_figure(tba_s5f2,  4, 5, [ laketown_gd_w_spear ])
    _declare_role_figure(tba_s5f2,  4, 6, [ laketown_gd_w_bow ])

    #========================================================================
    tba_s6 = Repo.insert! %Scenario{
      name: "Assassins in the Night",
      blurb: "Fimbul the Hunter attacks the Dwarves hiding out in Bard's house.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 22,
      map_width: 12, map_height: 12, location: :laketown
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s6.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 6, page: 20}

    tba_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s6.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s6f1,  1,  1, [ fili ])
    _declare_role_figure(tba_s6f1,  1,  2, [ kili ])
    _declare_role_figure(tba_s6f1,  1,  3, [ bofur ])
    _declare_role_figure(tba_s6f1,  1,  4, [ oin ])
    _declare_role_figure(tba_s6f1,  1,  5, [ bain ])
    _declare_role_figure(tba_s6f1,  1,  6, [ tauriel ])
    _declare_role_figure(tba_s6f1,  1,  7, [ legolas ])
    _declare_role_figure(tba_s6f1,  1,  8, [ sigrid ])
    _declare_role_figure(tba_s6f1,  1,  9, [ tilda ])

    tba_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s6.id, faction: :azogs_hunters, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s6f2,  1, 1, [ fimbul ])
    _declare_role_figure(tba_s6f2, 12, 2, [ hunter_orc ])

    #========================================================================
    tba_s7 = Repo.insert! %Scenario{
      name: "The Capture of the Grey Wizard",
      blurb: "Gandalf is captured by the denizens of Dol Guldur.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 22,
      map_width: 36, map_height: 24, location: :dol_guldur
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s7.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 7, page: 22}

    tba_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s7.id, faction: :white_council, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s7f1,  1,  1, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(tba_s7f1,  1,  2, [ thrain_broken ])

    tba_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s7.id, faction: :dol_guldur, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s7f2,  1, 1, [ necromancer ])
    _declare_role_figure(tba_s7f2,  1, 2, [ azog ])
    _declare_role_figure(tba_s7f2,  6, 4, [ hunter_orc_warg ])
    _declare_role_figure(tba_s7f2, 12, 4, [ hunter_orc ])

    #========================================================================
    tba_s8 = Repo.insert! %Scenario{
      name: "Fire and Water",
      blurb: "Smaug attacks Lake-town.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 38,
      map_width: 48, map_height: 48, location: :laketown
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s8.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 8, page: 28}

    tba_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s8.id, faction: :laketown, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s8f1,  1,  1, [ bard ])
    _declare_role_figure(tba_s8f1,  1,  2, [ bain ])
    _declare_role_figure(tba_s8f1,  1,  3, [ sigrid ])
    _declare_role_figure(tba_s8f1,  1,  4, [ tilda ])
    _declare_role_figure(tba_s8f1,  1,  5, [ tauriel ])
    _declare_role_figure(tba_s8f1,  1,  6, [ kili ])
    _declare_role_figure(tba_s8f1,  1,  7, [ fili ])
    _declare_role_figure(tba_s8f1,  1,  8, [ bofur ])
    _declare_role_figure(tba_s8f1,  1,  9, [ oin ])
    _declare_role_figure(tba_s8f1,  1, 10, [ master_laketown ])
    _declare_role_figure(tba_s8f1,  1, 11, [ alfrid ])
    _declare_role_figure(tba_s8f1,  1, 12, [ braga ])
    _declare_role_figure(tba_s8f1,  8, 13, [ laketown_gd_w_sword ])
    _declare_role_figure(tba_s8f1,  8, 14, [ laketown_gd_w_spear ])
    _declare_role_figure(tba_s8f1,  8, 15, [ laketown_gd_w_bow ])

    tba_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s8.id, faction: :desolator_north, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s8f2,  1, 1, [ smaug ])

    #========================================================================
    tba_s9 = Repo.insert! %Scenario{
      name: "The Fall of the Necromancer",
      blurb: "The White Council attacks the forces of Evil in Dol Guldur.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 16,
      map_width: 24, map_height: 24, location: :dol_guldur
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s9.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 9, page: 30}

    tba_s9f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s9.id, faction: :white_council, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s9f1,  1,  1, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(tba_s9f1,  1,  2, [ galadriel ])
    _declare_role_figure(tba_s9f1,  1,  3, [ elrond ])
    _declare_role_figure(tba_s9f1,  1,  4, "Saruman the White", saruman_foot_all)
    _declare_role_figure(tba_s9f1,  1,  5, "Radagast the Brown", [ radagast_goblintown, radagast_lotr, radagast_sebastian ])

    tba_s9f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s9.id, faction: :dol_guldur, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s9f2,  1, 1, [ dungeon_keeper ])
    _declare_role_figure(tba_s9f2,  1, 2, [ witch_king ])
    _declare_role_figure(tba_s9f2,  1, 3, [ khamul ])
    _declare_role_figure(tba_s9f2,  1, 4, [ dark_headsman ])
    _declare_role_figure(tba_s9f2,  1, 5, [ forsaken ])
    _declare_role_figure(tba_s9f2,  1, 6, [ lingering_shadow ])
    _declare_role_figure(tba_s9f2,  2, 7, [ abyssal_knight ])
    _declare_role_figure(tba_s9f2,  2, 8, [ slayer_of_men ])

    #========================================================================
    tba_s10 = Repo.insert! %Scenario{
      name: "The Iron Hills Arrive",
      blurb: "Fighting breaks out between the Elves at Erebor and the newly-arrived Iron Hills dwarves led by Dain Ironfoot.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 76,
      map_width: 48, map_height: 48, location: :erebor
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s10.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 10, page: 36}

    tba_s10f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s10.id, faction: :mirkwood, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s10f1,  1,  1, [ thranduil ])
    _declare_role_figure(tba_s10f1,  2,  2, [ mirkwood_captain ])
    _declare_role_figure(tba_s10f1, 12,  3, [ mirkwood_elf_shield ])
    _declare_role_figure(tba_s10f1, 12,  4, [ mirkwood_elf_glaive ])
    _declare_role_figure(tba_s10f1, 12,  5, [ mirkwood_elf_bow ])

    tba_s10f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s10.id, faction: :iron_hills, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s10f2,  1, 1, [ dain_ironfoot ])
    _declare_role_figure(tba_s10f2,  1, 2, [ iron_hills_captain_goat ])
    _declare_role_figure(tba_s10f2, 24, 3, [ iron_hills_goat_rider ])
    _declare_role_figure(tba_s10f2,  2, 4, [ iron_hills_ballista ])
    _declare_role_figure(tba_s10f2,  8, 4, [ iron_hills_ballista_crew ])

    #========================================================================
    tba_s11 = Repo.insert! %Scenario{
      name: "The Clouds Burst",
      blurb: "The Orcs arrive at Erebor to break up the fighting between the Elves and the Dwarves.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 85,
      map_width: 48, map_height: 48, location: :erebor
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s11.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 11, page: 38}

    tba_s11f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s11.id, faction: :iron_hills, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s11f1,  1,  1, [ thranduil ])
    _declare_role_figure(tba_s11f1,  8,  2, [ mirkwood_elf_shield ])
    _declare_role_figure(tba_s11f1,  8,  3, [ mirkwood_elf_glaive ])
    _declare_role_figure(tba_s11f1,  8,  4, [ mirkwood_elf_bow ])
    _declare_role_figure(tba_s11f1,  1,  5, [ dain_ironfoot_boar ])
    _declare_role_figure(tba_s11f1, 24,  6, [ iron_hills_dwarf ])

    tba_s11f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s11.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s11f2,  3, 1, [ gundabad_orc_captain ])
    _declare_role_figure(tba_s11f2,  3, 2, [ gundabad_troll ])
    _declare_role_figure(tba_s11f2, 18, 3, [ gundabad_orc_shield ])
    _declare_role_figure(tba_s11f2, 18, 4, [ gundabad_orc_spear ])

    #========================================================================
    tba_s12 = Repo.insert! %Scenario{
      name: "The Chariots Charge",
      blurb: "The Dwarven war machines counterttack the Orcs at Erebor.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 55,
      map_width: 48, map_height: 48, location: :erebor
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s12.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 12, page: 40}

    tba_s12f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s12.id, faction: :iron_hills, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s12f1,  1,  1, [ iron_hills_captain ])
    _declare_role_figure(tba_s12f1, 12,  2, [ iron_hills_dwarf_shield_spear ])
    _declare_role_figure(tba_s12f1,  2,  3, [ iron_hills_chariot ])

    tba_s12f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s12.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s12f2,  3, 1, [ gundabad_orc_captain ])
    _declare_role_figure(tba_s12f2,  1, 2, [ gundabad_troll ])
    _declare_role_figure(tba_s12f2, 18, 3, [ gundabad_orc_shield ])
    _declare_role_figure(tba_s12f2, 18, 4, [ gundabad_orc_spear ])

    #========================================================================
    tba_s13 = Repo.insert! %Scenario{
      name: "Unleash the War Beasts",
      blurb: "The Gundabad Ogres are called in to handle the Iron Hills Chariots.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 71,
      map_width: 48, map_height: 48, location: :erebor
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s13.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 13, page: 42}

    tba_s13f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s13.id, faction: :iron_hills, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s13f1,  2,  1, [ iron_hills_captain ])
    _declare_role_figure(tba_s13f1, 24,  2, [ iron_hills_dwarf_shield_spear ])
    _declare_role_figure(tba_s13f1,  2,  3, [ iron_hills_chariot ])

    tba_s13f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s13.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s13f2,  3, 1, [ gundabad_orc_captain ])
    _declare_role_figure(tba_s13f2,  4, 2, [ gundabad_ogre ])
    _declare_role_figure(tba_s13f2, 18, 3, [ gundabad_orc_shield ])
    _declare_role_figure(tba_s13f2, 18, 4, [ gundabad_orc_spear ])

    #========================================================================
    tba_s14 = Repo.insert! %Scenario{
      name: "The Breakthrough",
      blurb: "Bard and friends try to break through to the town of Dale.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 36,
      map_width: 48, map_height: 48, location: :dale
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s14.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 14, page: 44}

    tba_s14f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s14.id, faction: :laketown, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s14f1,  1,  1, [ bard ])
    _declare_role_figure(tba_s14f1,  1,  2, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(tba_s14f1,  1,  3, [ young_bilbo ])
    _declare_role_figure(tba_s14f1,  4,  4, [ laketown_militia_shield ])
    _declare_role_figure(tba_s14f1,  4,  5, [ laketown_militia_spear])
    _declare_role_figure(tba_s14f1,  4,  6, [ laketown_militia_bow ])

    tba_s14f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s14.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s14f2,  2, 1, [ gundabad_orc_captain ])
    _declare_role_figure(tba_s14f2,  1, 2, [ catapult_troll ])
    _declare_role_figure(tba_s14f2,  9, 3, [ gundabad_orc_shield ])
    _declare_role_figure(tba_s14f2,  9, 4, [ gundabad_orc_spear ])

    #========================================================================
    tba_s15 = Repo.insert! %Scenario{
      name: "Battle in the Streets",
      blurb: "Bard and friends defend Dale from the depredations of the Gundabads.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 70,
      map_width: 48, map_height: 48, location: :dale
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s15.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 15, page: 46}

    tba_s15f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s15.id, faction: :laketown, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s15f1,  1,  1, [ bard ])
    _declare_role_figure(tba_s15f1,  1,  2, [ percy ])
    _declare_role_figure(tba_s15f1,  1,  3, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(tba_s15f1,  1,  4, [ young_bilbo ])
    _declare_role_figure(tba_s15f1,  1,  5, [ alfrid ])
    _declare_role_figure(tba_s15f1,  8,  6, [ laketown_militia_shield ])
    _declare_role_figure(tba_s15f1,  8,  7, [ laketown_militia_spear])
    _declare_role_figure(tba_s15f1,  8,  8, [ laketown_militia_bow ])

    tba_s15f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s15.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s15f2,  3, 1, [ gundabad_orc_captain ])
    _declare_role_figure(tba_s15f2,  2, 2, [ gundabad_troll ])
    _declare_role_figure(tba_s15f2,  9, 3, [ gundabad_orc_shield ])
    _declare_role_figure(tba_s15f2,  9, 4, [ gundabad_orc_spear ])

    #========================================================================
    tba_s16 = Repo.insert! %Scenario{
      name: "Something Worth Fighting For",
      blurb: "Bard must save his family from a Gundabad Ogre.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 11,
      map_width: 24, map_height: 24, location: :dale
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s16.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 16, page: 48}

    tba_s16f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s16.id, faction: :laketown, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s16f1,  1,  1, [ bard ])
    _declare_role_figure(tba_s16f1,  1,  2, [ bain ])
    _declare_role_figure(tba_s16f1,  1,  3, [ sigrid ])
    _declare_role_figure(tba_s16f1,  1,  4, [ tilda ])

    tba_s16f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s16.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s16f2,  1, 1, [ gundabad_ogre ])
    _declare_role_figure(tba_s16f2,  3, 2, [ gundabad_orc_shield ])
    _declare_role_figure(tba_s16f2,  3, 3, [ gundabad_orc_spear ])

    #========================================================================
    tba_s17 = Repo.insert! %Scenario{
      name: "The Ultimate Price",
      blurb: "Thranduil outpaces his bodyguards and finds himself surrounded by Orcs in the ruins of Dale.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 52,
      map_width: 48, map_height: 48, location: :dale
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s17.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 17, page: 50}

    tba_s17f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s17.id, faction: :mirkwood, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s17f1,  1,  1, [ thranduil ])
    _declare_role_figure(tba_s17f1,  1,  2, [ mirkwood_captain ])
    _declare_role_figure(tba_s17f1,  8,  3, [ mirkwood_elf_shield ])
    _declare_role_figure(tba_s17f1,  8,  4, [ mirkwood_elf_glaive ])
    _declare_role_figure(tba_s17f1,  8,  5, [ mirkwood_elf_bow ])

    tba_s17f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s17.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s17f2,  2, 1, [ gundabad_orc_captain ])
    _declare_role_figure(tba_s17f2, 12, 2, [ gundabad_orc_shield ])
    _declare_role_figure(tba_s17f2, 12, 3, [ gundabad_orc_spear ])

    #========================================================================
    tba_s18 = Repo.insert! %Scenario{
      name: "The People Fight Back",
      blurb: "The people of Lake-town fight back against the forces of Gundabad in the ruins of Dale.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 58,
      map_width: 48, map_height: 48, location: :dale
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s18.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 18, page: 52}

    tba_s18f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s18.id, faction: :laketown, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s18f1,  1,  1, [ bard ])
    _declare_role_figure(tba_s18f1,  1,  2, [ percy ])
    _declare_role_figure(tba_s18f1,  1,  3, [ hilda ])
    _declare_role_figure(tba_s18f1,  1,  4, [ alfrid ])
    _declare_role_figure(tba_s18f1,  1,  5, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(tba_s18f1,  1,  6, [ young_bilbo ])
    _declare_role_figure(tba_s18f1,  8,  7, [ laketown_militia_shield ])
    _declare_role_figure(tba_s18f1,  8,  8, [ laketown_militia_spear ])
    _declare_role_figure(tba_s18f1,  8,  9, [ laketown_militia_bow ])

    tba_s18f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s18.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s18f2,  2, 1, [ gundabad_orc_captain ])
    _declare_role_figure(tba_s18f2,  1, 2, [ gundabad_troll ])
    _declare_role_figure(tba_s18f2,  1, 3, [ gundabad_ogre ])
    _declare_role_figure(tba_s18f2, 12, 4, [ gundabad_orc_shield ])
    _declare_role_figure(tba_s18f2, 12, 5, [ gundabad_orc_spear ])

    #========================================================================
    tba_s19 = Repo.insert! %Scenario{
      name: "To The King!",
      blurb: "Thorin's company enters the fight for Erebor.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 58,
      map_width: 48, map_height: 48, location: :erebor
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s19.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 19, page: 54}

    tba_s19f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s19.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s19f1,  1,  1, [ thorin_erebor ])
    _declare_role_figure(tba_s19f1,  1,  2, [ balin_erebor ])
    _declare_role_figure(tba_s19f1,  1,  3, [ dwalin_erebor ])
    _declare_role_figure(tba_s19f1,  1,  4, [ kili_erebor ])
    _declare_role_figure(tba_s19f1,  1,  5, [ fili_erebor ])
    _declare_role_figure(tba_s19f1,  1,  6, [ bifur_erebor ])
    _declare_role_figure(tba_s19f1,  1,  7, [ bofur_erebor ])
    _declare_role_figure(tba_s19f1,  1,  8, [ bombur_erebor ])
    _declare_role_figure(tba_s19f1,  1,  9, [ ori_erebor ])
    _declare_role_figure(tba_s19f1,  1, 10, [ nori_erebor ])
    _declare_role_figure(tba_s19f1,  1, 11, [ dori_erebor ])
    _declare_role_figure(tba_s19f1,  1, 12, [ oin_erebor ])
    _declare_role_figure(tba_s19f1,  1, 13, [ gloin_erebor ])
    _declare_role_figure(tba_s19f1,  1, 14, [ dain_ironfoot ])
    _declare_role_figure(tba_s19f1, 24, 15, [ iron_hills_dwarf ])

    tba_s19f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s19.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s19f2,  3, 1, [ gundabad_orc_captain ])
    _declare_role_figure(tba_s19f2,  3, 2, [ gundabad_troll ])
    _declare_role_figure(tba_s19f2,  1, 3, [ catapult_troll ])
    _declare_role_figure(tba_s19f2,  2, 4, [ troll_brute ])
    _declare_role_figure(tba_s19f2, 18, 5, [ gundabad_orc_shield ])
    _declare_role_figure(tba_s19f2, 18, 6, [ gundabad_orc_spear ])

    #========================================================================
    tba_s20 = Repo.insert! %Scenario{
      name: "Chase Along the Frozen River",
      blurb: "The Champions of Erebor riding a Chariot plow through legions of Gundabad troops.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 31,
      map_width: 24, map_height: 24, location: :erebor
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s20.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 20, page: 56}

    tba_s20f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s20.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s20f1,  1,  1, [ balin_erebor ])
    _declare_role_figure(tba_s20f1,  1,  2, [ dwalin_erebor ])
    _declare_role_figure(tba_s20f1,  1,  3, [ kili_erebor ])
    _declare_role_figure(tba_s20f1,  1,  4, [ fili_erebor ])
    _declare_role_figure(tba_s20f1,  1,  5, [ iron_hills_chariot ])

    tba_s20f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s20.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s20f2,  2, 1, [ gundabad_troll ])
    _declare_role_figure(tba_s20f2, 12, 2, [ hunter_orc_warg ])
    _declare_role_figure(tba_s20f2, 12, 3, [ fell_warg ])

    #========================================================================
    tba_s21 = Repo.insert! %Scenario{
      name: "Ride to Victory",
      blurb: "Thorin commandeers some goats to raid the Gundabad headquarters on Ravenhill.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 30,
      map_width: 48, map_height: 48, location: :erebor
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s21.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 21, page: 58}

    tba_s21f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s21.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s21f1,  1,  1, [ thorin_goat ])
    _declare_role_figure(tba_s21f1,  1,  2, [ kili_goat ])
    _declare_role_figure(tba_s21f1,  1,  3, [ fili_goat ])
    _declare_role_figure(tba_s21f1,  1,  4, [ dwalin_goat ])

    tba_s21f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s21.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s21f2,  2, 1, [ gundabad_orc_captain ])
    _declare_role_figure(tba_s21f2, 12, 2, [ gundabad_orc_shield ])
    _declare_role_figure(tba_s21f2, 12, 3, [ gundabad_orc_spear ])

    #========================================================================
    tba_s22 = Repo.insert! %Scenario{
      name: "Ambush at Ravenhill",
      blurb: "Thorin's commando raid runs into more than it bargained for.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 30,
      map_width: 24, map_height: 24, location: :erebor
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s22.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 22, page: 60}

    tba_s22f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s22.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s22f1,  1,  1, [ thorin_erebor ])
    _declare_role_figure(tba_s22f1,  1,  2, [ kili_erebor ])
    _declare_role_figure(tba_s22f1,  1,  3, [ fili_erebor ])
    _declare_role_figure(tba_s22f1,  1,  4, [ dwalin_erebor ])

    tba_s22f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s22.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s22f2,  2, 1, [ goblin_mercenary_captain ])
    _declare_role_figure(tba_s22f2, 24, 2, [ goblin_mercenary ])

    #========================================================================
    tba_s23 = Repo.insert! %Scenario{
      name: "Last Stand of the Company",
      blurb: "The Dwarves try to hold out against the continued assaults from the Gundabads.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 82,
      map_width: 48, map_height: 48, location: :erebor
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s23.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 23, page: 62}

    tba_s23f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s23.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s23f1,  1,  1, [ dain_ironfoot ])
    _declare_role_figure(tba_s23f1,  1,  2, [ bifur_erebor ])
    _declare_role_figure(tba_s23f1,  1,  3, [ bofur_erebor ])
    _declare_role_figure(tba_s23f1,  1,  4, [ bombur_erebor ])
    _declare_role_figure(tba_s23f1,  1,  5, [ ori_erebor ])
    _declare_role_figure(tba_s23f1,  1,  6, [ nori_erebor ])
    _declare_role_figure(tba_s23f1,  1,  7, [ dori_erebor ])
    _declare_role_figure(tba_s23f1,  1,  8, [ oin_erebor ])
    _declare_role_figure(tba_s23f1,  1,  9, [ gloin_erebor ])
    _declare_role_figure(tba_s23f1, 24, 10, [ iron_hills_dwarf_shield_spear ])

    tba_s23f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s23.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s23f2,  3, 1, [ gundabad_orc_captain])
    _declare_role_figure(tba_s23f2,  3, 2, [ gundabad_troll ])
    _declare_role_figure(tba_s23f2,  1, 3, [ troll_brute ])
    _declare_role_figure(tba_s23f2,  6, 4, [ war_bat ])
    _declare_role_figure(tba_s23f2, 18, 5, [ gundabad_orc_shield ])
    _declare_role_figure(tba_s23f2, 18, 6, [ gundabad_orc_spear ])

    #========================================================================
    tba_s24 = Repo.insert! %Scenario{
      name: "Beorn's Fury",
      blurb: "Radagast, Beorn, and the Eagles are coming!",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 52,
      map_width: 48, map_height: 48, location: :erebor
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s24.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 24, page: 64}

    tba_s24f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s24.id, faction: :wanderers, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s24f1,  1,  1, [ beorn ])
    _declare_role_figure(tba_s24f1,  1,  2, [ radagast_eagle ])
    _declare_role_figure(tba_s24f1,  1,  3, [ gwaihir ])
    _declare_role_figure(tba_s24f1,  4,  4, [ eagle ])

    tba_s24f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s24.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s24f2,  3, 1, [ gundabad_orc_captain])
    _declare_role_figure(tba_s24f2,  6, 2, [ war_bat ])
    _declare_role_figure(tba_s24f2, 18, 3, [ gundabad_orc_shield ])
    _declare_role_figure(tba_s24f2, 18, 4, [ gundabad_orc_spear ])

    #========================================================================
    tba_s25 = Repo.insert! %Scenario{
      name: "A Clash of Heroes",
      blurb: "The culmination of the battle for Erebor.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 26,
      map_width: 48, map_height: 48, location: :erebor
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s25.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 25, page: 66}

    tba_s25f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s25.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s25f1,  1,  1, [ thorin_erebor ])
    _declare_role_figure(tba_s25f1,  1,  2, [ dwalin_erebor ])
    _declare_role_figure(tba_s25f1,  1,  3, [ kili_erebor ])
    _declare_role_figure(tba_s25f1,  1,  4, [ fili_erebor ])
    _declare_role_figure(tba_s25f1,  1,  5, [ young_bilbo ])
    _declare_role_figure(tba_s25f1,  1,  6, [ tauriel ])
    _declare_role_figure(tba_s25f1,  1,  7, [ legolas ])

    tba_s25f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s25.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s25f2,  1, 1, "Azog with heavy armour and stone flail", [ azog ])
    _declare_role_figure(tba_s25f2, 12, 2, [ gundabad_berserker ])
    _declare_role_figure(tba_s25f2,  3, 3, [ gundabad_orc_shield ])
    _declare_role_figure(tba_s25f2,  3, 4, [ gundabad_orc_spear ])

    #========================================================================
    tba_s26 = Repo.insert! %Scenario{
      name: "The Desolation of Smaug Part I: The Ruin of Dale",
      blurb: "Smaug's first attack on the prosperous city of Dale.",
      date_age: 3, date_year: 2770, date_month: 0, date_day: 0, size: 34,
      map_width: 48, map_height: 48, location: :dale
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s26.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 26, page: 134}

    tba_s26f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s26.id, faction: :dale, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s26f1,  1,  1, [ girion ])
    _declare_role_figure(tba_s26f1,  2,  2, [ dale_captain ])
    _declare_role_figure(tba_s26f1, 30,  3, [ dale_w ])

    tba_s26f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s26.id, faction: :desolator_north, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s26f2,  1, 1, [ smaug ])

    #========================================================================
    tba_s27 = Repo.insert! %Scenario{
      name: "The Desolation of Smaug Part II: The Fall of Erebor",
      blurb: "Having destroyed Dale, Smaug turns his attention to the Dwarven kingdom of Erebor.",
      date_age: 3, date_year: 2770, date_month: 0, date_day: 0, size: 54,
      map_width: 48, map_height: 48, location: :erebor
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s27.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 27, page: 136}

    tba_s27f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s27.id, faction: :army_thror, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s27f1,  1,  1, [ thorin_young ])
    _declare_role_figure(tba_s27f1,  1,  2, [ balin_young ])
    _declare_role_figure(tba_s27f1,  1,  3, [ dwalin_young ])
    _declare_role_figure(tba_s27f1,  1,  4, [ thror ])
    _declare_role_figure(tba_s27f1,  1,  5, [ thrain ])
    _declare_role_figure(tba_s27f1, 24,  6, "Erebor Warriors", [ erebor_w_shield, erebor_w_spear ])
    _declare_role_figure(tba_s27f1, 24,  7, [ grim_hammer_w ])

    tba_s27f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s27.id, faction: :desolator_north, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s27f2,  1, 1, [ smaug ])

    #========================================================================
    tba_s28 = Repo.insert! %Scenario{
      name: "The Battle of Dimrill Dale Part I: The Death of the King",
      blurb: "The Dwarves try to retake Moria while Azog tries to take out Thror.",
      date_age: 3, date_year: 2799, date_month: 0, date_day: 0, size: 130,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s28.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 28, page: 138}

    tba_s28f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s28.id, faction: :army_thror, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s28f1,  1,  1, [ thror ])
    _declare_role_figure(tba_s28f1,  1,  2, [ thrain ])
    _declare_role_figure(tba_s28f1,  1,  3, [ thorin_young ])
    _declare_role_figure(tba_s28f1,  1,  4, [ balin_young ])
    _declare_role_figure(tba_s28f1,  1,  5, [ dwalin_young ])
    _declare_role_figure(tba_s28f1, 36,  6, "Warriors of Erebor", [ erebor_w_shield, erebor_w_spear ])
    _declare_role_figure(tba_s28f1, 36,  7, [ grim_hammer_w ])

    tba_s28f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s28.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s28f2,  1, 1, [ azog ])
    _declare_role_figure(tba_s28f2,  1, 2, [ dungeon_keeper ])
    _declare_role_figure(tba_s28f2,  3, 3, [ gundabad_orc_captain ])
    _declare_role_figure(tba_s28f2, 48, 3, "Gundabad Orcs", [ gundabad_orc_shield, gundabad_orc_spear ])

    #========================================================================
    tba_s29 = Repo.insert! %Scenario{
      name: "The Battle of Dimrill Dale Part II: Thrain's Vengeance",
      blurb: "Having taken out Thror, Azog guns for Thrain.",
      date_age: 3, date_year: 2799, date_month: 0, date_day: 0, size: 38,
      map_width: 24, map_height: 24, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s29.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 29, page: 140}

    tba_s29f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s29.id, faction: :army_thror, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s29f1,  1,  1, [ thrain ])
    _declare_role_figure(tba_s29f1,  1,  2, [ grim_hammer_captain ])
    _declare_role_figure(tba_s29f1, 15,  3, [ grim_hammer_w ])

    tba_s29f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s29.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s29f2,  1, 1, [ azog ])
    _declare_role_figure(tba_s29f2,  1, 2, [ dungeon_keeper ])
    _declare_role_figure(tba_s29f2, 15, 3, "Gundabad Orcs", [ gundabad_orc_shield, gundabad_orc_spear ])

    #========================================================================
    tba_s30 = Repo.insert! %Scenario{
      name: "The Battle of Dimrill Dale Part III: The Oakenshield",
      blurb: "Thorin avenges his kin, though not completely (at least in the movie).",
      date_age: 3, date_year: 2799, date_month: 0, date_day: 0, size: 38,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: tba_s30.id, resource_type: :source, book: :tba, title: "There and Back Again", sort_order: 30, page: 142}

    tba_s30f1 = Repo.insert! %ScenarioFaction{scenario_id: tba_s30.id, faction: :army_thror, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(tba_s30f1,  1,  1, [ thorin_young ])
    _declare_role_figure(tba_s30f1,  1,  2, [ balin_young ])
    _declare_role_figure(tba_s30f1,  1,  3, [ dwalin_young ])
    _declare_role_figure(tba_s30f1, 24,  4, "Warriors of Erebor", [ erebor_w_shield, erebor_w_spear ])
    _declare_role_figure(tba_s30f1, 20,  5, [ grim_hammer_w ])

    tba_s30f2 = Repo.insert! %ScenarioFaction{scenario_id: tba_s30.id, faction: :azogs_legion, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(tba_s30f2,  1, 1, [ azog ])
    _declare_role_figure(tba_s30f2,  1, 2, [ dungeon_keeper ])
    _declare_role_figure(tba_s30f2,  1, 3, [ gundabad_orc_captain ])
    _declare_role_figure(tba_s30f2, 30, 4, "Gundabad Orcs", [ gundabad_orc_shield, gundabad_orc_spear ])

    #########################################################################
    # THE TWO TOWERS
    #########################################################################

    #========================================================================
    ttt_s1 = Repo.insert! %Scenario{
      name: "Scouring of the Westfold",
      blurb: "The Rohirrim try to save villagers from the depredations of the Uruk-hai.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 1, size: 32,
      map_width: 48, map_height: 48, location: :rohan
    }

    Repo.insert! %ScenarioResource{scenario_id: ttt_s1.id, resource_type: :source, book: :ttt, title: "The Two Towers", sort_order: 1, page: 94}
    _declare_web_replay(ttt_s1.id, "http://davetownsend.org/Battles/LotR-20070827/", "DaveT", 1)

    ttt_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s1.id, faction: :rohan, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(ttt_s1f1, 6, 1, [ rohan_rider ])
    _declare_role_figure(ttt_s1f1, 6, 2, [ rohan_rider_spear ])

    ttt_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s1.id, faction: :isengard, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(ttt_s1f2, 10, 1, [ uruk_hai_w_pike ])
    _declare_role_figure(ttt_s1f2, 10, 2, [ uruk_hai_w_shield ])

    #========================================================================
    ttt_s2 = Repo.insert! %Scenario{
      name: "The Wrath of Rohan",
      blurb: "Éomer's warband unwittingly helps Merry and Pippin escape to Fangorn forest.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 29, size: 40,
      map_width: 72, map_height: 48, location: :rohan
    }

    Repo.insert! %ScenarioResource{scenario_id: ttt_s2.id, resource_type: :source, book: :ttt, title: "The Two Towers", sort_order: 2, page: 96}

    ttt_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s2.id, faction: :rohan, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(ttt_s2f1,  1,  1, [ eomer_horse ])
    _declare_role_figure(ttt_s2f1,  1,  2, [ rohan_captain_horse ])
    _declare_role_figure(ttt_s2f1,  1,  3, [ merry ])
    _declare_role_figure(ttt_s2f1,  1,  4, [ pippin ])
    _declare_role_figure(ttt_s2f1,  8,  5, [ rohan_rider_spear ])
    _declare_role_figure(ttt_s2f1,  8,  6, [ rohan_rider ])

    ttt_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s2.id, faction: :isengard, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(ttt_s2f2,  1,  1, [ grishnakh ])
    _declare_role_figure(ttt_s2f2,  1,  2, [ ugluk ])
    _declare_role_figure(ttt_s2f2,  8,  3, [ uruk_hai_s_sword_shield ])
    _declare_role_figure(ttt_s2f2,  5,  4, [ orc_w_shield ])
    _declare_role_figure(ttt_s2f2,  5,  5, [ orc_w_bow ])

    #========================================================================
    ttt_s3 = Repo.insert! %Scenario{
      name: "When Wargs Attack",
      blurb: "A force of Wargs ambushes Théoden and the Three Hunters as they escort the Rohirrim to Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 2, size: 29,
      map_width: 48, map_height: 48, location: :rohan
    }

    Repo.insert! %ScenarioResource{scenario_id: ttt_s3.id, resource_type: :source, book: :ttt, title: "The Two Towers", sort_order: 3, page: 98}

    ttt_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s3.id, faction: :rohan, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(ttt_s3f1,  1,  1, [ theoden_horse ])
    _declare_role_figure(ttt_s3f1,  1,  2, [ aragorn_horse ])
    _declare_role_figure(ttt_s3f1,  1,  3, [ legolas_horse ])
    _declare_role_figure(ttt_s3f1,  1,  4, "Gimli", gimli_all_foot)
    _declare_role_figure(ttt_s3f1,  4,  5, [ rohan_rider ])

    ttt_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s3.id, faction: :isengard, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(ttt_s3f2,  1,  1, [ sharku_warg ])
    _declare_role_figure(ttt_s3f2, 10,  2, [ warg_rider_bow ])
    _declare_role_figure(ttt_s3f2, 10,  3, [ warg_rider_shield_spear ])

    #========================================================================
    ttt_s4 = Repo.insert! %Scenario{
      name: "Ambush in Ithilien",
      blurb: "Faramir's Rangers ambush a large Orcish force.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 7, size: 59,
      map_width: 72, map_height: 48, location: :ithilien
    }

    Repo.insert! %ScenarioResource{scenario_id: ttt_s4.id, resource_type: :source, book: :ttt, title: "The Two Towers", sort_order: 4, page: 100}

    ttt_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s4.id, faction: :minas_tirith, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(ttt_s4f1,  1, 1, [ faramir ])
    _declare_role_figure(ttt_s4f1,  1, 2, [ damrod ])
    _declare_role_figure(ttt_s4f1,  1, 3, [ frodo ])
    _declare_role_figure(ttt_s4f1,  1, 4, [ sam ])
    _declare_role_figure(ttt_s4f1, 16, 5, [ gondor_rog ])

    ttt_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s4.id, faction: :minas_morgul, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(ttt_s4f2,  3, 1, "Orc Captains with shield", [ orc_captain ])
    _declare_role_figure(ttt_s4f2, 10, 2, [ orc_w_shield ])
    _declare_role_figure(ttt_s4f2,  5, 3, [ orc_w_spear ])
    _declare_role_figure(ttt_s4f2,  5, 4, [ orc_w_2h ])
    _declare_role_figure(ttt_s4f2, 10, 5, [ orc_w_bow ])
    _declare_role_figure(ttt_s4f2,  5, 6, [ warg_rider_shield_spear ])
    _declare_role_figure(ttt_s4f2,  1, 7, [ gollum ])

    #========================================================================
    ttt_s5 = Repo.insert! %Scenario{
      name: "The Deeping Wall",
      blurb: "The Uruk-hai attempt to breach the outer defenses of Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 85,
      map_width: 48, map_height: 48, location: :helms_deep
    }

    Repo.insert! %ScenarioResource{scenario_id: ttt_s5.id, resource_type: :source, book: :ttt, title: "The Two Towers", sort_order: 5, page: 102}

    ttt_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s5.id, faction: :rohan,  suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(ttt_s5f1, 1,  1, [ aragorn ])
    _declare_role_figure(ttt_s5f1, 1,  2, [ legolas ])
    _declare_role_figure(ttt_s5f1, 1,  3, "Gimli", gimli_all_foot)
    _declare_role_figure(ttt_s5f1, 1,  4, [ haldir ])
    _declare_role_figure(ttt_s5f1, 8,  5, "Rohan Warriors with swords and throwing spears", [ rohan_w_spear_shield ])
    _declare_role_figure(ttt_s5f1, 8,  6, [ wood_elf_w_armor_bow ])

    ttt_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s5.id, faction: :isengard,  suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(ttt_s5f2,  3,  1, "Uruk-hai Captains", [ uruk_hai_captain_shield, uruk_hai_captain_2h ])
    _declare_role_figure(ttt_s5f2, 30,  2, [ uruk_hai_w_shield ])
    _declare_role_figure(ttt_s5f2, 10,  3, [ uruk_hai_w_crossbow ])
    _declare_role_figure(ttt_s5f2, 10,  4, [ uruk_hai_berserker ])
    _declare_role_figure(ttt_s5f2,  1,  5, [ uruk_hai_ballista ])
    _declare_role_figure(ttt_s5f2,  3,  6, [ uruk_hai_ballista_crew ])
    _declare_role_figure(ttt_s5f2,  2,  7, [ uruk_hai_demo_charge ])
    _declare_role_figure(ttt_s5f2,  4,  8, [ uruk_hai_demo_crew ])
    _declare_role_figure(ttt_s5f2,  2,  9, [ uruk_hai_demo_berserker ])

    #========================================================================
    ttt_s6 = Repo.insert! %Scenario{
      name: "The Gateway",
      blurb: "The Uruk-hai try to batter down the gates of Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 69,
      map_width: 48, map_height: 48, location: :helms_deep
    }

    Repo.insert! %ScenarioResource{scenario_id: ttt_s6.id, resource_type: :source, book: :ttt, title: "The Two Towers", sort_order: 6, page: 104}

    ttt_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s6.id, faction: :rohan,  suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(ttt_s6f1, 1,  1, [ gamling ])
    _declare_role_figure(ttt_s6f1, 1,  2, [ aragorn ])
    _declare_role_figure(ttt_s6f1, 1,  3, [ legolas ])
    _declare_role_figure(ttt_s6f1, 1,  4, "Gimli", gimli_all_foot)
    _declare_role_figure(ttt_s6f1, 8,  5, [ rohan_w_spear_shield ])
    _declare_role_figure(ttt_s6f1, 2,  6, [ rohan_w_bow ])

    ttt_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s6.id, faction: :isengard,  suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(ttt_s6f2,  2,  1, [ uruk_hai_captain_shield ])
    _declare_role_figure(ttt_s6f2, 30,  5, [ uruk_hai_w_shield ])
    _declare_role_figure(ttt_s6f2, 10,  4, [ uruk_hai_w_crossbow ])
    _declare_role_figure(ttt_s6f2, 10,  3, [ uruk_hai_berserker ])
    _declare_role_figure(ttt_s6f2,  2,  7, [ uruk_hai_ballista ])
    _declare_role_figure(ttt_s6f2,  1,  7, [ battering_ram ])

    #========================================================================
    ttt_s7 = Repo.insert! %Scenario{
      name: "Théoden Rides Out",
      blurb: "Théoden leads a desperate counterattack against the Uruk-hai at Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 33,
      map_width: 48, map_height: 48, location: :helms_deep
    }

    Repo.insert! %ScenarioResource{scenario_id: ttt_s7.id, resource_type: :source, book: :ttt, title: "The Two Towers", sort_order: 7, page: 106}

    ttt_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s7.id, faction: :rohan,  suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(ttt_s7f1, 1,  1, [ theoden_horse ])
    _declare_role_figure(ttt_s7f1, 1,  2, [ gamling_horse ])
    _declare_role_figure(ttt_s7f1, 1,  3, [ aragorn_horse ])
    _declare_role_figure(ttt_s7f1, 1,  4, [ legolas_horse ])
    _declare_role_figure(ttt_s7f1, 1,  5, "Gimli", gimli_all_foot)
    _declare_role_figure(ttt_s7f1, 4,  6, [ rohan_rider_spear ])

    ttt_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s7.id, faction: :isengard,  suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(ttt_s7f2,  2,  1, [ uruk_hai_captain_shield ])
    _declare_role_figure(ttt_s7f2, 12,  2, [ uruk_hai_w_shield ])
    _declare_role_figure(ttt_s7f2,  8,  3, [ uruk_hai_w_crossbow ])
    _declare_role_figure(ttt_s7f2,  2,  4, [ uruk_hai_berserker ])

    #========================================================================
    ttt_s8 = Repo.insert! %Scenario{
      name: "The Relief of Helm's Deep",
      blurb: "Gandalf arrives in the nick to time to save Théoden.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 115,
      map_width: 48, map_height: 48, location: :helms_deep
    }

    Repo.insert! %ScenarioResource{scenario_id: ttt_s8.id, resource_type: :source, book: :ttt, title: "The Two Towers", sort_order: 8, page: 108}

    ttt_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s8.id, faction: :rohan,  suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(ttt_s8f1,  1,  1, [ theoden_horse ])
    _declare_role_figure(ttt_s8f1,  1,  2, [ gamling_horse ])
    _declare_role_figure(ttt_s8f1,  1,  3, [ aragorn_horse ])
    _declare_role_figure(ttt_s8f1,  1,  4, [ legolas_horse ])
    _declare_role_figure(ttt_s8f1,  1,  5, "Gandalf the White on Shadowfax", [ gandalf_white_horse, gandalf_white_horse_mt ])
    _declare_role_figure(ttt_s8f1,  1,  6, [ eomer_horse ])
    _declare_role_figure(ttt_s8f1,  1,  7, "Gimli", gimli_all_foot)
    _declare_role_figure(ttt_s8f1, 24,  8, [ rohan_rider ])
    _declare_role_figure(ttt_s8f1, 10,  9, [ rohan_rider_spear ])

    ttt_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s8.id, faction: :isengard,  suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(ttt_s8f2,  4,  1, "Uruk-hai Captains", [ uruk_hai_captain_shield, uruk_hai_captain_2h ])
    _declare_role_figure(ttt_s8f2, 20,  2, [ uruk_hai_w_shield ])
    _declare_role_figure(ttt_s8f2, 20,  3, [ uruk_hai_w_pike ])
    _declare_role_figure(ttt_s8f2, 20,  4, [ uruk_hai_w_crossbow ])
    _declare_role_figure(ttt_s8f2, 10,  5, [ uruk_hai_berserker ])

    #========================================================================
    ttt_s9 = Repo.insert! %Scenario{
      name: "Osgiliath",
      blurb: "Faramir discovers his quality.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 9, size: 92,
      map_width: 48, map_height: 48, location: :osgiliath
    }

    Repo.insert! %ScenarioResource{scenario_id: ttt_s9.id, resource_type: :source, book: :ttt, title: "The Two Towers", sort_order: 9, page: 110}

    ttt_s9f1 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s9.id, faction: :minas_tirith,  suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(ttt_s9f1,  1,  1, [ frodo ])
    _declare_role_figure(ttt_s9f1,  1,  2, [ sam ])
    _declare_role_figure(ttt_s9f1,  1,  3, [ faramir ])
    _declare_role_figure(ttt_s9f1,  1,  4, [ damrod ])
    _declare_role_figure(ttt_s9f1,  1,  5, [ gondor_captain_mt ])
    _declare_role_figure(ttt_s9f1,  8,  6, [ gondor_rog ])
    _declare_role_figure(ttt_s9f1,  8,  7, [ gondor_womt_spear_shield ])
    _declare_role_figure(ttt_s9f1,  8,  9, [ gondor_womt_bow ])

    ttt_s9f2 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s9.id, faction: :minas_morgul,  suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(ttt_s9f2,  2,  1, "Orc Captains with shield", [ orc_captain ])
    _declare_role_figure(ttt_s9f2, 20,  2, [ orc_w_shield ])
    _declare_role_figure(ttt_s9f2, 20,  3, [ orc_w_spear ])
    _declare_role_figure(ttt_s9f2, 20,  4, [ orc_w_bow ])
    _declare_role_figure(ttt_s9f2,  1,  5, [ gollum ])

    #========================================================================
    ttt_s10 = Repo.insert! %Scenario{
      name: "Isengard",
      blurb: "Suppose the Good Heroes at Helm's Deep had helped Treebeard attack Isengard?",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 58,
      map_width: 48, map_height: 48, location: :isengard
    }

    Repo.insert! %ScenarioResource{scenario_id: ttt_s10.id, resource_type: :source, book: :ttt, title: "The Two Towers", sort_order: 10, page: 112}

    ttt_s10f1 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s10.id, faction: :rohan,  suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(ttt_s10f1,  1,  1, [ aragorn_horse ])
    _declare_role_figure(ttt_s10f1,  1,  2, [ legolas_horse ])
    _declare_role_figure(ttt_s10f1,  1,  3, "Gandalf the White on Shadowfax", [ gandalf_white_horse, gandalf_white_horse_mt ])
    _declare_role_figure(ttt_s10f1,  1,  4, [ theoden_horse ])
    _declare_role_figure(ttt_s10f1,  1,  5, [ gamling_horse ])
    _declare_role_figure(ttt_s10f1,  1,  6, "Gimli", gimli_all_foot)
    _declare_role_figure(ttt_s10f1,  1,  7, [ merry ])
    _declare_role_figure(ttt_s10f1,  1,  8, [ pippin ])
    _declare_role_figure(ttt_s10f1,  1,  9, [ treebeard ])

    ttt_s10f2 = Repo.insert! %ScenarioFaction{scenario_id: ttt_s10.id, faction: :isengard,  suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(ttt_s10f2,  1,  1, "Saruman the White", saruman_foot_all)
    _declare_role_figure(ttt_s10f2,  1,  2, [ grima ])
    _declare_role_figure(ttt_s10f2,  2,  3, [ uruk_hai_captain_shield ])
    _declare_role_figure(ttt_s10f2, 20,  4, [ uruk_hai_w_shield ])
    _declare_role_figure(ttt_s10f2, 10,  5, [ uruk_hai_w_crossbow ])
    _declare_role_figure(ttt_s10f2,  5,  6, [ uruk_hai_berserker ])
    _declare_role_figure(ttt_s10f2, 10,  7, [ uruk_hai_w_pike ])

    #########################################################################
    # THE TWO TOWERS JOURNEYBOOK
    #########################################################################

    #========================================================================
    tttjb_s1 = Repo.insert! %Scenario{
      name: "Let's Hunt Some Orc",
      blurb: "Aragorn, Legolas, and Gimli encounter the rear guard of the Uruk-hai which have captured Merry and Pippin.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 27, size: 18,
      map_width: 24, map_height: 24, location: :rohan
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s1.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 1, page: 14}

    tttjb_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s1.id, faction: :fellowship, suggested_points: 450, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s1f1, 1, 1, [ aragorn ])
    _declare_role_figure(tttjb_s1f1, 1, 2, [ legolas ])
    _declare_role_figure(tttjb_s1f1, 1, 3, "Gimli", gimli_all_foot)

    tttjb_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s1.id, faction: :isengard, suggested_points: 175, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s1f2, 8, 1, [ uruk_hai_s ])
    _declare_role_figure(tttjb_s1f2, 4, 2, [ uruk_hai_s_sword_shield ])
    _declare_role_figure(tttjb_s1f2, 3, 3, [ uruk_hai_s_bow ])

    #========================================================================
    tttjb_s2 = Repo.insert! %Scenario{
      name: "The First Battle of the Fords of Isen",
      blurb: "Saruman's first assault on Rohan, attempting to kill Théodred, the heir to Rohan.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 25, size: 83,
      map_width: 48, map_height: 48, location: :rohan
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s2.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 2, page: 20}

    tttjb_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s2.id, faction: :rohan, suggested_points: 575, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s2f1, 1,  1, [ theodred_horse ])
    _declare_role_figure(tttjb_s2f1, 1,  2, [ erkenbrand_horse ])
    _declare_role_figure(tttjb_s2f1, 1,  3, [ rohan_captain ])
    _declare_role_figure(tttjb_s2f1, 3,  4, [ rohan_outrider ])
    _declare_role_figure(tttjb_s2f1, 8,  5, [ rohan_w_shield ])
    _declare_role_figure(tttjb_s2f1, 8,  6, [ rohan_w_spear_shield ])
    _declare_role_figure(tttjb_s2f1, 8,  7, [ rohan_w_bow ])
    _declare_role_figure(tttjb_s2f1, 8,  8, [ rohan_rider ])
    _declare_role_figure(tttjb_s2f1, 4,  9, [ rohan_rider_spear ])
    _declare_role_figure(tttjb_s2f1, 1, 10, [ rohan_w_banner ])

    tttjb_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s2.id, faction: :isengard, suggested_points: 575, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s2f2, 1,  1, "Vraskû, Scout Uruk-hai Captain", [ vrasku ])
    _declare_role_figure(tttjb_s2f2, 1,  2, [ dunlending_chieftain ])
    _declare_role_figure(tttjb_s2f2, 1,  3, [ isengard_troll ])
    _declare_role_figure(tttjb_s2f2, 3,  4, [ dunlending_w_shield ])
    _declare_role_figure(tttjb_s2f2, 3,  5, [ dunlending_w_bow ])
    _declare_role_figure(tttjb_s2f2, 3,  6, [ dunlending_w_2h ])
    _declare_role_figure(tttjb_s2f2, 8,  7, [ uruk_hai_s ])
    _declare_role_figure(tttjb_s2f2, 8,  8, [ uruk_hai_s_sword_shield ])
    _declare_role_figure(tttjb_s2f2, 8,  9, [ uruk_hai_s_bow ])
    _declare_role_figure(tttjb_s2f2, 3, 10, [ uruk_hai_feral ])
    _declare_role_figure(tttjb_s2f2, 1, 11, [ dunlending_w_banner ])

    #========================================================================
    tttjb_s3 = Repo.insert! %Scenario{
      name: "The Scouring of the Westfold",
      blurb: "A small Isengard force raids a village of the Rohirrim.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 1, size: 43,
      map_width: 48, map_height: 48, location: :rohan
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s3.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 3, page: 22}
    _declare_podcast(tttjb_s3.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-10-scouring-of-the-westfold", "The Green Dragon", 1)

    tttjb_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s3.id, faction: :rohan, suggested_points: 300, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s3f1, 1, 1, [ rohan_captain ])
    _declare_role_figure(tttjb_s3f1, 1, 2, [ rohan_captain_horse ])
    _declare_role_figure(tttjb_s3f1, 3, 3, [ rohan_outrider ])
    _declare_role_figure(tttjb_s3f1, 4, 4, [ rohan_w_shield ])
    _declare_role_figure(tttjb_s3f1, 4, 5, [ rohan_w_spear_shield ])
    _declare_role_figure(tttjb_s3f1, 4, 6, [ rohan_w_bow ])
    _declare_role_figure(tttjb_s3f1, 1, 7, [ rohan_w_banner ])
    _declare_role_figure(tttjb_s3f1, 1, 8, [ rohan_rider_banner ])

    tttjb_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s3.id, faction: :isengard, suggested_points: 300, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s3f2, 1, 1, [ dunlending_chieftain ])
    _declare_role_figure(tttjb_s3f2, 1, 2, [ uruk_hai_captain_2h ])
    _declare_role_figure(tttjb_s3f2, 3, 3, [ dunlending_w_shield ])
    _declare_role_figure(tttjb_s3f2, 3, 4, [ dunlending_w_2h ])
    _declare_role_figure(tttjb_s3f2, 3, 5, [ dunlending_w_bow ])
    _declare_role_figure(tttjb_s3f2, 8, 6, [ uruk_hai_s_sword_shield ])
    _declare_role_figure(tttjb_s3f2, 4, 7, [ uruk_hai_s_bow ])
    _declare_role_figure(tttjb_s3f2, 1, 8, [ dunlending_w_banner ])

    #========================================================================
    tttjb_s4 = Repo.insert! %Scenario{
      name: "The Wrath of Rohan",
      blurb: "Eomer's riders ambush the Orcs and Uruk-hai as they bring Merry and Pippin to Isengard.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 29, size: 86,
      map_width: 48, map_height: 48, location: :rohan
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s4.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 4, page: 24}
    _declare_web_replay(tttjb_s4.id, "http://davetownsend.org/Battles/LotR-20061029/", "DaveT", 1)

    tttjb_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s4.id, faction: :rohan, suggested_points: 500, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s4f1,  1, 1, "Meriadoc Brandybuck with Elven cloak", [ merry ])
    _declare_role_figure(tttjb_s4f1,  1, 2, "Peregrin Took with Elven cloak", [ pippin ])
    _declare_role_figure(tttjb_s4f1,  1, 3, [ eomer_horse ])
    _declare_role_figure(tttjb_s4f1,  1, 4, [ rohan_captain_horse ])
    _declare_role_figure(tttjb_s4f1,  3, 5, [ rohan_outrider ])
    _declare_role_figure(tttjb_s4f1, 12, 6, [ rohan_rider ])
    _declare_role_figure(tttjb_s4f1,  6, 7, [ rohan_rider_spear ])
    _declare_role_figure(tttjb_s4f1,  1, 8, [ rohan_rider_banner ])

    tttjb_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s4.id, faction: :isengard, suggested_points: 475, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s4f2, 1, 1, [ ugluk ])
    _declare_role_figure(tttjb_s4f2, 1, 2, [ grishnakh ])
    _declare_role_figure(tttjb_s4f2, 8, 3, [ uruk_hai_s ])
    _declare_role_figure(tttjb_s4f2, 8, 4, [ uruk_hai_s_sword_shield ])
    _declare_role_figure(tttjb_s4f2, 8, 5, [ uruk_hai_s_bow ])
    _declare_role_figure(tttjb_s4f2, 8, 6, [ orc_w_shield ])
    _declare_role_figure(tttjb_s4f2, 8, 7, [ orc_w_spear ])
    _declare_role_figure(tttjb_s4f2, 4, 8, [ orc_w_bow ])
    _declare_role_figure(tttjb_s4f2, 4, 9, [ orc_w_2h ])

    #========================================================================
    tttjb_s5 = Repo.insert! %Scenario{
      name: "Alone in Fangorn",
      blurb: "Merry and Pippin escape into Fangorn, pursued by Grishnákh (or a small mixed force of Orcs and Uruk-hai).",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 29, size: 10,
      map_width: 24, map_height: 24, location: :fangorn
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s5.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 5, page: 28}

    tttjb_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s5.id, faction: :fellowship, suggested_points: 225, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s5f1, 1, 1, "Meriadoc Brandybuck with Elven cloak", [ merry ])
    _declare_role_figure(tttjb_s5f1, 1, 2, "Peregrin Took with Elven cloak", [ pippin ])
    _declare_role_figure(tttjb_s5f1, 1, 3, [ treebeard ])

    tttjb_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s5.id, faction: :isengard, suggested_points: 50, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s5f2, 1, 1, [ orc_w_shield ])
    _declare_role_figure(tttjb_s5f2, 1, 2, [ orc_w_spear ])
    _declare_role_figure(tttjb_s5f2, 1, 3, [ orc_w_bow ])
    _declare_role_figure(tttjb_s5f2, 1, 4, [ orc_w_2h ])
    _declare_role_figure(tttjb_s5f2, 1, 5, [ uruk_hai_s ])
    _declare_role_figure(tttjb_s5f2, 1, 6, [ uruk_hai_s_sword_shield ])
    _declare_role_figure(tttjb_s5f2, 1, 7, [ uruk_hai_s_bow ])

    #========================================================================
    tttjb_s6 = Repo.insert! %Scenario{
      name: "Warg Attack",
      blurb: "A force of Wargs ambushes Théoden and the Three Hunters as they escort the Rohirrim to Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 2, size: 31,
      map_width: 48, map_height: 48, location: :rohan
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s6.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 6, page: 32}

    tttjb_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s6.id, faction: :rohan, suggested_points: 650, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s6f1, 1, 1, "Aragorn with Andúril, Elven cloak, and horse", [ aragorn_horse ])
    _declare_role_figure(tttjb_s6f1, 1, 2, "Legolas with Elven cloak and horse", [ legolas_horse ])
    _declare_role_figure(tttjb_s6f1, 1, 3, "Legolas with Elven cloak and horse", [ legolas_horse ])
    _declare_role_figure(tttjb_s6f1, 1, 4, "Gimli with Elven cloak", gimli_all_foot)
    _declare_role_figure(tttjb_s6f1, 1, 5, [ theoden_horse ])
    _declare_role_figure(tttjb_s6f1, 1, 6, [ gamling_horse ])
    _declare_role_figure(tttjb_s6f1, 1, 7, [ rohan_captain_horse ])
    _declare_role_figure(tttjb_s6f1, 4, 8, [ rohan_rider ])
    _declare_role_figure(tttjb_s6f1, 2, 9, [ rohan_rider_spear ])

    tttjb_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s6.id, faction: :isengard, suggested_points: 350, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s6f2, 1, 1, [ sharku_warg ])
    _declare_role_figure(tttjb_s6f2, 6, 2, [ warg_rider_shield ])
    _declare_role_figure(tttjb_s6f2, 6, 3, [ warg_rider_shield_spear ])
    _declare_role_figure(tttjb_s6f2, 6, 4, [ warg_rider_bow ])

    #========================================================================
    tttjb_s7 = Repo.insert! %Scenario{
      name: "The Second Battle of the Fords of Isen",
      blurb: "Erkenbrand delays an Isengard force trying to whittle down the Rohirrim.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 2, size: 104,
      map_width: 48, map_height: 48, location: :rohan
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s7.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 7, page: 34}

    tttjb_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s7.id, faction: :rohan, suggested_points: 600, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s7f1, 1,  1, [ erkenbrand ])
    _declare_role_figure(tttjb_s7f1, 1,  2, [ rohan_captain ])
    _declare_role_figure(tttjb_s7f1, 1,  3, [ rohan_captain_horse ])
    _declare_role_figure(tttjb_s7f1, 5,  4, [ rohan_gd_horse_spear ])
    _declare_role_figure(tttjb_s7f1, 6,  5, [ rohan_gd_spear ])
    _declare_role_figure(tttjb_s7f1, 4,  6, [ rohan_rider_spear ])
    _declare_role_figure(tttjb_s7f1, 8,  7, [ rohan_rider ])
    _declare_role_figure(tttjb_s7f1, 8,  8, [ rohan_w_bow ])
    _declare_role_figure(tttjb_s7f1, 8,  9, [ rohan_w_shield ])
    _declare_role_figure(tttjb_s7f1, 8, 10, [ rohan_w_spear_shield ])
    _declare_role_figure(tttjb_s7f1, 1, 11, [ rohan_w_banner ])

    tttjb_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s7.id, faction: :isengard, suggested_points: 775, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s7f2, 1,  1, [ dunlending_chieftain ])
    _declare_role_figure(tttjb_s7f2, 1,  2, [ vrasku ])
    _declare_role_figure(tttjb_s7f2, 1,  3, [ uruk_hai_shaman ])
    _declare_role_figure(tttjb_s7f2, 5,  4, [ dunlending_w_2h ])
    _declare_role_figure(tttjb_s7f2, 5,  5, [ dunlending_w_bow ])
    _declare_role_figure(tttjb_s7f2, 5,  6, [ dunlending_w_shield ])
    _declare_role_figure(tttjb_s7f2, 8,  7, [ uruk_hai_s_bow ])
    _declare_role_figure(tttjb_s7f2, 8,  8, [ uruk_hai_s_sword_shield ])
    _declare_role_figure(tttjb_s7f2, 3,  9, [ uruk_hai_feral ])
    _declare_role_figure(tttjb_s7f2, 6, 10, [ warg_rider_spear ])
    _declare_role_figure(tttjb_s7f2, 6, 11, [ warg_rider_shield ])
    _declare_role_figure(tttjb_s7f2, 1, 12, [ isengard_troll ])
    _declare_role_figure(tttjb_s7f2, 1, 13, [ dunlending_w_banner ])

    #========================================================================
    tttjb_s8 = Repo.insert! %Scenario{
      name: "The Last March of the Ents",
      blurb: "The Ents storm Isengard",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 40,
      map_width: 48, map_height: 24, location: :isengard
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s8.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 8, page: 38}
    _declare_web_replay(tttjb_s8.id, "http://www.davetownsend.org/Battles/LotR-20150922/", "DaveT", 1)
    _declare_web_replay(tttjb_s8.id, "http://www.davetownsend.org/Battles/LotR-20151011/", "DaveT", 2)

    tttjb_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s8.id, faction: :wanderers, suggested_points: 550, actual_points: 0, sort_order: 1}
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

    #========================================================================
    tttjb_s9 = Repo.insert! %Scenario{
      name: "The Taming of Sméagol",
      blurb: "Gollum attempts to sneak up on Sam and Frodo to steal the One Ring.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 29, size: 3,
      map_width: 24, map_height: 24, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s9.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 9, page: 46}
    _declare_video_replay(tttjb_s9.id, "https://www.youtube.com/watch?v=CBH__WZh5pA&index=5&list=PLa_Dq2-Vx86KjLv5JCpygwNALLzzh5zG9", "Mid-Sussex Wargamers", 1)

    tttjb_s9f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s9.id, faction: :fellowship, suggested_points: 150, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s9f1, 1, 1, "Frodo Baggins with Sting, mithril coat, and Elven cloak", [ frodo ])
    _declare_role_figure(tttjb_s9f1, 1, 2, "Sam Gamgee with Elven cloak", [ sam ])

    tttjb_s9f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s9.id, faction: :cirith_ungol, suggested_points: 150, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s9f2, 1, 1, [ smeagol ])

    #========================================================================
    tttjb_s10 = Repo.insert! %Scenario{
      name: "The Passage of the Marshes",
      blurb: "Sméagol leads Frodo and Sam through the Dead Marshes while a Ringwraith on a Fell Beast searches overhead.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 1, size: 14,
      map_width: 36, map_height: 36, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s10.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 10, page: 52}

    tttjb_s10f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s10.id, faction: :fellowship, suggested_points: 150, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s10f1, 1, 1, "Frodo Baggins with Sting, mithril coat, and Elven cloak", [ frodo ])
    _declare_role_figure(tttjb_s10f1, 1, 2, "Sam Gamgee with Elven cloak", [ sam ])
    _declare_role_figure(tttjb_s10f1, 1, 3, [ smeagol ])

    tttjb_s10f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s10.id, faction: :minas_morgul, suggested_points: 275, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s10f2, 1, 1, [ ringwraith_fellbeast ])
    _declare_role_figure(tttjb_s10f2, 3, 2, [ spectre ])
    _declare_role_figure(tttjb_s10f2, 6, 3, [ morgul_stalker ])

    #========================================================================
    tttjb_s11 = Repo.insert! %Scenario{
      name: "Ambush in Ithilien",
      blurb: "Faramir's Rangers ambush a Southron force, complete with Mûmak.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 7, size: 55,
      map_width: 48, map_height: 48, location: :ithilien
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s11.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 11, page: 60}

    tttjb_s11f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s11.id, faction: :minas_tirith, suggested_points: 375, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s11f1,  1, 1, "Faramir with bow", [ faramir ])
    _declare_role_figure(tttjb_s11f1,  1, 2, [ madril ])
    _declare_role_figure(tttjb_s11f1,  1, 3, [ damrod ])
    _declare_role_figure(tttjb_s11f1,  1, 4, "Frodo Baggins with Sting, mithril coat, and Elven cloak", [ frodo ])
    _declare_role_figure(tttjb_s11f1,  1, 5, "Sam Gamgee with Elven cloak", [ sam ])
    _declare_role_figure(tttjb_s11f1, 10, 6, [ gondor_rog ])

    tttjb_s11f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s11.id, faction: :harad, suggested_points: 625, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s11f2,  1, 1, [ harad_chieftain ])
    _declare_role_figure(tttjb_s11f2,  1, 1, [ harad_chieftain_horse ])
    _declare_role_figure(tttjb_s11f2,  1, 1, [ mumak ])
    _declare_role_figure(tttjb_s11f2, 18, 1, [ harad_w_spear ])
    _declare_role_figure(tttjb_s11f2, 18, 1, [ harad_w_bow ])
    _declare_role_figure(tttjb_s11f2,  1, 1, [ harad_w_banner ])

    #========================================================================
    tttjb_s12 = Repo.insert! %Scenario{
      name: "Osgiliath",
      blurb: "Faramir leads a rear-guard action against Mordor's assault on Osgiliath.",
      date_age: 3, date_year: 3018, date_month: 6, date_day: 20, size: 54,
      map_width: 48, map_height: 24, location: :osgiliath
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s12.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 12, page: 62}

    tttjb_s12f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s12.id, faction: :minas_tirith, suggested_points: 375, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s12f1, 1, 1, "Faramir with bow", [ faramir ])
    _declare_role_figure(tttjb_s12f1, 1, 2, [ madril ])
    _declare_role_figure(tttjb_s12f1, 1, 3, [ damrod ])
    _declare_role_figure(tttjb_s12f1, 1, 4, [ gondor_captain_mt ])
    _declare_role_figure(tttjb_s12f1, 6, 5, [ gondor_rog ])
    _declare_role_figure(tttjb_s12f1, 3, 6, [ osgiliath_v_shield ])
    _declare_role_figure(tttjb_s12f1, 3, 7, [ osgiliath_v_spear ])
    _declare_role_figure(tttjb_s12f1, 3, 8, [ osgiliath_v_bow ])
    _declare_role_figure(tttjb_s12f1, 1, 9, [ gondor_womt_banner ])

    tttjb_s12f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s12.id, faction: :minas_morgul, suggested_points: 375, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s12f2, 2, 1, [ orc_captain ])
    _declare_role_figure(tttjb_s12f2, 6, 2, [ morgul_stalker ])
    _declare_role_figure(tttjb_s12f2, 8, 3, [ orc_w_shield ])
    _declare_role_figure(tttjb_s12f2, 8, 4, [ orc_w_spear ])
    _declare_role_figure(tttjb_s12f2, 4, 5, [ orc_w_bow ])
    _declare_role_figure(tttjb_s12f2, 4, 6, [ orc_w_2h ])
    _declare_role_figure(tttjb_s12f2, 2, 7, [ orc_w_banner ])

    #========================================================================
    tttjb_s13 = Repo.insert! %Scenario{
      name: "The Deeping Wall",
      blurb: "An Isengard siege force attempts to blow up some of the defenses of Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 89,
      map_width: 48, map_height: 24, location: :helms_deep
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s13.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 13, page: 72}

    tttjb_s13f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s13.id, faction: :rohan, suggested_points: 550, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s13f1, 1, 1, "Aragorn with Andúril and armour", [ aragorn ])
    _declare_role_figure(tttjb_s13f1, 1, 2, "Legolas with armour and Elven cloak", [ legolas ])
    _declare_role_figure(tttjb_s13f1, 1, 3, "Gimli with Elven cloak", gimli_all_foot)
    _declare_role_figure(tttjb_s13f1, 1, 4, [ hama ])
    _declare_role_figure(tttjb_s13f1, 8, 5, [ rohan_w_spear_shield ])
    _declare_role_figure(tttjb_s13f1, 8, 6, [ rohan_w_shield ])
    _declare_role_figure(tttjb_s13f1, 8, 7, [ rohan_w_bow ])

    tttjb_s13f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s13.id, faction: :isengard, suggested_points: 850, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s13f2,  1,  1, [ uruk_hai_captain_2h ])
    _declare_role_figure(tttjb_s13f2,  1,  2, [ dunlending_chieftain ])
    _declare_role_figure(tttjb_s13f2, 10,  3, [ uruk_hai_w_pike ])
    _declare_role_figure(tttjb_s13f2, 10,  4, [ uruk_hai_w_shield ])
    _declare_role_figure(tttjb_s13f2,  3,  5, [ uruk_hai_berserker ])
    _declare_role_figure(tttjb_s13f2,  2,  6, [ uruk_hai_w_banner ])
    _declare_role_figure(tttjb_s13f2,  6,  7, [ dunlending_w_2h ])
    _declare_role_figure(tttjb_s13f2,  6,  8, [ dunlending_w_shield ])
    _declare_role_figure(tttjb_s13f2,  6,  9, [ dunlending_w_bow ])
    _declare_role_figure(tttjb_s13f2,  3, 10, [ uruk_hai_demo_charge ])
    _declare_role_figure(tttjb_s13f2,  6, 11, [ uruk_hai_demo_crew ])
    _declare_role_figure(tttjb_s13f2,  3, 12, [ uruk_hai_demo_berserker ])
    _declare_role_figure(tttjb_s13f2,  1, 13, [ uruk_hai_ballista ])
    _declare_role_figure(tttjb_s13f2,  3, 14, [ uruk_hai_ballista_crew ])

    #========================================================================
    tttjb_s14 = Repo.insert! %Scenario{
      name: "Into the Breach",
      blurb: "The Isengarders try to exploit the breach in the Deeping Wall.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 67,
      map_width: 24, map_height: 24, location: :helms_deep
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s14.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 14, page: 74}

    tttjb_s14f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s14.id, faction: :rohan, suggested_points: 600, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s14f1, 1, 1, "Aragorn with Andúril and armour", [ aragorn ])
    _declare_role_figure(tttjb_s14f1, 1, 2, [ eomer ])
    _declare_role_figure(tttjb_s14f1, 1, 3, [ rohan_captain ])
    _declare_role_figure(tttjb_s14f1, 1, 4, "Gimli with Elven cloak", gimli_all_foot)
    _declare_role_figure(tttjb_s14f1, 8, 5, [ rohan_w_spear_shield ])
    _declare_role_figure(tttjb_s14f1, 8, 6, [ rohan_w_bow ])
    _declare_role_figure(tttjb_s14f1, 8, 7, [ rohan_w_shield ])
    _declare_role_figure(tttjb_s14f1, 1, 8, [ rohan_w_banner ])

    tttjb_s14f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s14.id, faction: :isengard, suggested_points: 600, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s14f2,  2, 1, [ uruk_hai_captain_shield ])
    _declare_role_figure(tttjb_s14f2,  1, 2, [ dunlending_chieftain ])
    _declare_role_figure(tttjb_s14f2,  3, 3, [ dunlending_w_bow ])
    _declare_role_figure(tttjb_s14f2,  3, 4, [ dunlending_w_shield ])
    _declare_role_figure(tttjb_s14f2, 10, 5, [ uruk_hai_w_pike ])
    _declare_role_figure(tttjb_s14f2, 10, 6, [ uruk_hai_w_shield ])
    _declare_role_figure(tttjb_s14f2,  6, 7, [ uruk_hai_berserker ])
    _declare_role_figure(tttjb_s14f2,  2, 8, [ uruk_hai_w_banner ])
    _declare_role_figure(tttjb_s14f2,  1, 9, [ isengard_troll ])

    #========================================================================
    tttjb_s15 = Repo.insert! %Scenario{
      name: "In the Shadow of the Hornburg",
      blurb: "Aragorn and Gimli must clear the gate of Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 26,
      map_width: 18, map_height: 12, location: :helms_deep
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s15.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 15, page: 80}

    tttjb_s15f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s15.id, faction: :rohan, suggested_points: 300, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s15f1, 1, 1, "Aragorn with Andúril and armour", [ aragorn ])
    _declare_role_figure(tttjb_s15f1, 1, 2, "Gimli with Elven cloak", [ gimli ])

    tttjb_s15f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s15.id, faction: :isengard, suggested_points: 400, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s15f2,  1, 1, [ uruk_hai_captain_shield ])
    _declare_role_figure(tttjb_s15f2,  1, 2, [ dunlending_chieftain ])
    _declare_role_figure(tttjb_s15f2,  3, 3, [ dunlending_w_2h ])
    _declare_role_figure(tttjb_s15f2,  3, 4, [ dunlending_w_shield ])
    _declare_role_figure(tttjb_s15f2,  1, 5, [ dunlending_w_banner ])
    _declare_role_figure(tttjb_s15f2, 10, 6, [ uruk_hai_w_shield ])
    _declare_role_figure(tttjb_s15f2,  5, 7, [ uruk_hai_berserker ])

    #========================================================================
    tttjb_s16 = Repo.insert! %Scenario{
      name: "Théoden Rides Out",
      blurb: "Théoden leads a ride out to clear the forces in front of the gatehouse of Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 83,
      map_width: 48, map_height: 24, location: :helms_deep
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s16.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 16, page: 82}

    tttjb_s16f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s16.id, faction: :rohan, suggested_points: 1000, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s16f1,  1,  1, "Aragorn with Andúril, armour and horse", [ aragorn_horse ])
    _declare_role_figure(tttjb_s16f1,  1,  2, [ theoden_armor_horse ])
    _declare_role_figure(tttjb_s16f1,  1,  3, "Legolas with Elven cloak", [ legolas_horse ])
    _declare_role_figure(tttjb_s16f1,  1,  4, [ gamling_horse ])
    _declare_role_figure(tttjb_s16f1,  1,  5, [ eomer_horse ])
    _declare_role_figure(tttjb_s16f1,  1,  6, [ erkenbrand_horse ])
    _declare_role_figure(tttjb_s16f1,  1,  7, "Gandalf the White on Shadowfax", [ gandalf_white_horse, gandalf_white_horse_mt ])
    _declare_role_figure(tttjb_s16f1,  3,  8, [ rohan_gd_horse_spear ])
    _declare_role_figure(tttjb_s16f1,  6,  9, [ rohan_rider_spear ])
    _declare_role_figure(tttjb_s16f1, 12, 10, [ rohan_rider ])

    tttjb_s16f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s16.id, faction: :isengard, suggested_points: 1100, actual_points: 0, sort_order: 2}
    _declare_role_figure(tttjb_s16f2,  3,  1, [ uruk_hai_captain_shield ])
    _declare_role_figure(tttjb_s16f2,  1,  2, [ uruk_hai_shaman ])
    _declare_role_figure(tttjb_s16f2,  1,  3, [ dunlending_chieftain ])
    _declare_role_figure(tttjb_s16f2,  3,  4, [ dunlending_w_2h ])
    _declare_role_figure(tttjb_s16f2,  3,  5, [ dunlending_w_shield ])
    _declare_role_figure(tttjb_s16f2,  3,  6, [ dunlending_w_bow ])
    _declare_role_figure(tttjb_s16f2, 10,  7, [ uruk_hai_w_shield ])
    _declare_role_figure(tttjb_s16f2,  2,  8, [ uruk_hai_w_banner ])
    _declare_role_figure(tttjb_s16f2,  9,  9, [ uruk_hai_w_crossbow ])
    _declare_role_figure(tttjb_s16f2, 10, 10, [ uruk_hai_w_pike ])
    _declare_role_figure(tttjb_s16f2,  9, 11, [ uruk_hai_berserker ])
    _declare_role_figure(tttjb_s16f2,  1, 12, [ isengard_troll ])

    #########################################################################
    # SBG MAGAZINE
    #########################################################################

    #========================================================================
    sbg_s1 = Repo.insert! %Scenario{
      name: "Out of the Frying Pan",
      blurb: "Thorin's Company tries to escape Azog's Hunters on the eastern side of the Misty Mountains.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 35,
      map_width: 48, map_height: 48, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: sbg_s1.id, resource_type: :source, book: :sbg, issue: 1, title: "SBG Magazine", page: 22, sort_order: 1}
    _declare_magazine_replay(sbg_s1.id, :sbg, 1, "SBG Magazine", 24, 1)
    _declare_video_replay(sbg_s1.id, "https://www.youtube.com/watch?v=xUnpfZlauf4", "Mid-Sussex Wargamers", 1)

    sbg_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: sbg_s1.id, faction: :thorins_co, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(sbg_s1f1, 1,  1, "Thorin Oakenshield with Orcrist and Oakenshield", [ thorin ])
    _declare_role_figure(sbg_s1f1, 1,  2, [ dwalin ])
    _declare_role_figure(sbg_s1f1, 1,  3, [ balin ])
    _declare_role_figure(sbg_s1f1, 1,  4, [ ori ])
    _declare_role_figure(sbg_s1f1, 1,  5, [ dori ])
    _declare_role_figure(sbg_s1f1, 1,  6, [ nori ])
    _declare_role_figure(sbg_s1f1, 1,  7, [ oin ])
    _declare_role_figure(sbg_s1f1, 1,  8, [ gloin ])
    _declare_role_figure(sbg_s1f1, 1,  9, [ bifur ])
    _declare_role_figure(sbg_s1f1, 1, 10, [ bofur ])
    _declare_role_figure(sbg_s1f1, 1, 11, [ bombur ])
    _declare_role_figure(sbg_s1f1, 1, 12, "Bilbo Baggins with Sting and the One Ring", [ young_bilbo ])
    _declare_role_figure(sbg_s1f1, 1, 13, "Gandalf the Grey", gandalf_grey_foot_all)

    sbg_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: sbg_s1.id, faction: :azogs_hunters, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(sbg_s1f2,  1, 1, [ azog_warg ])
    _declare_role_figure(sbg_s1f2,  1, 2, [ fimbul_warg ])
    _declare_role_figure(sbg_s1f2, 12, 3, [ hunter_orc_warg ])
    _declare_role_figure(sbg_s1f2,  6, 4, [ fell_warg ])

    #========================================================================
    sbg_s2 = Repo.insert! %Scenario{
      name: "The Battle of Azanulbizar",
      blurb: "Azog and Thror face each other down.",
      date_age: 3, date_year: 2799, date_month: 0, date_day: 0, size: 57,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: sbg_s2.id, resource_type: :source, book: :sbg, issue: 2, title: "SBG Magazine", page: 14, sort_order: 1}
    _declare_magazine_replay(sbg_s2.id, :sbg, 2, "SBG Magazine", 22, 1)
    _declare_video_replay(sbg_s2.id, "https://www.youtube.com/watch?v=AJEwPsxwFG4&list=PLzZ6-_-l-0I52yFFoGzMSuyhscqAy6RmV&index=35", "Spillforeningen the Fellowship", 2)

    sbg_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: sbg_s2.id, faction: :army_thror, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(sbg_s2f1,  1,  1, [ thror ])
    _declare_role_figure(sbg_s2f1,  1,  2, [ thrain ])
    _declare_role_figure(sbg_s2f1,  1,  3, "Thorin Oakenshield with Oakenshield", [ thorin ])
    _declare_role_figure(sbg_s2f1,  1,  4, [ dwalin ])
    _declare_role_figure(sbg_s2f1,  1,  5, [ balin_young ])
    _declare_role_figure(sbg_s2f1, 12,  6, [ erebor_w_spear ])
    _declare_role_figure(sbg_s2f1,  6,  7, [ erebor_w_shield ])
    _declare_role_figure(sbg_s2f1,  6,  8, [ grim_hammer_w ])

    sbg_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: sbg_s2.id, faction: :azogs_hunters, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(sbg_s2f2,  1, 1, [ azog ])
    _declare_role_figure(sbg_s2f2,  1, 2, [ bolg ])
    _declare_role_figure(sbg_s2f2,  1, 3, "Gundabad Orc General", [ dungeon_keeper ])
    _declare_role_figure(sbg_s2f2,  1, 4, "Gundabad Orc Captain with shield", [ gundabad_orc_captain ])
    _declare_role_figure(sbg_s2f2, 12, 5, [ gundabad_orc_shield ])
    _declare_role_figure(sbg_s2f2, 12, 6, [ gundabad_orc_spear ])

    #========================================================================
    sbg_s3 = Repo.insert! %Scenario{
      name: "The Siege of Dol Guldur",
      blurb: "A what-if positing a showdown between the forces of Necromancer and the White Council.",
      date_age: 3, date_year: 2941, date_month: 0, date_day: 0, size: 91,
      map_width: 48, map_height: 48, location: :dol_guldur
    }

    Repo.insert! %ScenarioResource{scenario_id: sbg_s3.id, resource_type: :source, book: :sbg, issue: 3, title: "SBG Magazine", page: 10, sort_order: 1}
    _declare_magazine_replay(sbg_s3.id, :sbg, 3, "SBG Magazine", 22, 1)

    sbg_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: sbg_s3.id, faction: :white_council, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(sbg_s3f1,  1,  1, "Gandalf the Grey", gandalf_grey_foot_all)
    _declare_role_figure(sbg_s3f1,  1,  2, [ thrain_broken ])
    _declare_role_figure(sbg_s3f1,  1,  3, "Galadriel, Lady of Light", [ galadriel ])
    _declare_role_figure(sbg_s3f1,  1,  4, "Radagast the Brown with Sebastian", [ radagast_goblintown, radagast_lotr, radagast_sebastian ])
    _declare_role_figure(sbg_s3f1,  1,  5, "Saruman the Wise", saruman_foot_all)
    _declare_role_figure(sbg_s3f1,  1,  6, "Elrond, Lord of the West", [ elrond ])
    _declare_role_figure(sbg_s3f1,  1,  7, "Thranduil, King of the Woodland Realm", [ thranduil ])
    _declare_role_figure(sbg_s3f1,  1,  8, [ mirkwood_captain ])
    _declare_role_figure(sbg_s3f1, 24,  9, "Mirkwood Elves", [ mirkwood_elf_bow, mirkwood_elf_glaive, mirkwood_elf_shield ])
    _declare_role_figure(sbg_s3f1, 10, 10, [ mirkwood_palace_gd ])

    sbg_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: sbg_s3.id, faction: :azogs_hunters, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(sbg_s3f2,  1,  1, [ necromancer ])
    _declare_role_figure(sbg_s3f2,  1,  2, [ witch_king ])
    _declare_role_figure(sbg_s3f2,  1,  3, [ khamul ])
    _declare_role_figure(sbg_s3f2,  7,  4, [ ringwraith ])
    _declare_role_figure(sbg_s3f2,  1,  5, "Golb, Gundabad Orc General", [ dungeon_keeper ])
    _declare_role_figure(sbg_s3f2, 18,  6, [ hunter_orc ])
    _declare_role_figure(sbg_s3f2,  6,  7, [ hunter_orc_warg ])
    _declare_role_figure(sbg_s3f2,  8,  8, [ giant_spider ])
    _declare_role_figure(sbg_s3f2,  4,  9, [ mirkwood_spider ])
    _declare_role_figure(sbg_s3f2,  2, 10, [ bat_swarm ])

    #========================================================================
    sbg_s4 = Repo.insert! %Scenario{
      name: "The Hunt for Thrain",
      blurb: "Gandalf investigates Dol Guldur and tries to save a crazy dwarf.",
      date_age: 3, date_year: 2850, date_month: 0, date_day: 0, size: 7,
      map_width: 24, map_height: 24, location: :dol_guldur
    }

    Repo.insert! %ScenarioResource{scenario_id: sbg_s4.id, resource_type: :source, book: :sbg, issue: 4, title: "SBG Magazine", page: 3, sort_order: 1}
    _declare_magazine_replay(sbg_s4.id, :sbg, 4, "SBG Magazine", 5, 1)
    _declare_video_replay(sbg_s4.id, "https://www.youtube.com/watch?v=FOjsEFxZZQg", "GBHL", 1)
    _declare_video_replay(sbg_s4.id, "https://www.youtube.com/watch?v=fSjgVps9TT8", "GBHL", 2)

    sbg_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: sbg_s4.id, faction: :white_council, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(sbg_s4f1,  1,  1, "Gandalf the Grey", gandalf_grey_foot_all)

    sbg_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: sbg_s4.id, faction: :azogs_hunters, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(sbg_s4f2,  1,  1, [ thrain_broken ])
    _declare_role_figure(sbg_s4f2,  5,  2, [ hunter_orc ])

    #########################################################################
    # MORDOR
    #########################################################################

    #========================================================================
    mordor_s1 = Repo.insert! %Scenario{
      name: "The Slopes of Mount Doom",
      blurb: "The Last Alliance of Elves and Men confronts Sauron.",
      date_age: 2, date_year: 3441, date_month: 0, date_day: 0, size: 131,
      map_width: 48, map_height: 48, location: :mordor
    }

    Repo.insert! %ScenarioResource{scenario_id: mordor_s1.id, resource_type: :source, book: :mordor, title: "Mordor", sort_order: 1, page: 60}

    mordor_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s1.id, faction: :rivendell, suggested_points: 800, actual_points: 0, sort_order: 1}
    _declare_role_figure(mordor_s1f1, 1,  1, [ elendil ])
    _declare_role_figure(mordor_s1f1, 1,  2, [ isildur ])
    _declare_role_figure(mordor_s1f1, 1,  3, [ gil_galad ])
    _declare_role_figure(mordor_s1f1, 9,  4, [ high_elf_w_spear_shield ])
    _declare_role_figure(mordor_s1f1, 8,  5, [ high_elf_w_blade ])
    _declare_role_figure(mordor_s1f1, 8,  6, [ high_elf_w_bow ])
    _declare_role_figure(mordor_s1f1, 1,  7, [ high_elf_w_banner ])
    _declare_role_figure(mordor_s1f1, 9,  8, [ numenor_w_shield_spear ])
    _declare_role_figure(mordor_s1f1, 8,  9, [ numenor_w_shield ])
    _declare_role_figure(mordor_s1f1, 9, 10, [ numenor_w_bow ])
    _declare_role_figure(mordor_s1f1, 1, 11, [ numenor_w_banner ])

    mordor_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s1.id, faction: :barad_dur, suggested_points: 1075, actual_points: 0, sort_order: 2}
    _declare_role_figure(mordor_s1f2,  1,  1, [ sauron ])
    _declare_role_figure(mordor_s1f2,  2,  2, [ orc_shaman ])
    _declare_role_figure(mordor_s1f2, 16,  3, [ orc_w_spear ])
    _declare_role_figure(mordor_s1f2, 16,  4, [ orc_w_shield ])
    _declare_role_figure(mordor_s1f2,  8,  5, [ orc_w_bow ])
    _declare_role_figure(mordor_s1f2,  8,  6, [ orc_w_2h ])
    _declare_role_figure(mordor_s1f2,  9,  7, [ orc_tracker ])
    _declare_role_figure(mordor_s1f2,  4,  8, [ warg_rider_bow ])
    _declare_role_figure(mordor_s1f2,  4,  9, [ warg_rider_shield ])
    _declare_role_figure(mordor_s1f2,  4, 10, [ warg_rider_spear ])

    #========================================================================
    mordor_s2 = Repo.insert! %Scenario{
      name: "The Sacking of Osgiliath",
      blurb: "Gothmog tries to drive the forces of Gondor out of Osgiliath.",
      date_age: 3, date_year: 3018, date_month: 6, date_day: 20, size: 88,
      map_width: 48, map_height: 48, location: :osgiliath
    }

    Repo.insert! %ScenarioResource{scenario_id: mordor_s2.id, resource_type: :source, book: :mordor, title: "Mordor", sort_order: 2, page: 62}

    mordor_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s2.id, faction: :minas_tirith, suggested_points: 750, actual_points: 0, sort_order: 1}
    _declare_role_figure(mordor_s2f1, 1,  1, "Faramir, Captain of Gondor", [ faramir ])
    _declare_role_figure(mordor_s2f1, 1,  2, [ damrod ])
    _declare_role_figure(mordor_s2f1, 1,  3, [ madril ])
    _declare_role_figure(mordor_s2f1, 1,  4, [ gondor_captain_mt ])
    _declare_role_figure(mordor_s2f1, 3,  5, [ osgiliath_v_spear ])
    _declare_role_figure(mordor_s2f1, 3,  6, [ osgiliath_v_bow ])
    _declare_role_figure(mordor_s2f1, 3,  7, [ osgiliath_v_shield ])
    _declare_role_figure(mordor_s2f1, 8,  8, [ gondor_rog ])
    _declare_role_figure(mordor_s2f1, 4,  9, [ gondor_rog_spear ])
    _declare_role_figure(mordor_s2f1, 8, 10, [ gondor_womt_bow ])
    _declare_role_figure(mordor_s2f1, 8, 11, [ gondor_womt_shield ])
    _declare_role_figure(mordor_s2f1, 8, 12, [ gondor_womt_spear_shield ])
    _declare_role_figure(mordor_s2f1, 1, 13, [ gondor_womt_banner ])

    mordor_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s2.id, faction: :cirith_ungol, suggested_points: 900, actual_points: 0, sort_order: 2}
    _declare_role_figure(mordor_s2f2,  1,  1, [ gothmog ])
    _declare_role_figure(mordor_s2f2,  1,  2, [ m_orc_captain ])
    _declare_role_figure(mordor_s2f2,  1,  3, [ m_orc_captain_2h ])
    _declare_role_figure(mordor_s2f2,  1,  4, [ ringwraith_fellbeast ])
    _declare_role_figure(mordor_s2f2, 12,  5, [ orc_m_shield ])
    _declare_role_figure(mordor_s2f2, 12,  6, [ orc_m_shield_spear ])
    _declare_role_figure(mordor_s2f2,  1,  7, "Mordor Troll with War Drum", [ mordor_troll ])
    _declare_role_figure(mordor_s2f2,  9,  8, [ morgul_stalker ])

    #========================================================================
    mordor_s3 = Repo.insert! %Scenario{
      name: "The Pass of Cirith Ungol",
      blurb: "Elladan and Elrohir pass through Cirith Ungol to bring news of Sauron back the White Council.",
      date_age: 3, date_year: 2951, date_month: 0, date_day: 0, size: 95,
      map_width: 48, map_height: 48, location: :minas_morgul
    }

    Repo.insert! %ScenarioResource{scenario_id: mordor_s3.id, resource_type: :source, book: :mordor, title: "Mordor", sort_order: 3, page: 64}

    mordor_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s3.id, faction: :rivendell, suggested_points: 500, actual_points: 0, sort_order: 1}
    _declare_role_figure(mordor_s3f1,  1,  1, "Elladan with heavy armour", [ elladan ])
    _declare_role_figure(mordor_s3f1,  1,  2, "Elrohir with heavy armour", [ elrohir ])
    _declare_role_figure(mordor_s3f1,  1,  3, [ erestor ])
    _declare_role_figure(mordor_s3f1,  1,  4, "Elven Captain with heavy armour and Elven blade", [ high_elf_captain ])
    _declare_role_figure(mordor_s3f1, 12,  5, [ high_elf_w_blade ])
    _declare_role_figure(mordor_s3f1, 12,  6, [ high_elf_w_bow ])
    _declare_role_figure(mordor_s3f1,  9,  7, [ high_elf_w_spear_shield ])
    _declare_role_figure(mordor_s3f1,  1,  8, [ high_elf_w_banner ])

    mordor_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s3.id, faction: :cirith_ungol, suggested_points: 650, actual_points: 0, sort_order: 2}
    _declare_role_figure(mordor_s3f2,  1,  1, "Shagrat, War Leader of Cirith Ungol", [ shagrat ])
    _declare_role_figure(mordor_s3f2,  1,  2, [ gorbag ])
    _declare_role_figure(mordor_s3f2,  1,  3, [ orc_drummer ])
    _declare_role_figure(mordor_s3f2,  1,  4, [ shelob ])
    _declare_role_figure(mordor_s3f2,  8,  5, [ orc_w_shield ])
    _declare_role_figure(mordor_s3f2,  8,  6, [ orc_w_spear ])
    _declare_role_figure(mordor_s3f2,  4,  7, [ orc_w_bow ])
    _declare_role_figure(mordor_s3f2,  4,  8, [ orc_w_2h ])
    _declare_role_figure(mordor_s3f2,  1,  9, [ orc_w_banner ])
    _declare_role_figure(mordor_s3f2,  6, 10, [ m_uruk_hai_shield ])
    _declare_role_figure(mordor_s3f2,  6, 11, [ m_uruk_hai_2h ])
    _declare_role_figure(mordor_s3f2,  1, 12, [ mordor_troll ])
    _declare_role_figure(mordor_s3f2,  6, 13, [ orc_tracker ])
    _declare_role_figure(mordor_s3f2,  2, 14, [ warg_rider_shield ])
    _declare_role_figure(mordor_s3f2,  2, 15, [ warg_rider_bow ])
    _declare_role_figure(mordor_s3f2,  2, 16, [ warg_rider_shield_spear ])

    #========================================================================
    mordor_s4 = Repo.insert! %Scenario{
      name: "Vengeance of the Nazgul",
      blurb: "Most of the ringwraiths ambush Dáin Ironfoot and his escort.",
      date_age: 3, date_year: 3017, date_month: 0, date_day: 0, size: 61,
      map_width: 48, map_height: 48, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: mordor_s4.id, resource_type: :source, book: :mordor, title: "Mordor", sort_order: 4, page: 66}
    _declare_podcast(mordor_s4.id, "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-16-vengeance-of-the-nazgul", "The Green Dragon", 1)
    _declare_video_replay(mordor_s4.id, "https://www.youtube.com/watch?v=sbwVzrvWTa8&list=PLa_Dq2-Vx86KjLv5JCpygwNALLzzh5zG9&index=14", "Mid-Sussex Wargamers", 2)

    mordor_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s4.id, faction: :durins_folk, suggested_points: 700, actual_points: 0, sort_order: 1}
    _declare_role_figure(mordor_s4f1,  1,  1, [ dain ])
    _declare_role_figure(mordor_s4f1,  1,  2, [ dwarf_captain_shield ])
    _declare_role_figure(mordor_s4f1,  4,  3, [ dwarf_w_shield ])
    _declare_role_figure(mordor_s4f1,  4,  4, [ dwarf_w_bow ])
    _declare_role_figure(mordor_s4f1,  4,  5, [ dwarf_w_2h ])
    _declare_role_figure(mordor_s4f1,  1,  6, [ dwarf_w_banner ])
    _declare_role_figure(mordor_s4f1,  4,  7, [ dwarf_r_2h ])
    _declare_role_figure(mordor_s4f1,  4,  8, [ dwarf_r_axe ])
    _declare_role_figure(mordor_s4f1,  4,  9, [ dwarf_r_bow ])
    _declare_role_figure(mordor_s4f1, 12, 10, [ dwarf_khazad_gd ])
    _declare_role_figure(mordor_s4f1,  6, 11, [ dwarf_iron_gd ])

    mordor_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s4.id, faction: :nazgul, suggested_points: 780, actual_points: 0, sort_order: 2}
    _declare_role_figure(mordor_s4f2,  1,  1, "Witch-king of Angmar with Crown of Morgul", [ witch_king ])
    _declare_role_figure(mordor_s4f2,  1,  1, [ khamul ])
    _declare_role_figure(mordor_s4f2,  1,  1, [ dark_marshal ])
    _declare_role_figure(mordor_s4f2,  1,  1, [ shadow_lord ])
    _declare_role_figure(mordor_s4f2,  1,  1, [ tainted ])
    _declare_role_figure(mordor_s4f2,  1,  1, [ undying ])

    #========================================================================
    mordor_s5 = Repo.insert! %Scenario{
      name: "The Siege of the Black Gate",
      blurb: "What if Boromir led the forces of Gondor against Sauron's realm?",
      date_age: 3, date_year: 3018, date_month: 4, date_day: 2, size: 93,
      map_width: 48, map_height: 48, location: :morannon
    }

    Repo.insert! %ScenarioResource{scenario_id: mordor_s5.id, resource_type: :source, book: :mordor, title: "Mordor", sort_order: 4, page: 68}

    mordor_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s5.id, faction: :minas_tirith, suggested_points: 475, actual_points: 0, sort_order: 1}
    _declare_role_figure(mordor_s5f1,  1, 1, [ boromir_wt_banner ])
    _declare_role_figure(mordor_s5f1,  1, 2, [ faramir_armor_horse ])
    _declare_role_figure(mordor_s5f1,  2, 3, [ gondor_captain_mt ])
    _declare_role_figure(mordor_s5f1, 16, 4, [ gondor_womt_shield ])
    _declare_role_figure(mordor_s5f1, 16, 5, [ gondor_womt_spear_shield ])
    _declare_role_figure(mordor_s5f1, 16, 6, [ gondor_womt_bow ])
    _declare_role_figure(mordor_s5f1,  2, 7, [ gondor_womt_banner ])

    mordor_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s5.id, faction: :black_gate, suggested_points: 815, actual_points: 0, sort_order: 2}
    _declare_role_figure(mordor_s5f2,  1, 1, [ mouth_horse ])
    _declare_role_figure(mordor_s5f2,  1, 2, [ troll_chieftain ])
    _declare_role_figure(mordor_s5f2,  1, 3, [ m_orc_captain ])
    _declare_role_figure(mordor_s5f2, 12, 4, [ orc_m_shield ])
    _declare_role_figure(mordor_s5f2, 12, 5, [ orc_m_shield_spear ])
    _declare_role_figure(mordor_s5f2,  1, 6, [ war_catapult ])
    _declare_role_figure(mordor_s5f2,  1, 7, [ mordor_troll ])
    _declare_role_figure(mordor_s5f2,  1, 8, "Mordor Troll with War Drum", [ mordor_troll ])
  end
end

SbgInv.Data.generate
