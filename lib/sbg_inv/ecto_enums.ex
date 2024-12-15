import EctoEnum

defenum Faction,
  angmar:           0, # check
  army_thror:       1, # check
  arnor:            2, # Armies of Arnor and Angmar: Arnor p10
  azogs_hunters:    3, # check
  azogs_legion:     4, # check
  barad_dur:        5, # check
  dale:             6, # check
  desolator_north:  7, # check
  dol_guldur:       8, # check
  dunharrow:        9, # check
  easterlings:     10, # check
  erebor:          11, # check
  fangorn:         12, # check
  far_harad:       13, # check
  fellowship:      14, # check
  fiefdoms:        15, # check
  goblintown:      16, # check
  harad:           17, # check
  iron_hills:      18, # check
  isengard:        19, # check
  khand:           20, # check
  khazad_dum:      21, # check
  laketown:        22, # check
  lothlorien:      23, # check
  minas_tirith:    24, # check
  mirkwood:        25, # check
  misty_mountains: 26, # check
  mordor:          27, # check
  moria:           28, # check
  numenor:         29, # check
  radagast:        30, # check
  rangers:         31, # check
  rivendell:       32, # check
  rogues:          33, # check
  rohan:           34, # check
  shire:           35, # check
  survivors:       36, # check
  thorins_co:      37, # check
  thranduil:       38, # check
  trolls:          39, # check
  umbar:           40, # check
  wanderers:       41, # check
  white_council:   42, # check
  wildmen:         43, # check
  beornings:       44, # check
  fornost:         45, # Armies of Arnor and Angmar: Battle of Fornost p11
  arathorn:        46, # Armies of Arnor and Angmar: Arathorn's Stand p12
  witch_king:      47, # Armies of Arnor and Angmar: Host of the Witch King p22
  shadows:         48, # Armies of Arnor and Angmar: Shadows of Angmar p23
  buhrdur:         49, # Armies of Arnor and Angmar: Burhdur's Horde p24
  wolf_angmar:     50, # Armies of Arnor and Angmar: Wolf Pack of Angmar p25
  carn_dum:        51  # Armies of Arnor and Angmar: Army of Carn Dum p26

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
  weathertop:   28,
  orthanc:      29

defenum ScenarioResourceBook,
  bot5a:    0,   # Battle of the Five Armies
  bpf:      1,   # Battle of the Pelennor Fields (Expansion)
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
  ttt_jb:  27,   # The Two Towers Journeybook
  bpf_ss:  28,   # Battle of the Pelennor Fields Starter Set
  alotr:   29,   # Armies of the Lord of the Rings
  ah:      30,   # Armies of the Hobbit
  gaw:     31,   # Gondor at War,
  bgime:   32,   # Battle Games in Middle Earth
  sos2:    33,   # Scouring of the Shire (v2),
  wfr:     34,   # War for Rohan [Typo! Title is "War In Rohan"!]
  qrb:     35,   # Quest of the Ringbearer
  fotn2:   36,   # Fall of the Necromancer (v2)
  dotn:    37,   # Defence of the North
  bog:     38,   # Battle of Osgiliath
  ang:     39,   # Rise of Angmar,
  twotr:   40,   # The War of the Rohirrim
  alotr2:  41,   # Armies of the Lord of the Rings v2
  ah2:     42,   # Armies of the Hobbit v2
  aaa:     43    # Armies of Arnor and Angmar (PDF)

defenum ScenarioResourceType,
  source:           0,
  video_replay:     1,
  web_replay:       2,
  terrain_building: 3,
  podcast:          4,
  magazine_replay:  5

defenum UserFigureOp,
  buy_unpainted:  0,
  sell_unpainted: 1,
  buy_painted:    2,
  sell_painted:   3,
  paint:          4


defenum CharacterResourceType,
  painting_guide: 0,
  analysis:       1
