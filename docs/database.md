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

### Locations

| Value | Location |
|-------|----------|
|  Amon Hen |      0 |
|  Arnor |         1 |
|  Dale |          2 |
|  Dol Guldur |    3 |
|  Erebor |        4 |
|  Eriador |       5 |
|  Fangorn |       6 |
|  Fornost |       7 |
|  Goblintown |    8 |
|  Gondor |        9 |
|  Harad |        10 |
|  Harondor |     11 |
|  Helms Deep |   12 |
|  Isengard |     13 |
|  Ithilien |     14 |
|  Laketown |     15 |
|  Lothlorien |   16 |
|  Minas Morgul | 17 |
|  Minas Tirith | 18 |
|  Mirkwood |     19 |
|  Mordor |       20 |
|  Moria |        21 |
|  Morannon |     22 |
|  Osgiliath |    23 |
|  Rhovanion |    24 |
|  Rhun |         25 |
|  Rohan |        26 |
|  The Shire |    27 |
|  Weathertop |   28 |
|  Orthanc |      29 |

## Tables

### character_figures
### character_resources
### characters
### faction_figures
### figures
### news_item
### role_figures
### roles
### scenario_factions
### scenario_resources
### scenarios

Records represent a single scenario

| Field | Type | Notes |
| name | varchar2(255) | |
| blurb | text | short explanation what the scenario represents |
| date_age | int4 | 1..4 for First Age ... Fourth Age |
| date_year | int4 | year within age |
| size | int4 | # of models used in the scenario |
| map_width | int4 | in inches |
| map_height | int4 | in inches |
| location | int4 | a [Location] value |
| inserted_at | timestamp |
| updated_at | timestamp |
| date_month | 1-12 or <=0 if unknown |
| date_day | 1-31 or <=0 if unknown |
| rating | float4 | average rating |
| num_votes | int4 | # of votes which have been cast

Many fields (e.g. `name`, `blurb`) here are nullable but probably shouldn't be.

`rating` and `num_votes` are rolled up from the [user_scenarios] table.

`num_votes` is the number of `user_scenario` records for the given scenario
which have a rating > 0. `rating` is then the average of those ratings.

### schema_migrations
### sessions
### user_figure_history
### user_figures
### user_scenarios
### users

Records represent users.

| Field | Type | Notes |
| name | varchar(255) | NOT NULL |
| email | varchar(255) | NOT NULL |
| password_hash | varchar(255) | |
| inserted_at | timestamp | |
| updated_at | timestamp | |
| is_admin | bool | |

`name` is never actually used in the system, but there so at least theoretically
I have a name if I need to contact folks in case of emergency.  Plus I find it
slightly amusing to see the variety of full names, first names, and aliases
which users are signing up with.

`is_admin` is required to use any of the admin-only services.  There's no way
to set this field for users other than directly editing the database.