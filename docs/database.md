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

## Useful Queries

### Add a new figure pose to the relevent scenarios

As of this writing, the services provide no way to link a new figure being
added to the scenarios in which it should appear other than editing each
scenario one by one.  This is sometimes onerous for frequently-appearing
characters (think Aragorn) and so it's easier just to manipulate the database
directly.

Given the `old_figure_id` is the `id` of an existing [Figure](#figures)
and `new_figure_id` is the `id` of the new [Figure](#figures) being added,
the query to set the new figure's [Role](#roles) is:

```sql
INSERT INTO role_figures (role_id, figure_id)
SELECT role_id, <new_figure_id>
FROM role_figures
WHERE figure_id = <old_figure_id>
```

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

### Character Resource Type

| Value | Location |
|-------|----------|
| 0 | Painting Guide
| 1 | Analysis

### Faction

| Value | Location |
|-------|----------|
| 0 |  Angmar
| 1 |  Army of Thror
| 2 |  Arnor
| 3 |  Azogs Hunters
| 4 |  Azogs Legion
| 5 |  Barad Dur
| 6 |  Garrison of Dale
| 7 |  Desolator of the North
| 8 |  Dark Powers of Dol Guldur
| 9 |  Dead of Dunharrow
| 10 |  Easterlings
| 11 |  Erebor Reclaimed
| 12 |  Fangorn
| 13 |  Far Harad
| 14 |  The Fellowship
| 15 |  Fiefdoms
| 16 |  Goblin-town
| 17 |  THe Serpent Horde
| 18 |  Iron Hills
| 19 |  Isengard
| 20 |  Variags of Khand
| 21 |  Khazad Dûm
| 22 |  Army of Laketown
| 23 |  Lothlórien
| 24 |  Minas Tirith
| 25 |  Dark Denizens of Mirkwood
| 26 |  Misty Mountains
| 27 |  Mordor
| 28 |  Moria
| 29 |  Númenor
| 30 |  Radagast's Alliance
| 31 |  Rangers
| 32 |  Rivendell
| 33 |  Sharkey's Rogues
| 34 |  Rohan
| 35 |  The Shire
| 36 |  Survivors of Lake-town
| 37 |  Thorin's Company
| 38 |  Halls of Thranduil
| 39 |  The Trolls
| 40 |  Corsairs of Umbar
| 41 |  Wanderers in the Wild
| 42 |  White Council
| 43 |  Wildmen of Drúadan
| 44 |  Beornings

### Figure Type

| Value | Location |
|-------|----------|
| 0 | Hero |
| 1 | Warrior |
| 2 | Monster |
| 3 | Sieger | siege weapons & crew |

### Location

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
| 0 |  Source | where the scenario can be found
| 1 |  Video Replay |
| 2 |  Web Replay |
| 3 |  Terrain Building | not currently used
| 4 |   Podcast |
| 5 |  Magazine Replay |

### User Figure Op
| Value | Location | Notes |
|-------|----------|
| 0 | Add Unpainted
| 1 | Remove Unpainted
| 2 | Add Painted |
| 3 | Remove Unpainted
| 4 | Paint | converting unpainted to painted

## Tables

### character_figures (TODO)
### character_resources (TODO)
### characters (TODO)
### faction_figures (TODO)
### figures (TODO)
### news_item

News Items are the mechanism for relaying updates to the site.

| Field | Type |
|-------|------|
| item_text | text
| item_date | date

### role_figures

Role Figures tie the Roles used by scenario to the individual
figures which can be used to represent them.  For warriors, this
is usually a 1:1 relationship, but with heros it is often a 1:many
relationship, as there are numerous Gandalf and Aragorn figures!

| Field | Type | Notes|
|-------|------|-------|
| role_id | int8 | FK to [Roles](#roles)
| figure_id | int8 | FK to [Figures](#figures)

Note that because this table is read-only data, it omits the usual
`inserted_at` and `updated_at` timestamps.

### roles

Roles are "character slots" linking the generic figure name used
in the scenario details to the multiple figure poses which can
be available for a given model.

There's a `roles` row for every participant _type_ in the scenario,
not per figure.  So if a scenario calls for 4 Warriors of Rohan with
bow and 4 Warriors of Rohan with shield, they are represented here by
two rows, one for the bowmen and one for the shieldmen, and not
eight rows.

Roles are scenario-related and hence have slightly different usages
than [characters](#characters).  For example the "Gimli on dead Uruk"
model can be tied to the "Gimli" _Character_, since painting guides
are appropriate to the model.  But you'd never use that figure in a
scenario, so that model would never be tied to a Role.

| Field | Type | Notes|
|-------|------|-------|
| scenario_faction_id | int8 | FK to [scenario_factions](#scenario_factions)`.id`
| amount | int4 | # of this figure type needed
| sort_order | int4 | 1..n
| inserted_at | timestamp |
| updated_at | timestamp |
| name | varchar(255) |

### scenario_factions

Enumerates the basic information for the sides for each of
the [scenarios](#scenarios).

| Field | Type | Notes|
|-------|------|-------|
| faction | int4 | a [Faction](#faction) value
| suggested_points | int4 |
| actual_points | int4 |
| sort_order | int4 | 1,2
| scenario_id | int8 | FK to [scenarios](#scenarios)`.id`
| inserted_at | timestamp
| updated_at | timestamp

There should be two factions per scenario, with `sort_order`
1 and 2, with Good first and then Evil.

This table could theoretically support three or more
-sided games, but the front end makes no provision for that.
I don't think there are any such scenarios anyway.

I thought to use the `faction` field for displaying faction
logos or something, but there are many scenarios (e.g. Battle
of Five Armies & The Black Gate) where there's not just
a single faction per side, so it's really not that useful.

The `suggested_points` and `actual_points` fields aren't
well supported.  I originally thought to include them because
some scenarios have significant mismatches between the actual
combatants and the suggested points value, and also since the
_Return of the King_ journeybook rather irritatingly generally
gives points rather than exact combatants.  But determining and
maintaining those was onerous so I've generally left them as
0s in the database.  (Which is why the front end doesn't
bother showing them.)

### scenario_resources

Records represent a resource for a scenario.

| Field | Type | Notes|
|-------|------|-------|
| scenario_id | int8 | FK to [scenarios](#scenarios)`.id`
| resource_type | | a [Scenario Resource Type](#scenario-resource-type) value
| book | int4 | a [Books](#books) value
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
source directly into the [scenarios](#scenarios) table, which would
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
| location | int4 | a [Location](#location) value |
| inserted_at | timestamp |
| updated_at | timestamp |
| date_month | 1-12 or <=0 if unknown |
| date_day | 1-31 or <=0 if unknown |
| rating | float4 | average rating |
| num_votes | int4 | # of votes which have been cast

Many fields (e.g. `name`, `blurb`) here are nullable but probably shouldn't be.

`rating` and `num_votes` are rolled up from the [user_scenarios](#user-scenarios) table and
are calculated by the application when a rating is made.

`num_votes` is the number of `user_scenario` records for the given scenario
which have a rating > 0. `rating` is then the average of those ratings.

### schema_migrations

Standard ecto migrations table.

| Value | Type |
|-------|------|
| version | int8 |
| inserted_at | timestamp |

### sessions

Associates access tokens and users.

| Value | Type | Notes |
|-------|------|-------|
| token | varchar(255) |
| user_id | int8 | FK to [users](#users).id
| inserted_at | timestamp |
| updated_at | timestamp

When a user logs in, a randomized token is generated and inserted here
and the service returns that token to as a cookie.
The token then can be submitted as an authorization token on subsequent
requests so the service calls can determine who the user is.

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