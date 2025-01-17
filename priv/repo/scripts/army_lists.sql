/* Initial population of the army_lists and army_lists_sources table.
   Doesn't not account for now-obsolete lists (e.g. Far Harad). */
delete from army_lists;
insert into army_lists (id, name, abbrev, alignment, inserted_at, updated_at) values
(2, 'Arnor', 'arnor', 0, current_timestamp, current_timestamp),
(45, 'Battle of Fornost', 'fornost', 0, current_timestamp, current_timestamp),
(46, 'Arathorn''s Stand', 'arathorn', 0, current_timestamp, current_timestamp),
(47, 'Host of the Witch-King', 'witch_king', 1, current_timestamp, current_timestamp),
(48, 'Shadows of Angmar', 'shadows', 1, current_timestamp, current_timestamp),
(49, 'Buhrdûr''s Horde', 'burhdur', 1, current_timestamp, current_timestamp),
(50, 'Wolf Pack of Angmar', 'wolf_angmar', 1, current_timestamp, current_timestamp),
(51, 'Army of Carn Dûm', 'carn_dum', 1, current_timestamp, current_timestamp),
(14, 'The Fellowship', 'fellowship', 0, current_timestamp, current_timestamp),
(35, 'The Shire', 'shire', 0, current_timestamp, current_timestamp),
(52, 'Road to Rivendell', 'road_rivendell', 0, current_timestamp, current_timestamp),
(53, 'Breaking of the Fellowship', 'breaking', 0, current_timestamp, current_timestamp),
(34, 'Kingdom of Rohan', 'rohan', 0, current_timestamp, current_timestamp),
(54, 'Road to Helm''s Deep', 'road_helms', 0, current_timestamp, current_timestamp),
(55, 'Defenders of Helm''s Deep', 'helms_deep', 0, current_timestamp, current_timestamp),
(56, 'Ride Out', 'ride_out', 0, current_timestamp, current_timestamp),
(57, 'Riders of Éomer', 'riders_eomer', 0, current_timestamp, current_timestamp),
(58, 'Riders of Théodenm', 'riders_theoden', 0, current_timestamp, current_timestamp),
(59, 'Army of Edoras', 'army_edoras', 0, current_timestamp, current_timestamp),
(60, 'Defenders of the Hornburg', 'hornburg', 0, current_timestamp, current_timestamp),
(24, 'Minas Tirith', 'minas_tirith', 0, current_timestamp, current_timestamp),
(61, 'Garrison of Ithilien', 'ithilien', 0, current_timestamp, current_timestamp),
(62, 'Reclamation of Osgiliath', 'reclaim_osg', 0, current_timestamp, current_timestamp),
(63, 'Atop the Walls', 'atop_walls', 0, current_timestamp, current_timestamp),
(64, 'Return of the King', 'return_king', 0, current_timestamp, current_timestamp),
(65, 'Defenders of the Pelennor', 'defend_pelennor', 0, current_timestamp, current_timestamp),
(66, 'Men of the West', 'men_west', 0, current_timestamp, current_timestamp),
(29, 'Numenor', 'numenor', 0, current_timestamp, current_timestamp),
(67, 'Lindon', 'lindon', 0, current_timestamp, current_timestamp),
(32, 'Rivendell', 'rivendell', 0, current_timestamp, current_timestamp),
(68, 'The Last Alliance', 'last_alliance', 0, current_timestamp, current_timestamp),
(23, 'Lothlórien', 'lothlorien', 0, current_timestamp, current_timestamp),
(12, 'Fangorn', 'fangorn', 0, current_timestamp, current_timestamp),
(69, 'The Eagles', 'eagles', 0, current_timestamp, current_timestamp),
(5, 'Barad-dûr', 'barad_dur', 1, current_timestamp, current_timestamp),
(70, 'The Black Riders', 'black_riders', 1, current_timestamp, current_timestamp),
(71, 'Wraiths on Wings', 'wraiths_wings', 1, current_timestamp, current_timestamp),
(72, 'Army of Gothmog', 'army_gothmog', 1, current_timestamp, current_timestamp),
(27, 'Legions of Mordor', 'mordor', 1, current_timestamp, current_timestamp),
(73, 'Minas Morgul', 'minas_morgul', 1, current_timestamp, current_timestamp),
(74, 'Cirith Ungol', 'cirith_ungol', 1, current_timestamp, current_timestamp),
(75, 'The Black Gate', 'black_gate', 1, current_timestamp, current_timestamp),
(76, 'Army of the White Hand', 'white_hand', 1, current_timestamp, current_timestamp),
(77, 'Lurtz''s Scouts', 'lurtz_scouts', 1, current_timestamp, current_timestamp),
(78, 'Uglúk''s Scouts', 'ugluk_scouts', 1, current_timestamp, current_timestamp),
(79, 'Wolves of Isengard', 'wolves_isengard', 1, current_timestamp, current_timestamp),
(19, 'Muster of Isengard', 'isengard', 1, current_timestamp, current_timestamp),
(80, 'Assault on Helm''s Deep', 'assault_helms', 1, current_timestamp, current_timestamp),
(81, 'Usurpers of Edoras', 'usurpers_edoras', 1, current_timestamp, current_timestamp),
(82, 'Besiegers of the Hornburg', 'besieger_horn', 1, current_timestamp, current_timestamp),
(28, 'Depths of Moria', 'moria', 1, current_timestamp, current_timestamp),
(17, 'Harad', 'harad', 1, current_timestamp, current_timestamp),
(40, 'Corsair Fleets', 'umbar', 1, current_timestamp, current_timestamp),
(37, 'Thorin''s Company', 'thorins_co', 0, current_timestamp, current_timestamp),
(1, 'Army of Thrór', 'army_thror', 0, current_timestamp, current_timestamp),
(18, 'The Iron Hills', 'iron_hills', 0, current_timestamp, current_timestamp),
(11, 'Erebor Reclaimed', 'erebor', 0, current_timestamp, current_timestamp),
(22, 'Army of Laketown', 'laketown', 0, current_timestamp, current_timestamp),
(36, 'Survivors of Laketown', 'survivors', 0, current_timestamp, current_timestamp),
(6, 'Garrison of Dale', 'dale', 0, current_timestamp, current_timestamp),
(83, 'Erebor & Dale', 'erebor_dale', 0, current_timestamp, current_timestamp),
(38, 'Halls of Thranduil', 'thranduil', 0, current_timestamp, current_timestamp),
(31, 'Rangers of Mirkwood', 'rangers', 0, current_timestamp, current_timestamp),
(84, 'The Battle of Five Armies', 'battle_5_armies', 0, current_timestamp, current_timestamp),
(85, 'Assault on Ravenhill', 'assault_raven', 0, current_timestamp, current_timestamp),
(30, 'Radagast''s Alliance', 'radagast', 0, current_timestamp, current_timestamp),
(42, 'The White Council', 'white_council', 0, current_timestamp, current_timestamp),
(4, 'Army of Gundabad', 'azogs_legion', 1, current_timestamp, current_timestamp),
(8, 'Pits of Dol Guldur', 'dol_guldur', 1, current_timestamp, current_timestamp),
(3, 'Azog''s Hunters', 'azogs_hunters', 1, current_timestamp, current_timestamp),
(86, 'Rise of the Necromancer', 'necromancer', 1, current_timestamp, current_timestamp),
(16, 'Goblin-town', 'goblintown', 1, current_timestamp, current_timestamp),
(39, 'The Three Trolls', 'trolls', 1, current_timestamp, current_timestamp),
(7, 'Desolator of the North', 'desolator_north', 1, current_timestamp, current_timestamp);
select setval('army_lists_id_seq', (select max(id) from army_lists));

