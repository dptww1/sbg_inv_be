import EctoEnum

defenum Faction,
  angmar:           0, # obsolete
  army_thror:       1, # Armies of the Hobbit v2 p84
  arnor:            2, # Armies of Arnor and Angmar: Arnor p10
  azogs_hunters:    3, # Armies of the Hobbit v2 p150
  azogs_legion:     4, # Armies of the Hobbit v2 p146
  barad_dur:        5, # Armies of the Lord of the Rings v2 p202
  dale:             6, # Armies of the Hobbit v2 p94
  desolator_north:  7, # Armies of the Hobbit v2 p158
  dol_guldur:       8, # Armies of the Hobbit v2 p148
  dunharrow:        9, # obsolete
  easterlings:     10, # obsolete
  erebor:          11, # Armies of the Hobbit v2 p88
  fangorn:         12, # Armies of the Lord of the Rings v2 p130
  far_harad:       13, # obsolete
  fellowship:      14, # Armies of the Lord of the Rings v2 p82
  fiefdoms:        15, # obsolete
  goblintown:      16, # Armies of the Hobbit v2 p154
  harad:           17, # Armies of the Lord of the Rings v2 p236
  iron_hills:      18, # Armies of the Hobbit v2 p86
  isengard:        19, # Armies of the Lord of the Rings v2 p226
  khand:           20, # obsolete
  khazad_dum:      21, # obsolete
  laketown:        22, # Armies of the Hobbit v2 p90
  lothlorien:      23, # Armies of the Lord of the Rings v2 p128
  minas_tirith:    24, # Armies of the Lord of the Rings v2 p106
  mirkwood:        25, # obsolete
  misty_mountains: 26, # obsolete
  mordor:          27, # Armies of the Lord of the Rings v2 p210
  moria:           28, # Armies of the Lord of the Rings v2 p234
  numenor:         29, # Armies of the Lord of the Rings v2 p120
  radagast:        30, # Armies of the Hobbit v2 p108
  rangers:         31, # Armies of the Hobbit v2 p102
  rivendell:       32, # Armies of the Lord of the Rings v2 p124 & Hobbit v2 p.98
  rogues:          33, # obsolete
  rohan:           34, # Armies of the Lord of the Rings v2 p90
  shire:           35, # Armies of the Lord of the Rings v2 p84
  survivors:       36, # Armies of the Hobbit v2 p92
  thorins_co:      37, # Armies of the Hobbit v2 p82
  thranduil:       38, # Armies of the Hobbit v2 p100
  trolls:          39, # Armies of the Hobbit v2 p156
  umbar:           40, # Armies of the Lord of the Rings v2 p238
  wanderers:       41, # obsolete
  white_council:   42, # Armies of the Hobbit v2 p112
  wildmen:         43, # obsolete
  beornings:       44, # obsolete
  fornost:         45, # Armies of Arnor and Angmar: Battle of Fornost p11
  arathorn:        46, # Armies of Arnor and Angmar: Arathorn's Stand p12
  witch_king:      47, # Armies of Arnor and Angmar: Host of the Witch King p22
  shadows:         48, # Armies of Arnor and Angmar: Shadows of Angmar p23
  buhrdur:         49, # Armies of Arnor and Angmar: Burhdur's Horde p24
  wolf_angmar:     50, # Armies of Arnor and Angmar: Wolf Pack of Angmar p25
  carn_dum:        51, # Armies of Arnor and Angmar: Army of Carn Dum p26
  road_rivendell:  52, # Armies of the Lord of the Rings v2 p86
  breaking:        53, # Armies of the Lord of the Rings v2 p88
  road_helms:      54, # Armies of the Lord of the Rings v2 p92
  helms_deep:      55, # Armies of the Lord of the Rings v2 p94
  ride_out:        56, # Armies of the Lord of the Rings v2 p96
  riders_eomer:    57, # Armies of the Lord of the Rings v2 p98
  riders_theoden:  58, # Armies of the Lord of the Rings v2 p100
  army_edoras:     59, # Armies of the Lord of the Rings v2 p102
  hornburg:        60, # Armies of the Lord of the Rings v2 p104
  ithilien:        61, # Armies of the Lord of the Rings v2 p108
  reclaim_osg:     62, # Armies of the Lord of the Rings v2 p110
  atop_walls:      63, # Armies of the Lord of the Rings v2 p112
  return_king:     64, # Armies of the Lord of the Rings v2 p114
  defend_pelennor: 65, # Armies of the Lord of the Rings v2 p116
  men_west:        66, # Armies of the Lord of the Rings v2 p118
  lindon:          67, # Armies of the Lord of the Rings v2 p122
  last_alliance:   68, # Armies of the Lord of the Rings v2 p126
  eagles:          69, # Armies of the Lord of the Rings v2 p132
  black_riders:    70, # Armies of the Lord of the Rings v2 p204
  wraiths_wings:   71, # Armies of the Lord of the Rings v2 p206
  army_gothmog:    72, # Armies of the Lord of the Rings v2 p208
  minas_morgul:    73, # Armies of the Lord of the Rings v2 p212
  cirith_ungol:    74, # Armies of the Lord of the Rings v2 p214
  black_gate:      75, # Armies of the Lord of the Rings v2 p216
  white_hand:      76, # Armies of the Lord of the Rings v2 p218
  lurtz_scouts:    77, # Armies of the Lord of the Rings v2 p220
  ugluk_scouts:    78, # Armies of the Lord of the Rings v2 p222
  wolves_isengard: 79, # Armies of the Lord of the Rings v2 p224
  assault_helms:   80, # Armies of the Lord of the Rings v2 p228
  usurpers_edoras: 81, # Armies of the Lord of the Rings v2 p230
  besieger_horn:   82, # Armies of the Lord of the Rings v2 p232
  erebor_dale:     83, # Armies of the Hobbit v2 p96
  battle_5_armies: 84, # Armies of the Hobbit v2 p104
  assault_raven:   85, # Armies of the Hobbit v2 p106
  necromancer:     86  # Armies of the Hobbit v2 p152

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
