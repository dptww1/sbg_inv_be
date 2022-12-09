# Database Schema and Notes

This document outlines some notes for myself or those trying to understand
the system at a deeper level.

There are inconsistencies with singular versus plural names, which is
unfortunate but difficult at this point to remediate.  Please remember that
this is a one-man, spare-time project worked on intermittently over the
course of some years.  So, unfortunately, inconsistencies such as this
aren't rare.

Ecto, the database layer that the project uses, enforces an `id` field
which I omit in the tables below to save space.

## Enumerated Values

### Books

| Value | Book |
|-------|------|
|  0 | Battle of the Five Armies (2014)
|  1 | Battle of the Pelennor Fields (2004)
|  2 | The Desolation of Smaug (2013)
|  3 | The Fall of the Necromancer (2006)
|  4 | Fellowship of the Ring (2001)
|  5 | Fellowship of the Ring Journeybook (2005)
|  6 | Free Peoples (2011)
|  7 | Fallen Realms (2011)
|  8 | Gondor in Flames (2007)
|  9 | Escape from Goblintown (2012)
| 10 | Harad (2007)
| 11 | The Hobbit: An Unexpected Journey (2012)
| 12 | Khazad-dûm (2007)
| 13 | Kingdoms of Men (2011)
| 14 | Moria & Angmar (2011)
| 15 | Mordor (2011)
| 16 | Mordor (2007)
| 17 | The Ruin of Arnor (2006)
| 18 | Return of the King (2003)
| 19 | Return of the King Journeybook (2007)
| 20 | Shadow & Flame (2003)
| 21 | SBG Magazine
| 22 | A Shadow in the East (2005)
| 23 | Siege of Gondor (2004)
| 24 | The Scouring of the Shire (2004)
| 25 | There and Back Again (2016)
| 26 | The Two Towers (2002)
| 27 | The Two Towers Journeybook (2006)
| 28 | Battle of the Pelennor Fields (2018)
| 29 | Armies of the Lord of the Rings (2018)
| 30 | Armies of the Hobbit (2018)
| 31 | Gondor at War (2019)
| 32 | Battle Games in Middle Earth
| 33 | Scouring of the Shire (2019)
| 34 | War in Rohan (2019)
| 35 | Quest of the Ringbearer (2020)
| 36 | Fall of the Necromancer (2021)
| 37 | Defence of the North (2022)
| 38 | Battle of Osgiliath (2022)

### Locations

| Value | Location |
|-------|----------|
| 0 | Amon Hen |
| 1 | Arnor |
| 2 | Dale |
| 3 | Dol Guldur |
| 4 | Erebor |
| 5 | Eriador |
| 6 | Fangorn |
| 7 | Fornost |
| 8 | Goblintown |
| 9 | Gondor |
| 10 | Harad |
| 11 | Harondor |
| 12 | Helms Deep |
| 13 | Isengard |
| 14 | Ithilien |
| 15 | Laketown |
| 16 | Lothlorien |
| 17 | Minas Morgul |
| 18 | Minas Tirith |
| 19 | Mirkwood |
| 20 | Mordor |
| 21 | Moria |
| 22 | Morannon |
| 23 | Osgiliath |
| 24 | Rhovanion |
| 25 | Rhun |
| 26 | Rohan |
| 27 | The Shire |
| 28 | Weathertop |
| 29 | Orthanc |

### Scenario Resource Type

| Value | Type | Notes |
|-------|------|-------|
| 0 |  source | where the scenario can be found
| 1 |  video_replay |
| 2 |  web_replay |
| 3 |  terrain_building | not currently used
| 4 |   podcast |
| 5 |  magazine_replay |

## Tables

### character_figures (TODO)
### character_resources (TODO)
### characters (TODO)
### faction_figures (TODO)
### figures (TODO)
### news_item (TODO)
### role_figures (TODO)
### roles (TODO)
### scenario_factions (TODO)
### scenario_resources (TODO)

Records represent a resource for a scenario.

| Field | Type | Notes|
|-------|------|-------|
| scenario_id | int8 | FK to `scenarios.is` |
| resource_type | | a [Scenario Resource Type] value
| book | int4 | a [Books] value
| page | int4 |
| url | text |
| notes | text | unused |
| sort_order | int4 | 1..n
| inserted_at | timestamp
| updated_at | timestamp
| title | varchar(255) | display name for this resource
| issue | text |

The fields here are all nullable and at minimum the
`scenario_id` and `resource_type` should not be.

This table is effectively a union of print and online types.
`title` is meant to be used for either, although arguably it
shouldn't have been used for print materials, since the `book`
attribute describes the title.

`issue` might at first seem like it should be numeric, but
making it textual means it can handle things like "Summer 2018".
It could be `varchar(255)` instead of `text`, though.

It would probably have been better to bake the scenario
source directly into the [scenarios] table, which would
simplify searching by book.

### scenarios

Records represent a single scenario.

| Field | Type | Notes |
|-------|------|-------|
| name | varchar2(255) | |
| blurb | text | short explanation what the scenario represents |
| date_age | int4 | 1..4 for First Age ... Fourth Age |
| date_year | int4 | year within age |
| size | int4 | # of models used in the scenario |
| map_width | int4 | in inches |
| map_height | int4 | in inches |
| location | int4 | a [Locations] value |
| inserted_at | timestamp |
| updated_at | timestamp |
| date_month | 1-12 or <=0 if unknown |
| date_day | 1-31 or <=0 if unknown |
| rating | float4 | average rating |
| num_votes | int4 | # of votes which have been cast

Many fields (e.g. `name`, `blurb`) here are nullable but probably shouldn't be.

`rating` and `num_votes` are rolled up from the [user_scenarios] table and
are calculated by the application when a rating is made.

`num_votes` is the number of `user_scenario` records for the given scenario
which have a rating > 0. `rating` is then the average of those ratings.

### schema_migrations  (TODO)
### sessions (TODO)
### user_figure_history (TODO)
### user_figures (TODO)
### user_scenarios

Records represent the user-specific part of a scenario. There's a many-to-many
relationship between this table and the `scenarios` and `users` tables. But
there should be only one record per (user, scenario) combination.

| Field | Type | Notes |
|-------|------|-------|
| user_id | int4 | FK to `users.id` |
| rating | int4 | 1-5, or 0 if unrated |
| owned | int4 | how many of the needed models for the scenario the user owns |
| painted | int4 | how many of the needed models for the scenario the user has painted |
| scenario_id | int8 | FK to `scenarios.id` |
| inserted_at | timestamp
| updated_at | timestamp

`painted` should always be <= `owned`, which should in turn be <= `scenarios.size` for
the given scenario.  These rollup values are computed by the application whenever
the user buys, sells, or paints a figure.

### users

Records represent users.

| Field | Type | Notes |
|-------|------|-------|
| name | varchar(255) | NOT NULL |
| email | varchar(255) | NOT NULL |
| password_hash | varchar(255) | |
| inserted_at | timestamp | |
| updated_at | timestamp | |
| is_admin | bool | |

`name` is never actually used in the system, but is there so at least theoretically
I have a name if I need to contact folks in case of emergency.  Plus I find it
slightly amusing to see the variety of full names, first names, and aliases
which users are signing up with.

`is_admin` is required to use any of the admin-only services.  There's no way
to set this field for users other than directly editing the database.
