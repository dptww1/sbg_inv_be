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

## Table of Contents

* [Useful Queries](#useful-queries)
  * [Add a new figure pose to the relevant scenarios](#add-a-new-figure-pose-to-the-relevant-scenarios)
  * [Detect scenarios with incorrect sizes](#detect-scenarios-with-incorrect-size-rollups)
* [Enumerated Values](#enumerated-values)
  * [Books](#books)
  * [Character Resource Type](#character-resource-type)
  * [Faction](#faction)
  * [Figure Type](#figure-type)
  * [Location](#location)
  * [Scenario Resource Type](#scenario-resource-type)
  * [User Figure Op](#user-figure-op)
* [Tables](#tables)
  * [character_figures](#character_figures)
  * [character_resources](#character_resources)
  * [characters](#characters)
  * [faction_figures](#faction_figures)
  * [figures](#figures)
  * [news_item](#news_item)
  * [role_figures](#role_figures)
  * [roles](#roles)
  * [schema_migrations](#schema-migrations)
  * [scenario_factions](#scenario_factions)
  * [scenario_resources](#scenario_resources)
  * [scenarios](#scenarios)
  * [sessions](#sessions)
  * [user_figure_history](#user_figure_history)
  * [user_figures](#user_figures)
  * [user_scenarios](#user_scenarios)
  * [users](#users)

## Useful Queries

### Add a new figure pose to the relevant scenarios

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

### Detect scenarios with incorrect size rollups

For the pie charts on the main scenario list to be accurate, the `size` field
in the [Scenarios](#scenarios) table must exactly match the sum of the amounts
in the [Role](#roles)s for the that scenario.

The services are supposed to ensure that this is true, but they sometimes seem
to get out of sync. So if the pie charts are wonky, run this query to see if
there are mismatches in the `size` field:

```sql
SELECT s.id, s.name, s.size, SUM(r.amount)
FROM scenarios s
INNER JOIN scenario_factions sf ON s.id = sf.scenario_id
INNER JOIN roles r ON sf.id = r.scenario_faction_id
GROUP BY s.id
HAVING s.size <> SUM(r.amount)
ORDER BY s.name;
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

Factions are groups of characters/figures which can be mustered as part of the
same army list.

In the database, the values below are what is actually stored.  Often the services
use the strings instead.

| Value | Faction | String
|-------|----------|--------
| 0 |  Angmar | `"angmar"`
| 1 |  Army of Thror| `"army_thror"`
| 2 |  Arnor | `"arnor"`
| 3 |  Azogs Hunters | `"azogs_hunters"`
| 4 |  Azogs Legion | `"azogs_legion"`
| 5 |  Barad Dur | `"barad_dur"`
| 6 |  Garrison of Dale | `"dale"`
| 7 |  Desolator of the North | `"desolator_north"`
| 8 |  Dark Powers of Dol Guldur | `"dol_guldur"`
| 9 |  Dead of Dunharrow | `"dunharrow"`
| 10 |  Easterlings | `"easterlings"`
| 11 |  Erebor Reclaimed | `"erebor"`
| 12 |  Fangorn | `"fangorn"`
| 13 |  Far Harad | `"far_harad"`
| 14 |  The Fellowship | `"fellowship"`
| 15 |  Fiefdoms | `"fiefdoms"`
| 16 |  Goblin-town | `"goblintown"`
| 17 |  The Serpent Horde | `"harad"`
| 18 |  Iron Hills | `"iron_hills"`
| 19 |  Isengard | `"isengard"`
| 20 |  Variags of Khand | `"khand"`
| 21 |  Khazad Dûm | `"khazad_dum"`
| 22 |  Army of Laketown | `"laketown"`
| 23 |  Lothlórien | `"lothlorien"`
| 24 |  Minas Tirith | `"minas_tirith"`
| 25 |  Dark Denizens of Mirkwood | `"mirkwood"`
| 26 |  Misty Mountains | `"misty_mountains"`
| 27 |  Mordor | `"mordor"`
| 28 |  Moria | `"moria"`
| 29 |  Númenor | `"numenor"`
| 30 |  Radagast's Alliance | `"radagast"`
| 31 |  Rangers | `"rangers"`
| 32 |  Rivendell | `"rivendell"`
| 33 |  Sharkey's Rogues | `"rogues"`
| 34 |  Rohan | `"rohan"`
| 35 |  The Shire | `"shire"`
| 36 |  Survivors of Lake-town | `"survivors"`
| 37 |  Thorin's Company | `"thorins_co"`
| 38 |  Halls of Thranduil | `"thranduil"`
| 39 |  The Trolls | `"trolls"`
| 40 |  Corsairs of Umbar | `"umbar"`
| 41 |  Wanderers in the Wild | `"wanderers"`
| 42 |  White Council | `"white_council"`
| 43 |  Wildmen of Drúadan | `"wildmen"`
| 44 |  Beornings | `"beornings"`

### Figure Type

In the database, the values below are what is actually stored. Often the services
use the strings instead.

| Value | Location | String | Notes |
|-------|----------|-------|--------|
| 0 | Hero | `"hero"` |
| 1 | Warrior | `"warrior"` |
| 2 | Monster | `"monster"` |
| 3 | Sieger | `"sieger"` | siege weapons & crew |

### Location

| Value | Location | String |
|-------|----------|--------|
| 0 | Amon Hen | `"amon_hen"` |
| 1 | Arnor | `"arnor"` |
| 2 | Dale | `"dale"` |
| 3 | Dol Guldur | `"dol_guldur"` |
| 4 | Erebor | `"erebor"` |
| 5 | Eriador | `"eriador"` |
| 6 | Fangorn | `"fangorn"` |
| 7 | Fornost | `"fornost"` |
| 8 | Goblintown | `"goblintown"` |
| 9 | Gondor | `"gondor"` |
| 10 | Harad | `"harad"` |
| 11 | Harondor | `"harondor"` |
| 12 | Helms Deep | `"helms_deep"` |
| 13 | Isengard | `"isengard"` |
| 14 | Ithilien | `"ithilien"` |
| 15 | Laketown | `"laketown"` |
| 16 | Lothlorien | `"lothlorien"` |
| 17 | Minas Morgul | `"minas_morgul"` |
| 18 | Minas Tirith | `"minas_tirith"` |
| 19 | Mirkwood | `"mirkwood"` |
| 20 | Mordor | `"mordor"` |
| 21 | Moria | `"moria"` |
| 22 | Morannon | `"morannon"` |
| 23 | Osgiliath | `"osgiliath"` |
| 24 | Rhovanion | `"rhovanion"` |
| 25 | Rhun | `"rhun"` |
| 26 | Rohan | `"rohan"` |
| 27 | The Shire | `"the_shire"` |
| 28 | Weathertop | `"weathertop"` |
| 29 | Orthanc | `"orthanc"` |

### Scenario Resource Type

In the database, the values below are what is actually stored. Often the services
use the strings instead.

| Value | Type | String | Notes |
|-------|------|-------|
| 0 |  Source | `"source"` | where the scenario can be found
| 1 |  Video Replay | `"video_replay"` |
| 2 |  Web Replay | `"web_replay"` |
| 3 |  Terrain Building | `"terrain_building"` | not currently used
| 4 |   Podcast | `"podcast"` |
| 5 |  Magazine Replay | `"magazine_replay"` |

### User Figure Op

These values represent the things that a user can do with a figure.
In the database, the values below are what is actually stored. Often the services
use the strings instead.

| Value | Operation | String |Notes |
|-------|----------|-------|------|
| 0 | Add Unpainted | `"buy_unpainted"` |
| 1 | Remove Unpainted | `"sell_unpainted"` |
| 2 | Add Painted | `"buy_painted"` |
| 3 | Remove Painted | `"sell_painted"` |
| 4 | Paint | `"paint"` | converting unpainted to painted |

## Tables

### character_figures

Associates [characters](#characters) to [figures](#figures).

| Field | Type | Notes |
|-------|------|--------
| character_id | int8 | FK to [characters](#characters) |
| figure_id | int8 | FK to [figures](#figures) |

### character_resources

Associates [characters](#characters) to their resources.

| Field | Type | Notes |
|-------|------|--------
| character_id | int4 | FK to [characters](#characters) |
| url | text | URL of resource |
| book | int4 | one of the [Books](#books) |
| page | int4 | page in the book |
| type | int4 | a [Character Resource Type](#character-resource-type) |
| issue | text | magazine issue ("2", "Summer", etc.) |
| inserted_at | timestamp |
| updated_at | timestamp |
| title | text | display name for this resource |

For online resources, only `url` and `title` are needed.

For printed resources, `title`, `book`, and `page` are required.

### characters

Characters are pose- and equipment-independent individuals or types.
So: Aragorn, Orc, Warrior of Minas Tirith.

This is useful because the painting guides and other [character_resources](#character_resources)
are generally applicable to a figure regardless of pose or equipment, or whether they
are used in any scenarios (and so compare with [roles](#roles)).

The services label the unique [Figures](#figures) as "Characters" but that is for
labeling purposes and has nothing to do with this table.

| Field | Type | Notes |
|-------|------|--------
| name | text |
| book | int4 | the [Books](#books) with the character's stats |
| page | int4 | the page within the book |
| inserted_at | timestamp |
| updated_at | timestamp |
| faction | int4 | a [Faction](#faction) |
| num_analyses | int4 | rollup of the analysis [character_resources](#character_resources) for this character |
| num_painting_guides | int4 | rollup of the guides [character_resources](#character_resources) for this character |

### faction_figures

Links [Figures](#figures) to their factions.

| Field | Type | Notes |
|-------|------|--------
| faction_id | int4 | a [Faction](#faction)
| figure_id | int4 | FK to [Figures](#figures)

### figures

Figures are the actual models made by Games Workshop.

Unique characters get a row for each of their poses: Aragorn (Fellowship), Aragorn (Helm's Deep), etc.

Other figure types get a row for each equipment configuration: Orc with shield, Orc with bow, etc.

| Field | Type | Notes |
|-------|------|--------
| name | varchar(255) |
| type | int4 | a [Figure Type](#figure-type) value
| unique | bool | `true` for unique characters (Aragorn, Smaug, etc)
| inserted_at | timestamp |
| updated_at | timestamp |
| plural_name | varchar(255) | pluralized `name` field; can be `null` for unique figures
| slug | varchar(255) | unique URL path part for this figure

The `plural_name` field is needed because it seems easier to have this field than to
do pluralization mechanically.

The `slug` is currently used as a path for the silhouettes shown in the front end when the
user mouses over a figure name on the figure list screen. The slugs don't include the image
extension so that they can also be used in the future for other purposes.  Since only
characters currently have silhouettes, only characters currently have slugs.

The silhouettes themselves are served by the front end despite the image paths being controlled
by the back end.  This is awkward, but does have the advantage that adding a silhouette requires
no updates to the back end, only the front end and the database.

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

### schema_migrations

Standard ecto migrations table.

| Value | Type |
|-------|------|
| version | int8 |
| inserted_at | timestamp |

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

### user_figure_history

Records track user activity over time.  The [user_figures](#user_figures) table
records the user's current inventory; this table tells us how he or she got there.

| Field | Type | Notes |
|-------|------|-------|
| user_id | int8 | FK to [users](#users).id |
| figure_id | int8 | FK to [figures](#figures).id |
| op | int4 | a [User Figure Op](#user-figure-op) value determining exactly what the user did
| amount | int4 | how many of the given figures the user bought/sold/painted at one point in time
| new_owned | int4 | the user's inventory of the given figure after the operation
| new_painted| int4 | the user's painted inventory of the given figure after the operation
| op_date | date(0) | when the operation occurred
| notes | text | optional notes about the operation the user cares to add
| inserted_at | timestamp
| updated_at | timestamp

When a `user_figure_history` record is edited or deleted, only the given record is affected.
In other words, no recalculation of the `new_owned` and `new_painted` fields in the other
`user_figure_history` records for the (user, figure) combination is performed, and so it's
possible for those fields to become inaccurate.

### user_figures

Records associate [users](#users) with [figures](#figures) in a many-to-many
relationship.  There should be only one record per (user, figure) combination.

| Field | Type | Notes |
|-------|------|-------|
| user_id | int8 | FK to [users](#users).id |
| owned | int4 | # of models of the given figure owned by the user
| painted | int4 | # of models of the given figure painted by the user
| figure_id | int8 | FK to [figures](#figures).id |
| inserted_at | timestamp
| updated_at | timestamp

### user_scenarios

Records represent the user-specific part of a scenario. There's a many-to-many
relationship between this table and the `scenarios` and `users` tables. But
there should be only one record per (user, scenario) combination.

| Field | Type | Notes |
|-------|------|-------|
| user_id | int4 | FK to [users](#users).id |
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
