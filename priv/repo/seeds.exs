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

    buhrdur  = Repo.insert! %Figure{name: "Bûhrdur"}
    gulavhar = Repo.insert! %Figure{name: "Gûlavhar"}

    warg_chieftain = Repo.insert! %Figure{name: "Wild Warg Chieftain"}

    barrow_wight = Repo.insert! %Figure{name: "Barrow Wight", plural_name: "Barrow Wights"}
    shade        = Repo.insert! %Figure{name: "Shade",        plural_name: "Shades"}
    spectre      = Repo.insert! %Figure{name: "Spectre",      plural_name: "Spectres"}
    warg         = Repo.insert! %Figure{name: "Wild Warg",    plural_name: "Wild Wargs"}

    #########################################################################
    # FIGURES: ARNOR
    #########################################################################

    arathorn = Repo.insert! %Figure{name: "Arathorn"}
    arvedui  = Repo.insert! %Figure{name: "Arvedui, Last King of Arnor"}
    halbarad = Repo.insert! %Figure{name: "Halbarad"}
    malbeth  = Repo.insert! %Figure{name: "Malbeth the Seer"}

    arnor_captain = Repo.insert! %Figure{name: "Captain of Arnor", plural_name: "Captains of Arnor"}

    arnor_w            = Repo.insert! %Figure{name: "Warrior of Arnor",               plural_name: "Warriors of Arnor"}
    dunedain           = Repo.insert! %Figure{name: "Dúnedan",                        plural_name: "Dúnedain"}
    ranger_north       = Repo.insert! %Figure{name: "Ranger of the North",            plural_name: "Rangers of the North"}
    ranger_north_spear = Repo.insert! %Figure{name: "Ranger of the North with spear", plural_name: "Rangers of the North with spear"}

    #########################################################################
    # FIGURES: DWARVES
    #########################################################################

    balin  = Repo.insert! %Figure{name: "Balin"}
    dain   = Repo.insert! %Figure{name: "Dáin Ironfoot"}
    drar   = Repo.insert! %Figure{name: "Drar"}
    durin  = Repo.insert! %Figure{name: "Durin"}
    mardin = Repo.insert! %Figure{name: "Mardin"}
    murin  = Repo.insert! %Figure{name: "Murin"}

    dwarf_king    = Repo.insert! %Figure{name: "Dwarf King",                        plural_name: "Dwarf Kings"}
    dwarf_king_2h = Repo.insert! %Figure{name: "Dwarf King with two-handed weapon", plural_name: "Dwarf Kings with two-handed weapon"}
    dwarf_captain = Repo.insert! %Figure{name: "Dwarf Captain",                     plural_name: "Dwarf Captains"}

    dwarf_iron_gd   = Repo.insert! %Figure{name: "Iron Guard",                          plural_name: "Iron Guards"}
    dwarf_khazad_gd = Repo.insert! %Figure{name: "Khazad Guard",                        plural_name: "Khazad Guards"}
    dwarf_r_bow     = Repo.insert! %Figure{name: "Dwarf Ranger with Dwarf longbow",     plural_name: "Dwarf Rangers with Dwarf longbow"}
    dwarf_r_axe     = Repo.insert! %Figure{name: "Dwarf Ranger with throwing axe",      plural_name: "Dwarf Rangers with throwing axe"}
    dwarf_r_2h      = Repo.insert! %Figure{name: "Dwarf Ranger with two-handed weapon", plural_name: "Dwarf Rangers with two-handed weapons"}
    dwarf_w_bow     = Repo.insert! %Figure{name: "Dwarf with Dwarf bow",                plural_name: "Dwarves with Dwarf bow"}
    dwarf_w_shield  = Repo.insert! %Figure{name: "Dwarf with shield",                   plural_name: "Dwarves with shield"}
    dwarf_w_2h      = Repo.insert! %Figure{name: "Dwarf with two-handed axe",           plural_name: "Dwarves with two-handed axe"}
    dwarf_w_banner  = Repo.insert! %Figure{name: "Dwarf with banner",                   plural_name: "Dwarves with banner"}
    vault_team      = Repo.insert! %Figure{name: "Vault Warden Team",                   plural_name: "Vault Warden Teams"}

    dwarf_ballista = Repo.insert! %Figure{name: "Dwarf Ballista", plural_name: "Dwarf Ballistas"}

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
    frodo         = Repo.insert! %Figure{name: "Frodo"}
    frodo_pony    = Repo.insert! %Figure{name: "Frodo on pony"}
    gimli         = Repo.insert! %Figure{name: "Gimli"}
    legolas       = Repo.insert! %Figure{name: "Legolas"}
    legolas_horse = Repo.insert! %Figure{name: "Legolas on horse"}
    merry         = Repo.insert! %Figure{name: "Merry"}
    merry_pony    = Repo.insert! %Figure{name: "Merry on pony"}
    pippin        = Repo.insert! %Figure{name: "Pippin"}
    pippin_pony   = Repo.insert! %Figure{name: "Pippin on pony"}
    sam           = Repo.insert! %Figure{name: "Sam"}
    sam_pony      = Repo.insert! %Figure{name: "Sam on pony"}

    #########################################################################
    # FIGURES: FREE PEOPLES
    #########################################################################

    cirdan              = Repo.insert! %Figure{name: "Círdan"}
    gandalf_grey        = Repo.insert! %Figure{name: "Gandalf the Grey"}
    gandalf_white       = Repo.insert! %Figure{name: "Gandalf the White"}
    gandalf_white_horse = Repo.insert! %Figure{name: "Gandalf the White on horse"}
    ghan_buri_ghan      = Repo.insert! %Figure{name: "Ghân-buri-ghân"}
    goldberry           = Repo.insert! %Figure{name: "Goldberry"}
    gwaihir             = Repo.insert! %Figure{name: "Gwaihir"}
    radagast            = Repo.insert! %Figure{name: "Radagast"}
    saruman             = Repo.insert! %Figure{name: "Saruman the White"}
    tom_bombadil        = Repo.insert! %Figure{name: "Tom Bombadil"}
    treebeard           = Repo.insert! %Figure{name: "Treebeard"}

    wose = Repo.insert! %Figure{name: "Wose", plural_name: "Woses"}

    eagle = Repo.insert! %Figure{name: "Giant Eagle", plural_name: "Giant Eagles"}
    ent   = Repo.insert! %Figure{name: "Ent",         plural_name: "Ents"}

    #########################################################################
    # FIGURES: GONDOR
    #########################################################################

    angbor              = Repo.insert! %Figure{name: "Angbor the Fearless"}
    beregond            = Repo.insert! %Figure{name: "Beregond"}
    boromir             = Repo.insert! %Figure{name: "Boromir"}
    boromir_wt_banner   = Repo.insert! %Figure{name: "Boromir of the White Tower with Banner"}
    boromir_wt_horse    = Repo.insert! %Figure{name: "Boromir of the White Tower on horse"}
    damrod              = Repo.insert! %Figure{name: "Damrod"}
    denethor            = Repo.insert! %Figure{name: "Denethor"}
    cirion              = Repo.insert! %Figure{name: "Cirion"}
    faramir             = Repo.insert! %Figure{name: "Faramir"}
    faramir_armor_horse = Repo.insert! %Figure{name: "Faramir, Captain of Gondor with heavy armour and horse"}
    forlong             = Repo.insert! %Figure{name: "Forlong the Fat"}
    imrahil             = Repo.insert! %Figure{name: "Prince Imrahil of Dol Amroth"}
    imrahil_horse       = Repo.insert! %Figure{name: "Prince Imrahil on horse"}
    king_dead           = Repo.insert! %Figure{name: "King of the Dead"}
    madril              = Repo.insert! %Figure{name: "Madril"}
    pippin_gondor       = Repo.insert! %Figure{name: "Peregrin, Guard of the Citadel"}

    king_of_men             = Repo.insert! %Figure{name: "King of Men",                      plural_name: "Kings of Men"}
    gondor_captain_mt       = Repo.insert! %Figure{name: "Captain of Minas Tirith",          plural_name: "Captains of Minas Tirith"}
    gondor_captain_mt_horse = Repo.insert! %Figure{name: "Captain of Minas Tirith on horse", plural_name: "Captains of Minas Tirith on horse"} # exists?
    gondor_captain_da       = Repo.insert! %Figure{name: "Captain of Dol Amroth",            plural_name: "Captains of Dol Amroth"}

    axemen_lossarnach        = Repo.insert! %Figure{name: "Axeman of Lossarnach",                          plural_name: "Axemen of Lossarnach"}
    clansmen_lamedon         = Repo.insert! %Figure{name: "Clansman of Lamedon",                           plural_name: "Clansmen of Lamedon"}
    fountain_court_gd        = Repo.insert! %Figure{name: "Guard of the Fountain Court",                   plural_name: "Guards of the Fountain Court"}
    dead_rider               = Repo.insert! %Figure{name: "Rider of the Dead",                             plural_name: "Riders of the Dead"}
    dead_w                   = Repo.insert! %Figure{name: "Warrior of the Dead",                           plural_name: "Warriors of the Dead"}
    gondor_citadel_gd_spear  = Repo.insert! %Figure{name: "Citadel Guard with spear",                      plural_name: "Citadel Guards with spear"}
    gondor_citadel_gd_bow    = Repo.insert! %Figure{name: "Citadel Guard with longbow",                    plural_name: "Citadel Guards with longbow"}
    gondor_knight            = Repo.insert! %Figure{name: "Knight of Minas Tirith",                        plural_name: "Knights of Minas Tirith"}
    gondor_knight_banner     = Repo.insert! %Figure{name: "Knight of Minas Tirith with banner",            plural_name: "Knights of Minas Tirith with banner"}
    gondor_knight_shield     = Repo.insert! %Figure{name: "Knight of Minas Tirith with shield",            plural_name: "Knights of Minas Tirith with shield"}
    gondor_knight_da_foot    = Repo.insert! %Figure{name: "Foot Knight of Dol Amroth",                     plural_name: "Foot Knights of Dol Amroth"}
    gondor_knight_da_foot_banner  = Repo.insert! %Figure{name: "Foot Knight of Dol Amroth with banner",         plural_name: "Foot Knights of Dol Amroth with banner"}
    gondor_knight_da_horse   = Repo.insert! %Figure{name: "Knight of Dol Amroth",                          plural_name: "Knights of Dol Amroth"}
    gondor_rog               = Repo.insert! %Figure{name: "Ranger of Gondor",                              plural_name: "Rangers of Gondor"}
    gondor_rog_spear         = Repo.insert! %Figure{name: "Ranger of Gondor with spear",                   plural_name: "Rangers of Gondor with spear"}
    gondor_womt_banner       = Repo.insert! %Figure{name: "Warrior of Minas Tirith with banner",           plural_name: "Warriors of Minas Tirith with banner"}
    gondor_womt_bow          = Repo.insert! %Figure{name: "Warrior of Minas Tirith with bow",              plural_name: "Warriors of Minas Tirith with bow"}
    gondor_womt_shield       = Repo.insert! %Figure{name: "Warrior of Minas Tirith with shield",           plural_name: "Warriors of Minas Tirith with shield"}
    gondor_womt_spear_shield = Repo.insert! %Figure{name: "Warrior of Minas Tirith with spear and shield", plural_name: "Warriors of Minas Tirith with spear and shield"}
    maa_da                   = Repo.insert! %Figure{name: "Man at Arms of Dol Amroth",                     plural_name: "Men at Arms of Dol Amroth"}
    osgiliath_v_bow          = Repo.insert! %Figure{name: "Osgiliath Veteran with bow",                    plural_name: "Osgiliath Veterans with bow"}
    osgiliath_v_shield       = Repo.insert! %Figure{name: "Osgiliath Veteran with shield",                 plural_name: "Osgiliath Veterans with shield"}
    osgiliath_v_spear        = Repo.insert! %Figure{name: "Osgiliath Veteran with spear",                  plural_name: "Osgiliath Veterans with spear"}

    avenger        = Repo.insert! %Figure{name: "Avenger Bolt Thrower",      plural_name: "Avenger Bolt Throwers"}
    avenger_crew   = Repo.insert! %Figure{name: "Avenger Bolt Thrower crew", plural_name: "Avenger Bolt Thrower crew"}
    trebuchet      = Repo.insert! %Figure{name: "Battlecry Trebuchet",       plural_name: "Battlecry Trebuchets"}
    trebuchet_crew = Repo.insert! %Figure{name: "Battlecry Trebuchet crew",  plural_name: "Battlecry Trebuchet crew"}

    #########################################################################
    # FIGURES: HARAD
    #########################################################################

    dalamyr       = Repo.insert! %Figure{name: "Dalamyr, Corsair Fleet Master"}
    suladan       = Repo.insert! %Figure{name: "Suladân"}
    suladan_horse = Repo.insert! %Figure{name: "Suladân the Serpent Lord on horse"}

    corsair_bosun         = Repo.insert! %Figure{name: "Corsair Bo'sun",              plural_name: "Corsair Bo'suns"}
    corsair_captain       = Repo.insert! %Figure{name: "Corsair Captain",             plural_name: "Corsair Captains"}
    harad_chieftain       = Repo.insert! %Figure{name: "Haradrim Chieftain",          plural_name: "Haradrim Chieftains"}
    harad_chieftain_horse = Repo.insert! %Figure{name: "Haradrim Chieftain on horse", plural_name: "Haradrim Chieftains on horse"}
    harad_king_horse      = Repo.insert! %Figure{name: "Haradrim King on horse",      plural_name: "Haradrim Kings on horse"}
    mahud_tribesmaster    = Repo.insert! %Figure{name: "Mahûd Tribesmaster",          plural_name: "Mahûd Tribesmasters"}

    corsair_arbalester = Repo.insert! %Figure{name: "Corsair Arbalester",           plural_name: "Corsair Arbalesters"}
    corsair_reaver     = Repo.insert! %Figure{name: "Corsair Reaver",               plural_name: "Corsair Reavers"}
    corsair_w_bow      = Repo.insert! %Figure{name: "Corsair of Umbar with bow",    plural_name: "Corsair of Umbar with bow"}
    corsair_w_shield   = Repo.insert! %Figure{name: "Corsair of Umbar with shield", plural_name: "Corsair of Umbar with shield"}
    corsair_w_spear    = Repo.insert! %Figure{name: "Corsair of Umbar with spear",  plural_name: "Corsair of Umbar with spear"}
    half_troll         = Repo.insert! %Figure{name: "Half Troll",                   plural_name: "Half Trolls"}
    half_troll_2h      = Repo.insert! %Figure{name: "Half Troll with two-handed weapon", plural_name: "Half Trolls with two-handed-weapon"}
    harad_raider       = Repo.insert! %Figure{name: "Haradrim Raider",              plural_name: "Haradrim Raiders"}
    harad_raider_lance = Repo.insert! %Figure{name: "Haradrim Raider with lance",   plural_name: "Haradrim Raiders with lance"}
    harad_w_banner     = Repo.insert! %Figure{name: "Haradrim Warrior with banner", plural_name: "Haradrim Warriors with banner"}
    harad_w_bow        = Repo.insert! %Figure{name: "Haradrim Warrior with bow",    plural_name: "Haradrim Warriors with bow"}
    harad_w_spear      = Repo.insert! %Figure{name: "Haradrim Warrior with spear",  plural_name: "Haradrim Warriors with spear"}
    hasharin           = Repo.insert! %Figure{name: "Hâsharin",                     plural_name: "Hâsharii"}
    mahud_beastmaster  = Repo.insert! %Figure{name: "Mahûd Beastmaster Chieftain",  plural_name: "Mahûd Beastmaster Chieftain"}
    mahud_w_blowpipe   = Repo.insert! %Figure{name: "Mahûd Warrior with blowpipe",  plural_name: "Mahûd Warriors with blowpipe"}
    mahud_w_spear      = Repo.insert! %Figure{name: "Mahûd Warrior with spear",     plural_name: "Mahûd Warriors with spear"}
    serpent_gd         = Repo.insert! %Figure{name: "Serpent Guard",                plural_name: "Serpent Guards"}
    serpent_rider      = Repo.insert! %Figure{name: "Serpent Rider",                plural_name: "Serpent Riders"}
    watcher_karna      = Repo.insert! %Figure{name: "Watcher of Karna",             plural_name: "Watchers of Karna"}

    mumak       = Repo.insert! %Figure{name: "Mûmak",       plural_name: "Mûmakil"}
    mumak_mahud = Repo.insert! %Figure{name: "Mûmak Mahud", plural_name: "Mûmak Mahuds"}

    #########################################################################
    # FIGURES: ISENGARD
    #########################################################################

    lurtz       = Repo.insert! %Figure{name: "Lurtz"}
    sharkey     = Repo.insert! %Figure{name: "Sharkey"}
    sharku      = Repo.insert! %Figure{name: "Sharku"}
    sharku_warg = Repo.insert! %Figure{name: "Sharku on Warg"}
    ugluk       = Repo.insert! %Figure{name: "Uglúk"}
    vrasku      = Repo.insert! %Figure{name: "Vraskû"}
    worm        = Repo.insert! %Figure{name: "Worm"}

    dunlending_chieftain    = Repo.insert! %Figure{name: "Dunlending Chieftain",                 plural_name: "Dunlending Chieftains"}
    uruk_hai_captain_shield = Repo.insert! %Figure{name: "Uruk-hai Captain with shield",         plural_name: "Uruk-hai Captains with shield"}
    uruk_hai_captain_2h     = Repo.insert! %Figure{name: "Uruk-hai Captain with two-handed axe", plural_name: "Uruk-hai Captains with two-handed axe"}

    dunlending_w            = Repo.insert! %Figure{name: "Dunlending",                           plural_name: "Dunlendings"}
    dunlending_w_banner     = Repo.insert! %Figure{name: "Dunlending with banner",               plural_name: "Dunlendings with banner"}
    dunlending_w_bow        = Repo.insert! %Figure{name: "Dunlending with bow",                  plural_name: "Dunlendings with bow"}
    dunlending_w_shield     = Repo.insert! %Figure{name: "Dunlending with shield",               plural_name: "Dunlendings with shield"}
    dunlending_w_2h         = Repo.insert! %Figure{name: "Dunlending with two-handed weapon",    plural_name: "Dunlendings with two-handed weapon"}
    ruffian                 = Repo.insert! %Figure{name: "Ruffian",                              plural_name: "Ruffians"}
    ruffian_bow             = Repo.insert! %Figure{name: "Ruffian with bow",                     plural_name: "Ruffians with bow"}
    ruffian_whip            = Repo.insert! %Figure{name: "Ruffian with whip",                    plural_name: "Ruffians with whip"}
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

    galadhrim_captain = Repo.insert! %Figure{name: "Galadhrim Captain", plural_name: "Galadhrim Captains"}

    galadhrim_w_blade = Repo.insert! %Figure{name: "Galadhrim Warrior with Elven blade", plural_name: "Galadhrim Warriors with Elven blade"}
    galadhrim_w_bow   = Repo.insert! %Figure{name: "Galadhrim Warrior with Elf bow",     plural_name: "Galadhrim Warriors with Elf bow"}

    #########################################################################
    # FIGURES: MIRKWOOD
    #########################################################################

    thranduil = Repo.insert! %Figure{name: "Thranduil" }

    wood_elf_captain = Repo.insert! %Figure{name: "Wood Elf Captain", plural_name: "Wood Elf Captains"}

    wood_elf_sentinel      = Repo.insert! %Figure{name: "Wood Elf Sentinel",                                     plural_name: "Wood Elf Sentinels"}
    wood_elf_w_armor_bow   = Repo.insert! %Figure{name: "Wood Elf Warrior with armour and Elf bow",              plural_name: "Wood Elf Warriors with armour and Elf bow"}
    wood_elf_w_armor_blade = Repo.insert! %Figure{name: "Wood Elf Warrior with armour and Elven blade",          plural_name: "Wood Elf Warriors with armour and Elven blade"}
    wood_elf_w_armor_spear = Repo.insert! %Figure{name: "Wood Elf Warrior with armour and spear",                plural_name: "Wood Elf Warriors with armour and spear"}
    wood_elf_w_banner      = Repo.insert! %Figure{name: "Wood Elf Warrior with banner",                          plural_name: "Wood Elf Warriors with banner"}
    wood_elf_w_blade       = Repo.insert! %Figure{name: "Wood Elf Warrior with Elven blade and throwing dagger", plural_name: "Wood Elf Warriors with Elven blade and throwing dagger"}
    wood_elf_w_bow         = Repo.insert! %Figure{name: "Wood Elf Warrior with bow",                             plural_name: "Wood Elf Warriors with bow"}
    wood_elf_w_spear       = Repo.insert! %Figure{name: "Wood Elf Warrior with spear",                           plural_name: "Wood Elf Warriors with spear"}

    #########################################################################
    # FIGURES: MORDOR
    #########################################################################

    dark_marshal         = Repo.insert! %Figure{name: "The Dark Marshal"}
    gollum               = Repo.insert! %Figure{name: "Gollum"}
    gorbag               = Repo.insert! %Figure{name: "Gorbag"}
    gothmog              = Repo.insert! %Figure{name: "Gothmog"}
    grishnakh            = Repo.insert! %Figure{name: "Grishnákh"}
    #khamul in Easterlings
    mouth                = Repo.insert! %Figure{name: "Mouth of Sauron"}
    mouth_horse          = Repo.insert! %Figure{name: "Mouth of Sauron on armoured horse"}
    sauron               = Repo.insert! %Figure{name: "Sauron"}
    shadow_lord          = Repo.insert! %Figure{name: "The Shadow Lord"}
    shagrat              = Repo.insert! %Figure{name: "Shagrat"}
    shelob               = Repo.insert! %Figure{name: "Shelob"}
    smeagol              = Repo.insert! %Figure{name: "Sméagol"}
    tainted              = Repo.insert! %Figure{name: "The Tainted"}
    undying              = Repo.insert! %Figure{name: "The Undying"}
    witch_king           = Repo.insert! %Figure{name: "Witch-king of Angmar"}
    witch_king_flail     = Repo.insert! %Figure{name: "Witch-king of Angmar with flail"}
    witch_king_horse     = Repo.insert! %Figure{name: "Witch-king of Angmar on horse"}
    witch_king_fellbeast = Repo.insert! %Figure{name: "Witch-king of Angmar on Fell Beast"}

    m_orc_captain        = Repo.insert! %Figure{name: "Morannon Orc Captain",     plural_name: "Morannon Orc Captains"}
    m_orc_captain_2h     = Repo.insert! %Figure{name: "Morannon Orc Captain with two-handed weapon", plural_name: "Morannon Orc Captains with two-handed weapon"}
    mordor_uruk_captain  = Repo.insert! %Figure{name: "Mordor Uruk-hai Captain",  plural_name: "Mordor Uruk-hai Captains"}
    orc_captain          = Repo.insert! %Figure{name: "Orc Captain",              plural_name: "Orc Captains"}
    orc_captain_warg     = Repo.insert! %Figure{name: "Orc Captain on Warg",      plural_name: "Orc Captains on Warg"}
    orc_drummer          = Repo.insert! %Figure{name: "Orc Drummer",              plural_name: "Orc Drummers"}
    orc_shaman           = Repo.insert! %Figure{name: "Orc Shaman",               plural_name: "Orc Shamans"}
    ringwraith           = Repo.insert! %Figure{name: "Ringwraith",               plural_name: "Ringwraiths"}
    ringwraith_horse     = Repo.insert! %Figure{name: "Ringwraith on horse",      plural_name: "Ringwraiths on horse"}
    ringwraith_fellbeast = Repo.insert! %Figure{name: "Ringwraith on Fell Beast", plural_name: "Ringwraiths on Fell Beasts"}
    troll_chieftain      = Repo.insert! %Figure{name: "Troll Chieftain",          plural_name: "Troll Chieftain"}

    m_uruk_hai              = Repo.insert! %Figure{name: "Mordor Uruk-hai",                    plural_name: "Mordor Uruk-hai"}
    m_uruk_hai_shield       = Repo.insert! %Figure{name: "Mordor Uruk-hai with shield",        plural_name: "Mordor Uruk-hai with shield"}
    m_uruk_hai_2h           = Repo.insert! %Figure{name: "Mordor Uruk-hai with two-handed weapon", plural_name: "Mordor Uruk-hai with two-handed weapon"}
    morgul_stalker          = Repo.insert! %Figure{name: "Morgul Stalker",                     plural_name: "Morgul Stalkers"}
    orc_m_shield            = Repo.insert! %Figure{name: "Morannon Orc with shield",           plural_name: "Morannon Orcs with shield"}
    orc_m_shield_spear      = Repo.insert! %Figure{name: "Morannon Orc with shield and spear", plural_name: "Morannon Orcs with shield and spear"}
    orc_m_spear             = Repo.insert! %Figure{name: "Morannon Orc with spear",            plural_name: "Morannon Orcs with spear"}
    orc_tracker             = Repo.insert! %Figure{name: "Orc Tracker",                        plural_name: "Orc Trackers"}
    orc_w_banner            = Repo.insert! %Figure{name: "Orc with banner",                    plural_name: "Orcs with banner"}
    orc_w_bow               = Repo.insert! %Figure{name: "Orc with Orc bow",                   plural_name: "Orcs with Orc bow"}
    orc_w_shield            = Repo.insert! %Figure{name: "Orc with shield",                    plural_name: "Orcs with shield"}
    orc_w_spear             = Repo.insert! %Figure{name: "Orc with spear",                     plural_name: "Orcs with spear"}
    orc_w_2h                = Repo.insert! %Figure{name: "Orc with two-handed weapon",         plural_name: "Orcs with two-handed weapon"}
    spectre                 = Repo.insert! %Figure{name: "Spectre",                            plural_name: "Spectres"}
    warg_rider_bow          = Repo.insert! %Figure{name: "Warg Rider with bow",                plural_name: "Warg Riders with bow"}
    warg_rider_shield       = Repo.insert! %Figure{name: "Warg Rider with shield",             plural_name: "Warg Riders with shield"}
    warg_rider_shield_spear = Repo.insert! %Figure{name: "Warg Rider with shield and throwing spear", plural_name: "Warg Riders with shield and throwing spear"}
    warg_rider_spear        = Repo.insert! %Figure{name: "Warg Rider with spear",              plural_name: "Warg Riders with spear"}

    mordor_troll            = Repo.insert! %Figure{name: "Mordor Troll",                       plural_name: "Mordor Trolls"}

    mordor_siege_bow     = Repo.insert! %Figure{name: "Mordor Siege Bow",          plural_name: "Mordor Siege Bows"}
    mordor_siege_bow_orc = Repo.insert! %Figure{name: "Mordor Siege Bow Orc crew", plural_name: "Mordor Siege Bow Orc crew" }
    war_catapult         = Repo.insert! %Figure{name: "War Catapult",              plural_name: "War Catapults"}
    war_catapult_orc     = Repo.insert! %Figure{name: "War Catapult Orc crew",     plural_name: "War Catapult Orc crew" }
    war_catapult_troll   = Repo.insert! %Figure{name: "War Catapult Troll",        plural_name: "War Catapult Trolls"}

    #########################################################################
    # FIGURES: MORIA
    #########################################################################

    durburz        = Repo.insert! %Figure{name: "Durbûrz"}
    golfimbul      = Repo.insert! %Figure{name: "Golfimbul"}
    golfimbul_warg = Repo.insert! %Figure{name: "Golfimbul on warg"}

    moria_captain     = Repo.insert! %Figure{name: "Moria Goblin Captain",          plural_name: "Moria Goblin Captains"}
    moria_captain_bow = Repo.insert! %Figure{name: "Moria Goblin Captain with bow", plural_name: "Moria Goblin Captains with bow"}

    moria_g_bow    = Repo.insert! %Figure{name: "Moria Goblin with Orc bow", plural_name: "Moria Goblins with Orc bow"}
    moria_g_shield = Repo.insert! %Figure{name: "Moria Goblin with shield",  plural_name: "Moria Goblins with shield"}
    moria_g_spear  = Repo.insert! %Figure{name: "Moria Goblin with spear",   plural_name: "Moria Goblins with spear"}
    moria_p_bow    = Repo.insert! %Figure{name: "Moria Goblin Prowler with Orc bow",             plural_name: "Moria Goblin Prowlers with Orc bow"}
    moria_p_shield = Repo.insert! %Figure{name: "Moria Goblin Prowler with shield",              plural_name: "Moria Goblin Prowlers with shield"}
    moria_p_2h     = Repo.insert! %Figure{name: "Moria Goblin Prowler with two-handed weapon",   plural_name: "Moria Goblin Prowlers with two-handed weapon"}
    moria_shaman   = Repo.insert! %Figure{name: "Moria Goblin Shaman",       plural_name: "Moria Goblin Shamans"}

    cave_troll_chain = Repo.insert! %Figure{name: "Cave Troll with chain", plural_name: "Cave Trolls with chain"}
    cave_troll_spear = Repo.insert! %Figure{name: "Cave Troll with spear", plural_name: "Cave Trolls with spear"}

    moria_drum    = Repo.insert! %Figure{name: "Moria Goblin drum",    plural_name: "Moria Goblin drums"}
    moria_drummer = Repo.insert! %Figure{name: "Moria Goblin drummer", plural_name: "Moria Goblin drummers"}

    balrog   = Repo.insert! %Figure{name: "Balrog",   plural_name: "Balrogs"}
    dragon   = Repo.insert! %Figure{name: "Dragon",   plural_name: "Dragons"}
    tentacle = Repo.insert! %Figure{name: "Tentacle", plural_name: "Tentacles"}

    #########################################################################
    # FIGURES: NUMENOR
    #########################################################################

    elendil       = Repo.insert! %Figure{name: "Elendil"}
    isildur       = Repo.insert! %Figure{name: "Isildur"}
    isildur_horse = Repo.insert! %Figure{name: "Isildur on horse"}

    numenor_captain = Repo.insert! %Figure{name: "Captain of Numenor", plural_name: "Captains of Numenor"}

    numenor_w_banner       = Repo.insert! %Figure{name: "Warrior of Numenor with banner",           plural_name: "Warriors of Numenor with banner"}
    numenor_w_bow          = Repo.insert! %Figure{name: "Warrior of Numenor with bow",              plural_name: "Warriors of Numenor with bow"}
    numenor_w_shield       = Repo.insert! %Figure{name: "Warrior of Numenor with shield",           plural_name: "Warriors of Numenor with shield"}
    numenor_w_shield_spear = Repo.insert! %Figure{name: "Warrior of Numenor with shield and spear", plural_name: "Warriors of Numenor with shield and spear"}

    #########################################################################
    # FIGURES: RIVENDELL
    #########################################################################

    arwen            = Repo.insert! %Figure{name: "Arwen (FotR)"}
    arwen_horse      = Repo.insert! %Figure{name: "Arwen on Asfaloth"}
    arwen2           = Repo.insert! %Figure{name: "Arwen (LotR)"}
    elladan          = Repo.insert! %Figure{name: "Elladan"}
    elladan_armor    = Repo.insert! %Figure{name: "Elladan with heavy armour"}
    elrohir          = Repo.insert! %Figure{name: "Elrohir"}
    elrohir_armor    = Repo.insert! %Figure{name: "Elrohir with heavy armour"}
    elrond           = Repo.insert! %Figure{name: "Elrond"}
    erestor          = Repo.insert! %Figure{name: "Erestor"}
    gil_galad        = Repo.insert! %Figure{name: "Gil-galad"}
    gildor           = Repo.insert! %Figure{name: "Gildor"}
    glorfindel       = Repo.insert! %Figure{name: "Glorfindel"}
    glorfindel_horse = Repo.insert! %Figure{name: "Glorfindel on horse"}
    glorfindel_lotw  = Repo.insert! %Figure{name: "Glorfindel, Lord of the West"}
    legolas          = Repo.insert! %Figure{name: "Legolas"}

    high_elf_captain = Repo.insert! %Figure{name: "High Elf Captain", plural_name: "High Elf Captains"}

    high_elf_w_banner       = Repo.insert! %Figure{name: "High Elf with banner",           plural_name: "High Elves with banner"}
    high_elf_w_blade        = Repo.insert! %Figure{name: "High Elf with Elven blade",      plural_name: "High Elves with Elven blade"}
    high_elf_w_bow          = Repo.insert! %Figure{name: "High Elf with bow",              plural_name: "High Elves with bow"}
    high_elf_w_spear_shield = Repo.insert! %Figure{name: "High Elf with spear and shield", plural_name: "High Elves with spear and shield"}

    #########################################################################
    # FIGURES: ROHAN
    #########################################################################

    eomer               = Repo.insert! %Figure{name: "Eomer"}
    eomer_horse         = Repo.insert! %Figure{name: "Eomer on horse"}
    eorl_horse          = Repo.insert! %Figure{name: "Eorl the Young on horse"}
    eowyn_armor         = Repo.insert! %Figure{name: "Éowyn with armour"}
    eowyn_horse         = Repo.insert! %Figure{name: "Éowyn on horse"}
    erkenbrand          = Repo.insert! %Figure{name: "Erkenbrand"}
    erkenbrand_horse    = Repo.insert! %Figure{name: "Erkenbrand on horse"}
    gamling             = Repo.insert! %Figure{name: "Gamling"}
    gamling_horse       = Repo.insert! %Figure{name: "Gamling on horse with banner"}
    hama                = Repo.insert! %Figure{name: "Hama"}
    merry_rohan         = Repo.insert! %Figure{name: "Meriadoc, Knight of the Mark"}
    theoden             = Repo.insert! %Figure{name: "Théoden"}
    theoden_horse       = Repo.insert! %Figure{name: "Théoden on horse"}
    theoden_armor_horse = Repo.insert! %Figure{name: "Théoden with armor on armored horse"}
    theodred_horse      = Repo.insert! %Figure{name: "Théodred on horse"}

    rohan_captain       = Repo.insert! %Figure{name: "Captain of Rohan",          plural_name: "Captains of Rohan"}
    rohan_captain_horse = Repo.insert! %Figure{name: "Captain of Rohan on horse", plural_name: "Captains of Rohan on horse"}

    rohan_gd              = Repo.insert! %Figure{name: "Rohan Royal Guard",                               plural_name: "Rohan Royal Guards"}
    rohan_gd_spear        = Repo.insert! %Figure{name: "Rohan Royal Guard with throwing spear",           plural_name: "Rohan Royal Guards with throwing spear"}
    rohan_gd_horse_spear  = Repo.insert! %Figure{name: "Rohan Royal Guard with throwing spear on horse",  plural_name: "Rohan Royal Guards with throwing spear on horse"}
    rohan_gd_horse_banner = Repo.insert! %Figure{name: "Rohan Royal Guard with banner",                   plural_name: "Rohan Royal Guards with banner"}
    rohan_outrider        = Repo.insert! %Figure{name: "Rohan Outrider",                                  plural_name: "Rohan Outriders"}
    rohan_rider           = Repo.insert! %Figure{name: "Rider of Rohan",                                  plural_name: "Riders of Rohan"}
    rohan_rider_banner    = Repo.insert! %Figure{name: "Rider of Rohan with banner",                      plural_name: "Riders of Rohan with banner"}
    rohan_rider_spear     = Repo.insert! %Figure{name: "Rider of Rohan with throwing spear",              plural_name: "Riders of Rohan with throwing spear"}
    rohan_w_banner        = Repo.insert! %Figure{name: "Warrior of Rohan with banner",                    plural_name: "Warriors of Rohan with banner"}
    rohan_w_bow           = Repo.insert! %Figure{name: "Warrior of Rohan with bow",                       plural_name: "Warriors of Rohan with bow"}
    rohan_w_shield        = Repo.insert! %Figure{name: "Warrior of Rohan with shield",                    plural_name: "Warriors of Rohan with shield"}
    rohan_w_spear_shield  = Repo.insert! %Figure{name: "Warrior of Rohan with throwing spear and shield", plural_name: "Warriors of Rohan with throwing spear and shield"}

    #########################################################################
    # SHIRE
    #########################################################################

    bandobras      = Repo.insert! %Figure{name: "Bandobras Took"}
    bandobras_pony = Repo.insert! %Figure{name: "Bandobras Took on pony"}
    bilbo          = Repo.insert! %Figure{name: "Bilbo Baggins"}
    fang           = Repo.insert! %Figure{name: "Fang"}
    fatty          = Repo.insert! %Figure{name: "Fredegar Bolger"}
    grip           = Repo.insert! %Figure{name: "Grip"}
    lobelia        = Repo.insert! %Figure{name: "Lobelia Sackville-Baggins"}
    maggot         = Repo.insert! %Figure{name: "Farmer Maggot"}
    paladin        = Repo.insert! %Figure{name: "Paladin Took"}
    wolf           = Repo.insert! %Figure{name: "Wolf"}

    hobbit_archer      = Repo.insert! %Figure{name: "Hobbit Archer",                  plural_name: "Hobbit Archers"}
    hobbit_archer_horn = Repo.insert! %Figure{name: "Hobbit Archer with signal horn", plural_name: "Hobbit Archers with signal horn"}
    hobbit_militia     = Repo.insert! %Figure{name: "Hobbit Militia",                 plural_name: "Hobbit Militia"}
    hobbit_shirriff    = Repo.insert! %Figure{name: "Hobbit Shirriff",                plural_name: "Hobbit Shirriffs"}

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

    bpf_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s1.id, faction: :gondor, suggested_points: 280, actual_points: 280, sort_order: 1}
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

    bpf_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s2.id, faction: :gondor, suggested_points: 300, actual_points: 331, sort_order: 1}
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

    bpf_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s3.id, faction: :gondor, suggested_points: 500, actual_points: 688, sort_order: 1}
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

    bpf_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s4.id, faction: :gondor, suggested_points: 500, actual_points: 0, sort_order: 1}
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

    bpf_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s5.id, faction: :gondor, suggested_points: 400, actual_points: 0, sort_order: 1}
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

    bpf_s7f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s7.id, faction: :gondor, suggested_points: 750, actual_points: 0, sort_order: 1}
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

    bpf_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s8.id, faction: :gondor, suggested_points: 400, actual_points: 0, sort_order: 1}
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

    bpf_s9f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s9.id, faction: :gondor, suggested_points: 1250, actual_points: 0, sort_order: 1}
    _declare_role_figure(bpf_s9f1,  1,  1, [ faramir_armor_horse ])
    _declare_role_figure(bpf_s9f1,  1,  2, [ gandalf_white_horse ])
    _declare_role_figure(bpf_s9f1,  1,  3, [ imrahil_horse ])
    _declare_role_figure(bpf_s9f1,  2,  4, [ gondor_captain_mt_horse ])
    _declare_role_figure(bpf_s9f1,  5,  5, [ gondor_womt_spear_shield ])
    _declare_role_figure(bpf_s9f1,  4,  6, [ gondor_womt_bow ])
    _declare_role_figure(bpf_s9f1,  1,  7, [ gondor_womt_banner ])
    _declare_role_figure(bpf_s9f1, 10,  8, [ gondor_rog ])
    _declare_role_figure(bpf_s9f1, 10,  9, [ gondor_knight ])
    _declare_role_figure(bpf_s9f1,  8, 10, [ gondor_knight_da_horse ])

    bpf_s9f2 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s9.id, faction: :mordor, suggested_points: 1000, actual_points: 0, sort_order: 2}
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

    bpf_s10f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s10.id, faction: :gondor, suggested_points: 800, actual_points: 0, sort_order: 1}
    _declare_role_figure(bpf_s10f1,  1,  1, [ theoden_armor_horse ])
    _declare_role_figure(bpf_s10f1,  1,  2, [ gamling_horse ])
    _declare_role_figure(bpf_s10f1,  1,  3, [ eowyn_horse ])
    _declare_role_figure(bpf_s10f1,  1,  4, [ merry_rohan ])
    _declare_role_figure(bpf_s10f1,  1,  5, [ rohan_captain_horse ])
    _declare_role_figure(bpf_s10f1,  6,  6, [ rohan_gd_horse_spear ])
    _declare_role_figure(bpf_s10f1, 12,  7, [ rohan_rider ])
    _declare_role_figure(bpf_s10f1,  6,  8, [ rohan_rider_spear ])

    bpf_s10f2 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s10.id, faction: :mordor, suggested_points: 800, actual_points: 0, sort_order: 2}
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

    bpf_s11f1 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s11.id, faction: :gondor, suggested_points: 1000, actual_points: 0, sort_order: 1}
    _declare_role_figure(bpf_s11f1,  1,  1, [ imrahil_horse ])
    _declare_role_figure(bpf_s11f1,  1,  2, "Aragorn with Elven cloak and Andúril", [ aragorn ])
    _declare_role_figure(bpf_s11f1,  1,  3, [ legolas ])
    _declare_role_figure(bpf_s11f1,  1,  4, [ gimli ])
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

    bpf_s11f2 = Repo.insert! %ScenarioFaction{scenario_id: bpf_s11.id, faction: :mordor, suggested_points: 1000, actual_points: 0, sort_order: 2}
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
      date_age: 3,  date_year: 2061, date_month: 0, date_day: 0, size: 65,
      map_width: 48, map_height: 48, location: :mirkwood
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
      date_age: 3, date_year: 2062, date_month: 0, date_day: 0, size: 23,
      map_width: 48, map_height: 48, location: :mirkwood
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
      blurb: "The Istari face the minions of Dol Guldur.",
      date_age: 3, date_year: 2062, date_month: -1, date_day: 0, size: 17,
      map_width: 24, map_height: 24, location: :mirkwood
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
      blurb: "Lothlórien attacks the beasts of Mirkwood",
      date_age: 3, date_year: 2063, date_month: 0, date_day: 0, size: 41,
      map_width: 24, map_height: 24, location: :mirkwood
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
      date_age: 3, date_year: 2850, date_month: 0, date_day: 0, size: 91,
      map_width: 48, map_height: 48, location: :dol_guldur
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
      date_age: 3, date_year: 2851, date_month: 0, date_day: 0, size: 29,
      map_width: 24, map_height: 24, location: :dol_guldur
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
    # FALLEN REALMS
    #########################################################################

    #========================================================================
    fr_s1 = Repo.insert! %Scenario{
      name: "The Deeping Wall",
      blurb: "The Uruk-hai attempt to breach the outer defenses of Helm's Deep.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 73,
      map_width: 48, map_height: 24, location: :helms_deep
    }

    Repo.insert! %ScenarioResource{scenario_id: fr_s1.id, resource_type: :source, book: :fr, title: "Fallen Realms", sort_order: 1, page: 46}

    fr_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: fr_s1.id, faction: :rohan,  suggested_points: 600, actual_points: 0, sort_order: 1}
    _declare_role_figure(fr_s1f1, 1,  1, "Aragorn with Elven cloak", [ aragorn ])
    _declare_role_figure(fr_s1f1, 1,  2, "Legolas with Elven cloak", [ legolas ])
    _declare_role_figure(fr_s1f1, 1,  3, "Gimli with Elven cloak", [ gimli ])
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
    _declare_role_figure(fr_s1f2,  2,  7, [ uruk_hai_demo_team ])

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

    fotrjb_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s1.id, faction: :mordor, suggested_points: 180, actual_points: 180, sort_order: 2}
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

    fotrjb_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s2.id, faction: :mordor, suggested_points: 550, actual_points: 550, sort_order: 2}
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

    fotrjb_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s3.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s3f1, 1, 1, [ frodo ])
    _declare_role_figure(fotrjb_s3f1, 1, 2, [ sam ])
    _declare_role_figure(fotrjb_s3f1, 1, 3, [ pippin ])
    _declare_role_figure(fotrjb_s3f1, 1, 4, [ merry ])
    _declare_role_figure(fotrjb_s3f1, 1, 5, [ gildor ])

    fotrjb_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s3.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 2}
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

    fotrjb_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s4.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 2}
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
    _declare_role_figure(fotrjb_s6f1, 1, 1, [ gandalf_grey ])

    fotrjb_s6f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s6.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 2}
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
    _declare_role_figure(fotrjb_s7f1, 1, 1, [ gandalf_grey ])
    _declare_role_figure(fotrjb_s7f1, 6, 2, [ dunedain ])

    fotrjb_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s7.id, faction: :mordor, suggested_points: 220, actual_points: 220, sort_order: 2}
    _declare_role_figure(fotrjb_s7f2, 4, 1, [ ringwraith ])

    #========================================================================
    fotrjb_s8 = Repo.insert! %Scenario{
      name: "Amon Sûl",
      blurb: "Frodo and friends are attacked by the Ringwraiths at Weathertop.",
      date_age: 3, date_year: 3018, date_month: 10, date_day: 6, size: 10,
      map_width: 48, map_height: 48, location: :weathertop
    }

    Repo.insert! %ScenarioResource{scenario_id: fotrjb_s8.id, resource_type: :source, book: :fotr_jb, title: "The Fellowship of the Ring Journeybook", sort_order: 8, page: 46}

    fotrjb_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s8.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s8f1, 1, 1, [ frodo ])
    _declare_role_figure(fotrjb_s8f1, 1, 2, [ sam ])
    _declare_role_figure(fotrjb_s8f1, 1, 3, [ merry ])
    _declare_role_figure(fotrjb_s8f1, 1, 4, [ pippin ])
    _declare_role_figure(fotrjb_s8f1, 1, 5, [ aragorn ])

    fotrjb_s8f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s8.id, faction: :mordor, suggested_points: 330, actual_points: 330, sort_order: 2}
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
    _declare_role_figure(fotrjb_s9f1, 1, 6, [ gandalf_grey ])
    _declare_role_figure(fotrjb_s9f1, 1, 7, [ boromir ])
    _declare_role_figure(fotrjb_s9f1, 1, 8, [ legolas ])
    _declare_role_figure(fotrjb_s9f1, 1, 9, [ gimli ])

    fotrjb_s9f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s9.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 2}
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
    _declare_role_figure(fotrjb_s10f1, 1, 6, [ gandalf_grey ])
    _declare_role_figure(fotrjb_s10f1, 1, 7, [ boromir ])
    _declare_role_figure(fotrjb_s10f1, 1, 8, [ legolas ])
    _declare_role_figure(fotrjb_s10f1, 1, 9, [ gimli ])

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
    _declare_role_figure(fotrjb_s11f1, 1, 6, [ gandalf_grey ])
    _declare_role_figure(fotrjb_s11f1, 1, 7, [ boromir ])
    _declare_role_figure(fotrjb_s11f1, 1, 8, [ legolas ])
    _declare_role_figure(fotrjb_s11f1, 1, 9, [ gimli ])

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

    fotrjb_s12f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s12.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s12f1, 1, 1, [ frodo ])
    _declare_role_figure(fotrjb_s12f1, 1, 2, [ sam ])
    _declare_role_figure(fotrjb_s12f1, 1, 3, [ merry ])
    _declare_role_figure(fotrjb_s12f1, 1, 4, [ pippin ])
    _declare_role_figure(fotrjb_s12f1, 1, 5, [ aragorn ])
    _declare_role_figure(fotrjb_s12f1, 1, 6, [ gandalf_grey ])
    _declare_role_figure(fotrjb_s12f1, 1, 7, [ boromir ])
    _declare_role_figure(fotrjb_s12f1, 1, 8, [ legolas ])
    _declare_role_figure(fotrjb_s12f1, 1, 9, [ gimli ])

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
    _declare_role_figure(fotrjb_s13f1, 1, 6, [ gandalf_grey ])
    _declare_role_figure(fotrjb_s13f1, 1, 7, [ boromir ])
    _declare_role_figure(fotrjb_s13f1, 1, 8, [ legolas ])
    _declare_role_figure(fotrjb_s13f1, 1, 9, [ gimli ])

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
    _declare_role_figure(fotrjb_s14f1, 1, 6, [ gandalf_grey ])
    _declare_role_figure(fotrjb_s14f1, 1, 7, [ boromir ])
    _declare_role_figure(fotrjb_s14f1, 1, 8, [ legolas ])
    _declare_role_figure(fotrjb_s14f1, 1, 9, [ gimli ])

    fotrjb_s14f2 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s14.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(fotrjb_s14f2, 1, 1, [ balrog ])
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
    _declare_role_figure(fotrjb_s15f1, 1,  8, [ gimli ])
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

    fotrjb_s16f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s16.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s16f1, 1,  1, [ aragorn ])
    _declare_role_figure(fotrjb_s16f1, 1,  2, [ legolas ])
    _declare_role_figure(fotrjb_s16f1, 1,  3, [ gimli ])
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

    fotrjb_s18f1 = Repo.insert! %ScenarioFaction{scenario_id: fotrjb_s18.id, faction: :fellowship, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fotrjb_s18f1, 1,  1, [ aragorn ])
    _declare_role_figure(fotrjb_s18f1, 1,  2, [ legolas ])
    _declare_role_figure(fotrjb_s18f1, 1,  3, [ gimli ])
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

    fp_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: fp_s1.id, faction: :isengard, suggested_points: 175, actual_points: 175, sort_order: 1}
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

    fp_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: fp_s2.id, faction: :mordor, suggested_points: 1575, actual_points: 1575, sort_order: 2}
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

    fp_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: fp_s3.id, faction: :dwarves, suggested_points: 200, actual_points: 0, sort_order: 1}
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

    fp_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: fp_s4.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 2}
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

    fp_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: fp_s5.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(fp_s5f2,  1,  1, [ witch_king_horse ])
    _declare_role_figure(fp_s5f2,  8,  2, [ ringwraith_horse ])

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

    gif_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: gif_s1.id, faction: :mordor, suggested_points: 900, actual_points: 0, sort_order: 2}
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

    gif_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: gif_s2.id, faction: :gondor, suggested_points: 750, actual_points: 0, sort_order: 1}
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

    gif_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: gif_s2.id, faction: :mordor, suggested_points: 1050, actual_points: 0, sort_order: 2}
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

    gif_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: gif_s3.id, faction: :gondor, suggested_points: 1000, actual_points: 0, sort_order: 1}
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

    gif_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: gif_s3.id, faction: :mordor, suggested_points: 1000, actual_points: 0, sort_order: 2}
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

    gif_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: gif_s4.id, faction: :gondor, suggested_points: 600, actual_points: 0, sort_order: 1}
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

    gif_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: gif_s5.id, faction: :gondor, suggested_points: 1050, actual_points: 0, sort_order: 1}
    _declare_role_figure(gif_s5f1,  1,  1, "Aragorn with Anduril", [ aragorn ])
    _declare_role_figure(gif_s5f1,  1,  2, [ legolas ])
    _declare_role_figure(gif_s5f1,  1,  3, [ gimli ])
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

    harad_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: harad_s1.id, faction: :gondor, suggested_points: 250, actual_points: 0, sort_order: 1}
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

    harad_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: harad_s2.id, faction: :gondor, suggested_points: 300, actual_points: 0, sort_order: 1}
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

    harad_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: harad_s3.id, faction: :gondor, suggested_points: 550, actual_points: 0, sort_order: 1}
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

    harad_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: harad_s4.id, faction: :gondor, suggested_points: 625, actual_points: 0, sort_order: 1}
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

    harad_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: harad_s5.id, faction: :gondor, suggested_points: 650, actual_points: 0, sort_order: 1}
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

    harad_s6f1 = Repo.insert! %ScenarioFaction{scenario_id: harad_s6.id, faction: :gondor, suggested_points: 2000, actual_points: 0, sort_order: 1}
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
    # KHAZAD-DÛM
    #########################################################################

    #========================================================================
    kd_s1 = Repo.insert! %Scenario{
      name: "Durin's Tower",
      blurb: "A Dragon attacks the topmost outpost of the Dwarven realm of Moria.",
      date_age: 3, date_year: 1970, date_month: 0, date_day: 0, size: 36,
      map_width: 24, map_height: 24, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: kd_s1.id, resource_type: :source, book: :kd, title: "Khazad-dûm", sort_order: 1, page: 54}

    kd_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: kd_s1.id, faction: :dwarves, suggested_points: 500, actual_points: 0, sort_order: 1}
    _declare_role_figure(kd_s1f1, 1,  1, [ dwarf_captain ])
    _declare_role_figure(kd_s1f1, 3,  2, [ vault_team ])
    _declare_role_figure(kd_s1f1, 4,  3, [ dwarf_r_axe ])
    _declare_role_figure(kd_s1f1, 4,  4, [ dwarf_r_bow ])
    _declare_role_figure(kd_s1f1, 4,  5, [ dwarf_r_2h ])
    _declare_role_figure(kd_s1f1, 6,  6, [ dwarf_iron_gd ])
    _declare_role_figure(kd_s1f1, 4,  7, [ dwarf_w_bow ])
    _declare_role_figure(kd_s1f1, 4,  8, [ dwarf_w_shield ])
    _declare_role_figure(kd_s1f1, 4,  9, [ dwarf_w_2h ])
    _declare_role_figure(kd_s1f1, 1, 10, [ dwarf_w_banner ])

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

    kd_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: kd_s2.id, faction: :dwarves, suggested_points: 200, actual_points: 0, sort_order: 1}
    _declare_role_figure(kd_s2f1, 1,  1, [ dwarf_captain ])
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
      date_age: 3, date_year: 1980, date_month: 0, date_day: 0, size: 126,
      map_width: 48, map_height: 48, location: :moria
    }

    Repo.insert! %ScenarioResource{scenario_id: kd_s3.id, resource_type: :source, book: :kd, title: "Khazad-dûm", sort_order: 3, page: 58}

    kd_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: kd_s3.id, faction: :dwarves, suggested_points: 985, actual_points: 0, sort_order: 1}
    _declare_role_figure(kd_s3f1, 1,  1, [ durin ])
    _declare_role_figure(kd_s3f1, 1,  2, [ mardin ])
    _declare_role_figure(kd_s3f1, 1,  3, [ dwarf_captain ])
    _declare_role_figure(kd_s3f1, 8,  4, [ dwarf_w_shield ])
    _declare_role_figure(kd_s3f1, 8,  5, [ dwarf_w_bow ])
    _declare_role_figure(kd_s3f1, 8,  6, [ dwarf_w_2h ])
    _declare_role_figure(kd_s3f1, 9,  7, [ dwarf_khazad_gd ])
    _declare_role_figure(kd_s3f1, 6,  8, [ dwarf_iron_gd ])
    _declare_role_figure(kd_s3f1, 3,  9, [ vault_team ])
    _declare_role_figure(kd_s3f1, 2, 10, [ dwarf_ballista ])
    _declare_role_figure(kd_s3f1, 4, 11, [ dwarf_r_2h ])
    _declare_role_figure(kd_s3f1, 4, 12, [ dwarf_r_bow ])
    _declare_role_figure(kd_s3f1, 4, 13, [ dwarf_r_axe ])

    kd_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: kd_s3.id, faction: :moria, suggested_points: 1000, actual_points: 0, sort_order: 2}
    _declare_role_figure(kd_s3f2,  1,  1, [ balrog ])
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

    kd_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: kd_s4.id, faction: :dwarves, suggested_points: 595, actual_points: 0, sort_order: 1}
    _declare_role_figure(kd_s4f1, 1,  1, "Balin with Durin's Axe", [ balin ])
    _declare_role_figure(kd_s4f1, 1,  2, [ dwarf_captain ])
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
      date_age: 3, date_year: 2954, date_month: 0, date_day: 0, size: 56,
      map_width: 48, map_height: 48, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: kd_s5.id, resource_type: :source, book: :kd, title: "Khazad-dûm", sort_order: 5, page: 62}

    kd_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: kd_s5.id, faction: :dwarves, suggested_points: 600, actual_points: 0, sort_order: 1}
    _declare_role_figure(kd_s5f1, 1,  1, [ dwarf_king_2h ])
    _declare_role_figure(kd_s5f1, 1,  2, [ dwarf_captain ])
    _declare_role_figure(kd_s5f1, 1,  3, [ murin ])
    _declare_role_figure(kd_s5f1, 1,  4, [ drar ])
    _declare_role_figure(kd_s5f1, 3,  5, [ dwarf_khazad_gd ])
    _declare_role_figure(kd_s5f1, 7,  6, [ dwarf_w_bow ])
    _declare_role_figure(kd_s5f1, 7,  7, [ dwarf_w_shield ])
    _declare_role_figure(kd_s5f1, 6,  8, [ dwarf_w_2h ])
    _declare_role_figure(kd_s5f1, 1,  9, [ dwarf_w_banner ])
    _declare_role_figure(kd_s5f1, 1, 10, [ dwarf_ballista ])

    kd_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: kd_s5.id, faction: :moria, suggested_points: 600, actual_points: 0, sort_order: 2}
    _declare_role_figure(kd_s5f2, 1,  1, "Dragon with Fly and Wyrmtongue", [ dragon ])
    _declare_role_figure(kd_s5f2, 1,  2, [ moria_captain ])
    _declare_role_figure(kd_s5f2, 1,  3, [ warg_chieftain ])
    _declare_role_figure(kd_s5f2, 6,  4, [ warg ])
    _declare_role_figure(kd_s5f2, 6,  5, [ moria_g_spear ])
    _declare_role_figure(kd_s5f2, 6,  6, [ moria_g_bow ])
    _declare_role_figure(kd_s5f2, 6,  7, [ moria_g_shield ])

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

    ma_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: ma_s1.id, faction: :dwarves, suggested_points: 300, actual_points: 293, sort_order: 1}
    _declare_role_figure(ma_s1f1, 1,  1, "Dwarf Captains with shield", [ dwarf_captain ])
    _declare_role_figure(ma_s1f1, 4,  2, [ dwarf_w_shield ])
    _declare_role_figure(ma_s1f1, 4,  3, [ dwarf_w_bow ])
    _declare_role_figure(ma_s1f1, 4,  4, [ dwarf_w_2h ])
    _declare_role_figure(ma_s1f1, 5,  5, [ dwarf_khazad_gd ])

    ma_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: ma_s1.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(ma_s1f2, 1,  1, [ balrog ])
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
    _declare_role_figure(ma_s2f1, 1,  1, [ gandalf_grey ])
    _declare_role_figure(ma_s2f1, 1,  2, "Aragorn with bow", [ aragorn ])
    _declare_role_figure(ma_s2f1, 1,  3, [ boromir ])
    _declare_role_figure(ma_s2f1, 1,  4, [ legolas ])
    _declare_role_figure(ma_s2f1, 1,  5, [ gimli ])
    _declare_role_figure(ma_s2f1, 1,  6, "Frodo with Sting and mithril coat", [ frodo ])
    _declare_role_figure(ma_s2f1, 1,  7, [ sam ])
    _declare_role_figure(ma_s2f1, 1,  8, [ merry ])
    _declare_role_figure(ma_s2f1, 1,  9, [ pippin ])

    ma_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: ma_s2.id, faction: :moria, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(ma_s2f2, 1,  1, [ balrog ])
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

    rotkjb_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s1.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s1f2, 1, 1, [ shelob ])
    _declare_role_figure(rotkjb_s1f2, 1, 2, [ gollum ])

    #========================================================================
    rotkjb_s2 = Repo.insert! %Scenario{
      name: "Ride of the Rohirrim",
      blurb: "The Druadan help the Rohirrim through their forest to bypass the bulk of the Mordor forces.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 13, size: 4,
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

    rotkjb_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s2.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 2}
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

    rotkjb_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s3.id, faction: :gondor, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s3f1,  1,  1, [ faramir_armor_horse ])
    _declare_role_figure(rotkjb_s3f1,  1,  2, [ gandalf_white_horse ])
    _declare_role_figure(rotkjb_s3f1,  1,  3, [ imrahil_horse ])
    _declare_role_figure(rotkjb_s3f1,  1,  4, [ gondor_captain_mt ])
    _declare_role_figure(rotkjb_s3f1,  8,  5, [ gondor_womt_spear_shield ])
    _declare_role_figure(rotkjb_s3f1,  8,  6, [ gondor_womt_shield ])
    _declare_role_figure(rotkjb_s3f1,  8,  7, [ gondor_womt_bow ])
    _declare_role_figure(rotkjb_s3f1,  4,  8, [ gondor_rog ])
    _declare_role_figure(rotkjb_s3f1,  5,  9, [ gondor_knight_shield ])
    _declare_role_figure(rotkjb_s3f1,  1, 10, [ gondor_knight_banner ])
    _declare_role_figure(rotkjb_s3f1,  6, 11, "Knight of Dol Amroth on horse with lance", [ gondor_knight_da_horse ])

    rotkjb_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s3.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s3f2,  1,  1, [ ringwraith_fellbeast ])
    _declare_role_figure(rotkjb_s3f2,  2,  2, "Orc Captain with shield", [ orc_captain ])
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

    rotkjb_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s4.id, faction: :gondor, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s4f1,  1,  1, [ gandalf_white ])
    _declare_role_figure(rotkjb_s4f1,  1,  2, [ pippin_gondor ])
    _declare_role_figure(rotkjb_s4f1,  1,  3, [ forlong ])
    _declare_role_figure(rotkjb_s4f1,  8,  4, [ gondor_womt_shield ])
    _declare_role_figure(rotkjb_s4f1,  8,  5, [ gondor_womt_spear_shield ])
    _declare_role_figure(rotkjb_s4f1,  8,  6, [ gondor_womt_bow ])
    _declare_role_figure(rotkjb_s4f1,  1,  7, [ gondor_womt_banner ])
    _declare_role_figure(rotkjb_s4f1,  3,  8, [ axemen_lossarnach ])
    _declare_role_figure(rotkjb_s4f1,  6,  9, [ clansmen_lamedon ])

    rotkjb_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s4.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 2}
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

    rotkjb_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s5.id, faction: :gondor, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s5f1,  1,  1, [ gandalf_white ])
    _declare_role_figure(rotkjb_s5f1,  1,  2, [ pippin_gondor ])
    _declare_role_figure(rotkjb_s5f1,  1,  3, [ imrahil ])
    _declare_role_figure(rotkjb_s5f1,  7,  4, [ gondor_womt_shield ])
    _declare_role_figure(rotkjb_s5f1,  8,  5, [ gondor_womt_spear_shield ])
    _declare_role_figure(rotkjb_s5f1,  8,  6, [ gondor_womt_bow ])
    _declare_role_figure(rotkjb_s5f1,  1,  7, [ gondor_womt_banner ])
    _declare_role_figure(rotkjb_s5f1,  9,  8, [ gondor_knight_da_foot ])

    rotkjb_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s5.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s5f2,  1,  1, [ witch_king_horse ])
    _declare_role_figure(rotkjb_s5f2,  2,  1, "Orc Captain with shield", [ orc_captain ])
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

    rotkjb_s7f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s7.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s7f2,  1,  1, [ witch_king_fellbeast ])

    #========================================================================
    rotkjb_s8 = Repo.insert! %Scenario{
      name: "The Glory of Dol Amroth",
      blurb: "Prince Imrahil rides out from Minas Tirith.",
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 140,
      map_width: 48, map_height: 48, location: :minas_tirith
    }

    Repo.insert! %ScenarioResource{scenario_id: rotkjb_s8.id, resource_type: :source, book: :rotk_jb, title: "Return of the King Journeybook", sort_order: 8, page: 56}

    rotkjb_s8f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s8.id, faction: :gondor, suggested_points: 0, actual_points: 0, sort_order: 1}
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

    rotkjb_s10f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s10.id, faction: :gondor, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s10f1,  1,  1, "Aragorn with Andúril", [ aragorn ])
    _declare_role_figure(rotkjb_s10f1,  1,  2, [ legolas ])
    _declare_role_figure(rotkjb_s10f1,  1,  3, [ gimli ])
    _declare_role_figure(rotkjb_s10f1,  1,  4, [ angbor ])
    _declare_role_figure(rotkjb_s10f1,  8,  5, [ ranger_north ])
    _declare_role_figure(rotkjb_s10f1,  4,  6, [ ranger_north_spear ])
    _declare_role_figure(rotkjb_s10f1, 12,  7, [ axemen_lossarnach ])
    _declare_role_figure(rotkjb_s10f1, 11,  8, [ clansmen_lamedon ])

    rotkjb_s10f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s10.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 2}
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

    rotkjb_s11f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s11.id, faction: :gondor, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s11f1,  1,  1, [ gandalf_white_horse ])
    _declare_role_figure(rotkjb_s11f1,  1,  2, [ pippin_gondor ])
    _declare_role_figure(rotkjb_s11f1,  1,  3, [ beregond ])

    rotkjb_s11f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s11.id, faction: :gondor, suggested_points: 0, actual_points: 0, sort_order: 2}
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

    rotkjb_s12f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s12.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s12f1,  1,  1, [ frodo ])
    _declare_role_figure(rotkjb_s12f1,  1,  2, "Samwise the Brave with Elven cloak", [ sam ])
    _declare_role_figure(rotkjb_s12f1,  1,  3, [ shagrat ])
    _declare_role_figure(rotkjb_s12f1,  8,  4, [ m_uruk_hai ])
    _declare_role_figure(rotkjb_s12f1,  4,  5, [ m_uruk_hai_2h ])

    rotkjb_s12f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s12.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 2}
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

    rotkjb_s13f1 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s13.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 1}
    _declare_role_figure(rotkjb_s13f1,  1,  1, "Aragorn the King", [ aragorn ])
    _declare_role_figure(rotkjb_s13f1,  1,  2, [ gwaihir ])
    _declare_role_figure(rotkjb_s13f1,  1,  3, [ gandalf_white ])
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

    rotkjb_s13f2 = Repo.insert! %ScenarioFaction{scenario_id: rotkjb_s13.id, faction: :mordor, suggested_points: 0, actual_points: 0, sort_order: 2}
    _declare_role_figure(rotkjb_s13f2,  1,  1, [ troll_chieftain ])
    _declare_role_figure(rotkjb_s13f2,  3,  2, [ ringwraith_fellbeast ])
    _declare_role_figure(rotkjb_s13f2,  1,  3, [ mouth ])
    _declare_role_figure(rotkjb_s13f2, 13,  4, "Orc Captain with shield", [ orc_captain ])
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
      blurb: "Aragorn's father Arathorn is ambushedby villains in the wild.",
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

    sots_s10f1 = Repo.insert! %ScenarioFaction{scenario_id: sots_s10.id, faction: :shire, suggested_points: 200, actual_points: 126, sort_order: 1}
    _declare_role_figure(sots_s10f1, 1, 1, [ gandalf_grey ])
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

    sots_s12f1 = Repo.insert! %ScenarioFaction{scenario_id: sots_s12.id, faction: :free_peoples, suggested_points: 400, actual_points: 397, sort_order: 1}
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

    saf_s1f1 = Repo.insert! %ScenarioFaction{scenario_id: saf_s1.id, faction: :dwarves, suggested_points: 200, actual_points: 0, sort_order: 1}
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

    saf_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: saf_s2.id, faction: :dwarves, suggested_points: 600, actual_points: 0, sort_order: 1}
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

    saf_s3f1 = Repo.insert! %ScenarioFaction{scenario_id: saf_s3.id, faction: :dwarves, suggested_points: 300, actual_points: 0, sort_order: 1}
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

    saf_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: saf_s4.id, faction: :dwarves, suggested_points: 500, actual_points: 0, sort_order: 1}
    _declare_role_figure(saf_s4f1,  2, 1, [ dwarf_captain ])
    _declare_role_figure(saf_s4f1,  5, 2, [ dwarf_khazad_gd ])
    _declare_role_figure(saf_s4f1, 10, 3, [ dwarf_w_shield ])
    _declare_role_figure(saf_s4f1,  5, 4, [ dwarf_w_bow ])
    _declare_role_figure(saf_s4f1,  5, 5, [ dwarf_w_2h ])

    saf_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: saf_s4.id, faction: :moria,   suggested_points: 500, actual_points: 0, sort_order: 2}
    _declare_role_figure(saf_s4f2, 1, 1, [ balrog ])
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
    _declare_role_figure(saf_s7f1,  1, 1, [ radagast ])
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
      date_age: 3, date_year: 2998, date_month: -3, date_day: 0, size: 28,
      map_width: 48, map_height: 24, location: :ithilien
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
      date_age: 3, date_year: 2998, date_month: -2, date_day: 0, size: 47,
      map_width: 48, map_height: 48, location: :ithilien
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
      date_age: 3, date_year: 2998, date_month: -1, date_day: 0, size: 121,
      map_width: 48, map_height: 48, location: :ithilien
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
      date_age: 3, date_year: 3001, date_month: 0, date_day: 0, size: 71,
      map_width: 48, map_height: 48, location: :rhun
    }

    Repo.insert! %ScenarioResource{scenario_id: site_s5.id, resource_type: :source, book: :site, title: "A Shadow in the East", sort_order: 5, page: 36}

    site_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: site_s5.id, faction: :dwarves, suggested_points: 500, actual_points: 460, sort_order: 1}
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
      date_age: 3, date_year: 2510, date_month: 0, date_day: 0, size: 107,
      map_width: 48, map_height: 48, location: :rhovanion
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
      date_age: 3, date_year: 2520, date_month: 0, date_day: 0, size: 28,
      map_width: 48, map_height: 48, location: :fangorn
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
      date_age: 3, date_year: 3018, date_month: 6, date_day: 20, size: 110,
      map_width: 48, map_height: 48, location: :osgiliath
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
      date_age: 3, date_year: 3018, date_month: 3, date_day: 9, size: 100,
      map_width: 48, map_height: 48, location: :gondor
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
      date_age: 3, date_year: 3019, date_month: 3, date_day: 11, size: 69,
      map_width: 48, map_height: 48, location: :gondor
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
      date_age: 3, date_year: 3019, date_month: 3, date_day: 12, size: 87,
      map_width: 48, map_height: 48, location: :minas_tirith
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
      date_age: 3, date_year: 3019, date_month: 3, date_day: 14, size: 112,
      map_width: 48, map_height: 48, location: :minas_tirith
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
      date_age: 3, date_year: 3019, date_month: 3, date_day: 15, size: 84,
      map_width: 72, map_height: 48, location: :minas_tirith
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
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 109,
      map_width: 48, map_height: 48, location: :helms_deep
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
      date_age: 3, date_year: 3019, date_month: 3, date_day: 4, size: 105,
      map_width: 72, map_height: 48, location: :helms_deep
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
    # THE TWO TOWERS JOURNEYBOOK
    #########################################################################
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
    _declare_role_figure(tttjb_s1f1, 1, 3, [ gimli ])

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
    _declare_role_figure(tttjb_s6f1, 1, 4, "Gimli with Elven cloak", [ gimli ])
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

    #========================================================================
    tttjb_s9 = Repo.insert! %Scenario{
      name: "The Taming of Sméagol",
      blurb: "Gollum attempts to sneak up on Sam and Frodo to steal the One Ring.",
      date_age: 3, date_year: 3019, date_month: 2, date_day: 29, size: 3,
      map_width: 24, map_height: 24, location: :rhovanion
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s9.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 9, page: 46}

    tttjb_s9f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s9.id, faction: :fellowship, suggested_points: 150, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s9f1, 1, 1, "Frodo Baggins with Sting, mithril coat, and Elven cloak", [ frodo ])
    _declare_role_figure(tttjb_s9f1, 1, 2, "Sam Gamgee with Elven cloak", [ sam ])

    tttjb_s9f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s9.id, faction: :mordor, suggested_points: 150, actual_points: 0, sort_order: 2}
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

    tttjb_s10f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s10.id, faction: :mordor, suggested_points: 275, actual_points: 0, sort_order: 2}
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

    tttjb_s11f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s11.id, faction: :gondor, suggested_points: 375, actual_points: 0, sort_order: 1}
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

    tttjb_s12f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s12.id, faction: :gondor, suggested_points: 375, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s12f1, 1, 1, "Faramir with bow", [ faramir ])
    _declare_role_figure(tttjb_s12f1, 1, 2, [ madril ])
    _declare_role_figure(tttjb_s12f1, 1, 3, [ damrod ])
    _declare_role_figure(tttjb_s12f1, 1, 4, [ gondor_captain_mt ])
    _declare_role_figure(tttjb_s12f1, 6, 5, [ gondor_rog ])
    _declare_role_figure(tttjb_s12f1, 3, 6, [ osgiliath_v_shield ])
    _declare_role_figure(tttjb_s12f1, 3, 7, [ osgiliath_v_spear ])
    _declare_role_figure(tttjb_s12f1, 3, 8, [ osgiliath_v_bow ])
    _declare_role_figure(tttjb_s12f1, 1, 9, [ gondor_womt_banner ])

    tttjb_s12f2 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s12.id, faction: :mordor, suggested_points: 375, actual_points: 0, sort_order: 2}
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
      date_age: 3, date_year: 3019, date_month: 3, date_day: 3, size: 80,
      map_width: 48, map_height: 24, location: :helms_deep
    }

    Repo.insert! %ScenarioResource{scenario_id: tttjb_s13.id, resource_type: :source, book: :ttt_jb, title: "The Two Towers Journeybook", sort_order: 13, page: 72}

    tttjb_s13f1 = Repo.insert! %ScenarioFaction{scenario_id: tttjb_s13.id, faction: :rohan, suggested_points: 550, actual_points: 0, sort_order: 1}
    _declare_role_figure(tttjb_s13f1, 1, 1, "Aragorn with Andúril and armour", [ aragorn ])
    _declare_role_figure(tttjb_s13f1, 1, 2, "Legolas with armour and Elven cloak", [ legolas ])
    _declare_role_figure(tttjb_s13f1, 1, 3, "Gimli with Elven cloak", [ gimli ])
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
    _declare_role_figure(tttjb_s13f2,  3, 10, [ uruk_hai_demo_team ])
    _declare_role_figure(tttjb_s13f2,  1, 11, [ uruk_hai_ballista ])
    _declare_role_figure(tttjb_s13f2,  3, 12, [ uruk_hai_ballista_crew ])

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
    _declare_role_figure(tttjb_s14f1, 1, 4, "Gimli with Elven cloak", [ gimli ])
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
    _declare_role_figure(tttjb_s16f1,  1,  7, [ gandalf_white_horse ])
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

    mordor_s1f2 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s1.id, faction: :mordor, suggested_points: 1075, actual_points: 0, sort_order: 2}
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

    mordor_s2f1 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s2.id, faction: :gondor, suggested_points: 750, actual_points: 0, sort_order: 1}
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

    mordor_s2f2 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s2.id, faction: :mordor, suggested_points: 900, actual_points: 0, sort_order: 2}
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

    mordor_s3f2 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s3.id, faction: :mordor, suggested_points: 650, actual_points: 0, sort_order: 2}
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
    Repo.insert! %ScenarioResource{scenario_id: mordor_s4.id, resource_type: :podcast, title: "The Green Dragon", sort_order: 1, url: "https://soundcloud.com/the-green-dragon-podcasts/scenario-spotlight-ep-16-vengeance-of-the-nazgul"}

    mordor_s4f1 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s4.id, faction: :dwarves, suggested_points: 700, actual_points: 0, sort_order: 1}
    _declare_role_figure(mordor_s4f1,  1,  1, [ dain ])
    _declare_role_figure(mordor_s4f1,  1,  2, [ dwarf_captain ])
    _declare_role_figure(mordor_s4f1,  4,  3, [ dwarf_w_shield ])
    _declare_role_figure(mordor_s4f1,  4,  4, [ dwarf_w_bow ])
    _declare_role_figure(mordor_s4f1,  4,  5, [ dwarf_w_2h ])
    _declare_role_figure(mordor_s4f1,  1,  6, [ dwarf_w_banner ])
    _declare_role_figure(mordor_s4f1,  4,  7, [ dwarf_r_2h ])
    _declare_role_figure(mordor_s4f1,  4,  8, [ dwarf_r_axe ])
    _declare_role_figure(mordor_s4f1,  4,  9, [ dwarf_r_bow ])
    _declare_role_figure(mordor_s4f1, 12, 10, [ dwarf_khazad_gd ])
    _declare_role_figure(mordor_s4f1,  6, 11, [ dwarf_iron_gd ])

    mordor_s4f2 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s4.id, faction: :mordor, suggested_points: 780, actual_points: 0, sort_order: 2}
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

    mordor_s5f1 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s5.id, faction: :gondor, suggested_points: 475, actual_points: 0, sort_order: 1}
    _declare_role_figure(mordor_s5f1,  1, 1, [ boromir_wt_banner ])
    _declare_role_figure(mordor_s5f1,  1, 2, [ faramir_armor_horse ])
    _declare_role_figure(mordor_s5f1,  2, 3, [ gondor_captain_mt ])
    _declare_role_figure(mordor_s5f1, 16, 4, [ gondor_womt_shield ])
    _declare_role_figure(mordor_s5f1, 16, 5, [ gondor_womt_spear_shield ])
    _declare_role_figure(mordor_s5f1, 16, 6, [ gondor_womt_bow ])
    _declare_role_figure(mordor_s5f1,  2, 7, [ gondor_womt_banner ])

    mordor_s5f2 = Repo.insert! %ScenarioFaction{scenario_id: mordor_s5.id, faction: :mordor, suggested_points: 815, actual_points: 0, sort_order: 2}
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