insert into army_lists_sources (army_list_id, book, page, inserted_at, updated_at) values
(2, 43, 10, current_timestamp, current_timestamp),
(45, 43, 11, current_timestamp, current_timestamp),
(46, 43, 12, current_timestamp, current_timestamp),
(47, 43, 22, current_timestamp, current_timestamp),
(48, 43, 23, current_timestamp, current_timestamp),
(49, 43, 24, current_timestamp, current_timestamp),
(50, 43, 25, current_timestamp, current_timestamp),
(51, 43, 26, current_timestamp, current_timestamp),
(14, 41, 82, current_timestamp, current_timestamp),
(35, 41, 84, current_timestamp, current_timestamp),
(52, 41, 86, current_timestamp, current_timestamp),
(53, 41, 88, current_timestamp, current_timestamp),
(34, 41, 90, current_timestamp, current_timestamp),
(54, 41, 92, current_timestamp, current_timestamp),
(55, 41, 94, current_timestamp, current_timestamp),
(56, 41, 96, current_timestamp, current_timestamp),
(57, 41, 98, current_timestamp, current_timestamp),
(58, 41, 100, current_timestamp, current_timestamp),
(59, 41, 102, current_timestamp, current_timestamp),
(60, 41, 104, current_timestamp, current_timestamp),
(24, 41, 106, current_timestamp, current_timestamp),
(61, 41, 108, current_timestamp, current_timestamp),
(62, 41, 110, current_timestamp, current_timestamp),
(63, 41, 112, current_timestamp, current_timestamp),
(64, 41, 114, current_timestamp, current_timestamp),
(65, 41, 116, current_timestamp, current_timestamp),
(66, 41, 118, current_timestamp, current_timestamp),
(29, 41, 120, current_timestamp, current_timestamp),
(67, 41, 122, current_timestamp, current_timestamp),
(32, 41, 124, current_timestamp, current_timestamp),
(68, 41, 126, current_timestamp, current_timestamp),
(23, 41, 128, current_timestamp, current_timestamp),
(12, 41, 130, current_timestamp, current_timestamp),
(69, 41, 132, current_timestamp, current_timestamp),
(5, 41, 202, current_timestamp, current_timestamp),
(70, 41, 204, current_timestamp, current_timestamp),
(71, 41, 206, current_timestamp, current_timestamp),
(72, 41, 208, current_timestamp, current_timestamp),
(27, 41, 210, current_timestamp, current_timestamp),
(73, 41, 212, current_timestamp, current_timestamp),
(74, 41, 214, current_timestamp, current_timestamp),
(75, 41, 216, current_timestamp, current_timestamp),
(76, 41, 218, current_timestamp, current_timestamp),
(77, 41, 220, current_timestamp, current_timestamp),
(78, 41, 222, current_timestamp, current_timestamp),
(79, 41, 224, current_timestamp, current_timestamp),
(19, 41, 226, current_timestamp, current_timestamp),
(80, 41, 228, current_timestamp, current_timestamp),
(81, 41, 230, current_timestamp, current_timestamp),
(82, 41, 232, current_timestamp, current_timestamp),
(28, 41, 234, current_timestamp, current_timestamp),
(17, 41, 236, current_timestamp, current_timestamp),
(40, 41, 238, current_timestamp, current_timestamp),
(37, 42, 82, current_timestamp, current_timestamp),
(1, 42, 84, current_timestamp, current_timestamp),
(18, 42, 86, current_timestamp, current_timestamp),
(11, 42, 88, current_timestamp, current_timestamp),
(22, 42, 90, current_timestamp, current_timestamp),
(36, 42, 92, current_timestamp, current_timestamp),
(6, 42, 94, current_timestamp, current_timestamp),
(83, 42, 96, current_timestamp, current_timestamp),
(32, 42, 98, current_timestamp, current_timestamp),
(38, 42, 100, current_timestamp, current_timestamp),
(31, 42, 102, current_timestamp, current_timestamp),
(84, 42, 104, current_timestamp, current_timestamp),
(85, 42, 106, current_timestamp, current_timestamp),
(30, 42, 108, current_timestamp, current_timestamp),
(42, 42, 110, current_timestamp, current_timestamp),
(4, 42, 146, current_timestamp, current_timestamp),
(8, 42, 148, current_timestamp, current_timestamp),
(3, 42, 150, current_timestamp, current_timestamp),
(86, 42, 152, current_timestamp, current_timestamp),
(16, 42, 154, current_timestamp, current_timestamp),
(39, 42, 156, current_timestamp, current_timestamp),
(7, 42, 158, current_timestamp, current_timestamp);
