import EctoEnum

defenum Faction,
  angmar:           0,
  army_thror:       1,
  arnor:            2,
  azogs_hunters:    3,
  azogs_legion:     4,
  dale:             5,
  mirkwood:         6,  # dark denizens
  desolator_north:  7,
  dol_guldur:       8,
  durins_folk:      9,
  easterlings:     10,
  elrond:          11,
  erebor:          12,
  rivendell:       13,  # eregion & rivendell
  fellowship:      14,
  fiefdoms:        15,
  goblintown:      16,
  harad:           17,
  iron_hills:      18,
  isengard:        19,
  laketown:        20,
  lothlorien:      21,
  minas_tirith:    22,
  mordor:          23,
  moria:           24,
  numenor:         25,
  radagast:        26,
  rohan:           27,
  shire:           28,
  survivors:       29,
  thorins_co:      30,
  thranduil:       31,
  trolls:          32,
  wanderers:       33,
  white_council:   34

defenum FigureType,
  hero:    0,
  warrior: 1,
  monster: 2,
  sieger:  3

defenum Location,
  amon_hen:      0,
  arnor:         1,
  dale:          2,
  dol_guldur:    3,
  erebor:        4,
  eriador:       5,
  fangorn:       6,
  fornost:       7,
  goblintown:    8,
  gondor:        9,
  harad:        10,
  harondor:     11,
  helms_deep:   12,
  isengard:     13,
  ithilien:     14,
  laketown:     15,
  lothlorien:   16,
  minas_morgul: 17,
  minas_tirith: 18,
  mirkwood:     19,
  mordor:       20,
  moria:        21,
  morannon:     22,
  osgiliath:    23,
  rhovanion:    24,
  rhun:         25,
  rohan:        26,
  the_shire:    27,
  weathertop:   28

defenum ScenarioResourceBook,
  bot5a:    0,   # Battle of the Five Armies
  bpf:      1,   # Battle of the Pelennor Fields
  dos:      2,   # The Desolation of Smaug
  fotn:     3,   # The Fall of the Necromancer
  fotr:     4,   # Fellowship of the Ring
  fotr_jb:  5,   # Fellowship of the Ring Journeybook
  fp:       6,   # Free Peoples
  fr:       7,   # Fallen Realms
  gif:      8,   # Gondor in Flames
  gt:       9,   # Escape from Goblintown
  harad:   10,   # Harad
  hobbit:  11,   # The Hobbit (An Unexpected Journey)
  kd:      12,   # Khazad-dûm
  km:      13,   # Kingdoms of Men
  ma:      14,   # Moria & Angmar
  mordor:  15,   # Mordor Faction/Source book
  omordor: 16,   # Mordor (old)
  roa:     17,   # The Ruin of Arnor
  rotk:    18,   # Return of the King
  rotk_jb: 19,   # Return of the King Journeybook
  saf:     20,   # Shadow & Flame
  sbg:     21,   # SBG Magazine
  site:    22,   # A Shadow in the East
  sog:     23,   # Siege of Gondor
  sots:    24,   # The Scouring of the Shire
  tba:     25,   # There and Back Again
  ttt:     26,   # The Two Towers
  ttt_jb:  27    # The Two Towers Journeybook

defenum ScenarioResourceType,
  source: 0,
  video_replay: 1,
  web_replay: 2,
  terrain_building: 3,
  podcast: 4,
  magazine_replay: 5

defenum UserFigureOp,
  buy_unpainted:  0,
  sell_unpainted: 1,
  buy_painted:    2,
  sell_unpainted: 3,
  paint:          4
