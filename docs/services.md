# Service Calls

## Overview

The document describes the SBG Inventory HTTP service calls.  The
[front end](https://github.com/dptww1/sbg_inv_fe) is responsible for
the user interface but all the real work happens in the back end using
these service calls.

The services are written in [Elixir](https://elixir-lang.org/), using the
[Phoenix framework](https://www.phoenixframework.org/).  URLs follow
standard Phoenix conventions, so path parts starting with a colon, such as
`:id`, indicate parameters rather than literal strings.

Request and response payloads are in standard JSON format. Clients should be
sure to send the `Accept: application/json` HTTP header as part of their requests.

The services are hosted at `https://homely-uncomfortable-wreckfish.gigalixirapp.com/api`.
For brevity, I document a service call without that prefix, so the call listed as
`/scenarios/-1/resource` is actually located at
`https://homely-uncomfortable-wreckfish.gigalixirapp.com/api/scenarios/-1/resource`.

The services are primarily designed for user inventory tracking, and so usually require
authenticated credentials.  However some services work whether the caller is authenticated
or not, returning just the user-independent data in the latter case.  When a service
call fails a required authentication check, the HTTP response's status code will be 401
and there will be no return payload.

The JSON return payloads documented here should be accurate as to structure but the
data (figure names, counts, etc.) should be treated as examples and may not
match the actual data on the server.

Many of the app-specific terms and concepts used here are more fully explained in
the [Database Documentation](database.md)

## Table of Contents

* [GET /character/:id](#get-character-id)
* [POST /character](#post-character)
* [PUT /character/:id](#put-character)
* [GET /faction](#get-faction)
* [GET /faction/:id](#get-faction-id)
* [GET /figure/:id](#get-figure-id)
* [POST /figure](#post-figure)
* [PUT /figure/:id](#put-figure-id)
* [GET `/newsitem`](#get-newsitem)
* [POST /newsitem](#post-newsitem)
* [POST /reset-password](#post-reset-password)
* [GET `/search`](#get-search)
* [PUT /scenario-faction/:id](#put-scenario-faction-id)
* [GET /scenarios](#get-scenarios)
* [GET /scenarios/:id](#get-scenarios-id)
* [GET /scenarios/:id/edit](#get-scenarios-id-edit)
* [GET /scenarios/new](#get-scenerios-new)
* [POST /scenarios](#post-scenarios)
* [PUT /scenarios/:id](#put-scenarios-id)
* [GET /scenarios/:scenario_id/resource](#get-scenarios-scenario-id-resource)
* [POST /scenarios/:scenario_id/resource](#post-scenarios-scenario-id-resource)
* [PUT /scenarios/:scenario_id/resource/:id](#put-scenarios-scenario-id-resource-id)
* [POST `/sessions`](#post-sessions)
* [GET `/stats`](#get-stats)
* [POST /userfigure](#post-userfigure)
* [GET `/userhistory`](#get-userhistory)
* [PUT /userhistory/:id](#put-userhistory-id)
* [DELETE /userhistory/:id](#delete-userhistory-id)
* [POST `/userscenarios`](#post-userscenarios)
* [POST `/users`](#post-users)
* [PUT `/users/:id`](#put-users-id)

## Service Call Details
### GET `/character/:id`

- ** Authentication** Admin
- ** Normal HTTP Response Code** 200
- ** Error HTTP Reponse Codes**
    . 401 Authentication error
    . 422 Unknown ID

Retrieves the [character](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#characters)
with the given ID.

Example return payload:

```json
{
  "data": {
    "book": "alotr",
    "faction": "fellowship",
    "figures": [
      {
        "id": 155,
        "name": "Frodo (Barrow Downs)"
      },
      {
        "id": 151,
        "name": "Frodo (Breaking)"
      },
      {
        "id": 157,
        "name": "Frodo (Captured)"
      }
    ],
    "id": 4,
    "name": "Frodo Baggins",
    "num_analyses": 1,
    "num_painting_guides": 2,
    "page": 12,
    "resources": [
      {
        "book": "fotn",
        "issue": "3",
        "page": 23,
        "title": "BSiME",
        "type": "painting_guide"
      },
      {
        "title": "Green Dragon",
        "type": "analysis",
        "url": "http://www.example.com"
      },
      {
        "book": "fotr_jb",
        "page": 12,
        "title": "Planet Mithril\n",
        "type": "painting_guide"
      }
    ]
  }
}
```

### POST `/character`

- **Authentication** Admin
- **Normal HTTP Response Code** 200
- **Error HTTP Response Codes**
    . 401 Unauthorized
    . 422 bad input payload

Creates a new [character](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#characters).

Example input payload:

```json
{
  "character": {
    "name": "Test New Character",
    "faction": "arnor",
    "book": "dotn",
    "page": 9,
    "figures_ids": ["500", "369"],
    "resources": [
      {
        "title": "Sample Painting Guide",
        "book": "",
        "issue": "",
        "page": null,
        "type": "painting_guide",
        "url": "https://www.example.com"
      }
    ]
  }
}
```

Example return payload:

```json
{
  "data": {
    "id": 1234,
    "name": "Test New Character",
    "faction": "arnor",
    "book": "dotn",
    "page": 9,
    "figures": [
      { "id": 500, name: "Gollum (Fish)" },
      { "id": 369, name: "Watcher of Karna" }
    ],
    "num_analyses": 0,
    "num_painting_guides": 1,
    "resources": [
      {
        "title": "Sample Painting Guide",
        "book": "",
        "issue": "",
        "page": null,
        "type": "painting_guide",
        "url": "https://www.example.com"
      }
    ]
  }
}
```

Most of the fields are the same as the input payload.  Note the new fields `"id"`,
`"num_analyses"`, and `"num_painting_guides"`.  The latter two values are calculated by
the service and are just counts of the items in the `"resources"` field.

Also note `"figures"` vs `"figure_ids"` and the different root name, `"character"` vs `"data"`.

### PUT `/character/:id`

- **Authentication** Admin
- **Normal HTTP Response Code** 200
- **Error HTTP Response Codes**
    . 401 Unauthorized
    . 422 bad input payload

Updates an existing [character](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#characters)
with the given `:id`.

Example input payload:

```json
{
  "character": {
    "id": 1234,
    "name": "Test New Character, New Name",
    "faction": "arnor",
    "book": "dotn",
    "page": 9,
    "figure_ids": ["500", "369"],
    "resources": [
      {
        "title": "Sample Painting Guide",
        "book":"",
        "issue":"",
        "page":null,
        "type":"painting_guide",
        "url":"https://www.example.com"
      }
    ]
  }
}
```

Example return payload:

```json
{
  "data": {
    "book": "dotn",
    "faction": "arnor",
    "figures": [
      { "id": 1,"name": "Bûhrdur" },
      { "id": 500,"name": "Gollum (Fish)" },
      { "id":369,"name":"Watcher of Karna" }
    ],
    "id": 1234,
    "name": "Test New Character, New Name",
    "num_analyses": 0,
    "num_painting_guides": 1,
    "page": 9,
    "resources": [
      {
        "title": "Sample Painting Guide",
        "type": "painting_guide",
        "url": "https://www.example.com"
      }
    ]
  }
}
```

Most of the fields are the same as the input payload.  Note the new fields
`"num_analyses"` and `"num_painting_guides"`.  Those two values are calculated by
the service and are just counts of the items in the `"resources"` field.

Also note `"figures"` vs `"figure_ids"` and the different root name, `"character"` vs `"data"`.

### GET `/faction`

- **Authentication** User
- **Normal HTTP Response Code** 200
- **Error HTTP Resonse Code** 401 Unauthorized

Gets a list of factions, with the number of figures the users in that faction.

Example return payload:

```json
{
  "data":
    {
      "thranduil": { "owned": 30, "painted": 24 },
      "rangers": { "owned":30, "painted": 8 },
      "dunharrow": { "owned": 0, "painted": 0 },
      ...
      "Totals": { "owned": 2216, "painted": 1276 }
    }
}
```

The above results are truncated for brevity. The results always have an entry in `"data"`
for each [faction](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#faction)
whether the user has any figures or not in that faction.

The special entry `"Totals"` is the number of figures in the user's entire collection.  Since
figures can belong to multiple factions, the amounts here are *not* a simple sum of the
faction figures!

### GET `/faction/:id`

- **Authentication** User (Optional)
- **Normal HTTP Response Code** 200
- **Error HTTP Response Code** 404 Bad faction id

Gets a list of the figures belonging to the given faction, organized by type.  If the request
has an authenticated user token, the list includes the users collected and painted inventory as well.

Example return payload:

```json
{
  "data": {
    "heroes": [
      {
        "id": 13,
        "name": "Erebor Captain",
        "needed": 2,
        "num_analyses": 0,
        "num_painting_guides": 0,
        "owned": 2,
        "painted": 2,
        "plural_name": "Erebor Captains",
        "slug": null,
        "type": "hero",
        "unique": false
      },
      {
        "id": 14,
        "name": "Grim Hammer Captain",
        "needed": 2,
        "num_analyses": 0,
        "num_painting_guides": 0,
        "owned": 12,
        "painted": 4,
        "plural_name": "Grim Hammer Captains",
        "slug": null,
        "type": "hero",
        "unique": false
      },
      ...
    ],
    "monsters": [],
    "siegers": [],
    "warriors": [
      {
        "id": 19,
        "name": "Grim Hammer Warrior",
        "needed": 36,
        "num_analyses": 0,
        "num_painting_guides": 0,
        "owned": 0,
        "painted": 0,
        "plural_name": "Grim Hammer Warriors",
        "slug": null,
        "type": "warrior",
        "unique": false
      },
      ...
    ]
  }
}
```

The example payload has been severely elided for space purposes.  The `"monsters"` and `"siegers"`
keys are empty here, but would have the same object formats as `"heroes"` and/or `"warriors"`.

Within each figure type, the lists are sorted by the figure name.

The `"owned"` and `"painted"` keys will always be present, even for requests without an authenticated
user token.  (Of course in such cases they are always zero.)

### GET `/figure/:id`

- **Authentication** User (Optional)
- **Normal HTTP Response Code** 200
- **Error HTTP Response Code** 404 Bad figure id

Gets the details for a given figure.  If the request
has an authenticated user token, the details include the users collected and painted inventory as well.

Example return payload:

```json
{
  "data": {
    "factions": [
      "arnor"
    ],
    "history": [
      {
        "amount": 1,
        "figure_id": 21,
        "id": 631,
        "new_owned": 1,
        "new_painted": 1,
        "notes": "",
        "op": "paint",
        "op_date": "2018-12-23"
      },
      {
        "amount": 1,
        "figure_id": 21,
        "id": 11,
        "new_owned": 1,
        "new_painted": 0,
        "notes": "",
        "op": "buy_unpainted",
        "op_date": "2018-12-01"
      }
    ],
    "id": 21,
    "name": "Arvedui, Last King of Arnor",
    "owned": 1,
    "painted": 1,
    "plural_name": null,
    "resources": [
      {
        "book": null,
        "issue": null,
        "page": null,
        "title": "SomePainter",
        "type": "painting_guide",
        "url":"https://www.example.com"
      }
    ],
    "rules": [
      {
        "book": "alotr",
        "faction": "arnor",
        "name": "Arvedui, Last King of Arnor",
        "page": 57
      }
    ],
    "scenarios": [
      {
        "amount": 1,
        "name": "The Fall of Arnor",
        "scenario_id": 253,
        "source": {
          "book": "alotr",
          "date": "2019-01-19",
          "id": 392,
          "issue": null,
          "notes": null,
          "page": 218,
          "resource_type": "source",
          "scenario_id": 253,
          "sort_order": 3,
          "title": "Armies of the Lord of the Rings",
          "url": null
        }
      },
      {
        "amount": 1,
        "name": "Flight Into the North",
        "scenario_id": 146,
        "source": {
          "book": "roa",
          "date": "2019-01-19",
          "id": 229,
          "issue": null,
          "notes": null,
          "page": 52,
          "resource_type": "source",
          "scenario_id": 146,
          "sort_order": 2,
          "title": "The Ruin of Arnor",
          "url": null
        }
      },
      {
        "amount": 1,
        "name": "To Kill a King",
        "scenario_id": 145,
        "source": {
          "book": "roa",
          "date": "2019-01-19",
          "id": 226,
          "issue": null,
          "notes": null,
          "page": 50,
          "resource_type": "source",
          "scenario_id": 145,
          "sort_order": 1,
          "title": "The Ruin of Arnor",
          "url": null
        }
      }
    ],
    "slug": "/arnor/arvedui",
    "type": "hero",
    "unique": true
  }
}
```

If there is no user token accompanying the request, the `"history"` array will be empty, and the
`"owned"` and `"painted"` keys will be 0.



### [TODO] POST /figure
### [TODO] PUT /figure/:id
### GET `/newsitem`

- **Authentication** None
- **Normal HTTP Response Code** 200
- **Query Parameters**

|Parameter Name|Notes|
|--------------|-----|
| n | # of items to retrieve (default: 3)
| from | start date in "yyyy-mm-dd" format (default: 2000-01-01)
| to | end date in "yyyy-mm-dd" format (default: 3000-01-01)

Retrieves news items, always with the most recent news item first.
All three parameters are optional.

Example return payload:

```json
{
  "data": [
    {
      "item_date": "2023-04-03",
      "item_text": "Corrected the figures needed in the Road to Rivendell (2019), etc."
    },
    {
      "item_date": "2023-03-25",
      "item_text": "On the scenario list screen, clicking the \"%\" now toggles etc."
    },
    {
      "item_date": "2023-03-25",
      "item_text": "Fixed the number of Warriors of the Dead in the Gondor at War Pelargir scenario."
    }
  ]
}
```

### POST `/newsitem`

- **Authentication** Admin
- **Normal HTTP Response Code** 202 (not 200)
- **Error HTTP Response Code** 401 (unauthenticated)

Example input payload:

```json
{
  "item_text": "News headline",
  "item_date": "2023-04-20"
}
```

There is no return payload, only the 202 HTTP response code.

### POST `/reset-password`

This service does not work in production because I never succeeded in getting an email
server configured.  So it is not documented here.  Maybe someday.

### GET `/search`

- **Authentication** None
- **Normal HTTP Response Code** 200
- **Query Parameters**

|Parameter Name|Notes|
|--------------|-----|
| q | the search string |

Searches the scenarios, characters, and figures for the given search parameter.  The
search is accent-insensitive (so searching "Dáin" finds "Dain", and vice versa) thanks
to some Postgres infrastructure.

Example (truncated) return payload when `q=oromi`:

```json
{
  "data": [
    {
      "book": "",
      "id": 260,
      "name": "Boromir",
      "plural_name": null,
      "start": 1,
      "type": "f"
    },
    {
      "book": "",
      "id": 261,
      "name": "Boromir (Breaking)",
      "plural_name": null,
      "start": 1,
      "type": "f"
    },
    {
      "book": "qrb",
      "id": 449,
      "name": "Boromir's Redemption",
      "plural_name": "",
      "start": 1,
      "type": "s"
    },
    {
      "book": "fotr_jb",
      "id": 55,
      "name": "Boromir's Redemption",
      "plural_name": "",
      "start": 1,
      "type": "s"
    }
  ]
}
```

The `type` field determines whether the object in the list is a scenario (`"s"`), figure (`"f"`),
or a character (`"c"`).

The `id` and `name` fields are for the relevant scenari, character, o or figure, depending on `type`.

The `start` field is the 0-based index within the object's `name` of the search string.

The `plural_name` field is non-`null` only for figures which have that field in the database.

The `book` field is filled in only for scenarios and is the
[book abbreviation](https://github.com/dptww1/sbg_inv_be/blob/master/lib/sbg_inv/ecto_enums.ex#L88)
wherein the scenario is found.  For example, a scenario from **Gondor at War** will have `"gaw"`
in the `book` field.

### [TODO] PUT /scenario-faction/:id
### [TODO] GET /scenarios
### [TODO] GET /scenarios/:id/edit
### [TODO] GET /scenarios/new
### [TODO] GET /scenarios/:id
### [TODO] POST /scenarios
### [TODO] PUT /scenarios/:id
### [TODO] GET /scenarios/:scenario_id/resource
### [TODO] POST /scenarios/:scenario_id/resource
### [TODO] PUT /scenarios/:scenario_id/resource/:id
### POST `/sessions`

- **Authentication** None
- **Normal HTTP Response Code** 201 (not 200!)
- **Error HTTP Response Code** 401 (unauthenticated)

Logs a created user into the system and creates a bearer token which can
be used to authenticate subsequent service calls.

Example input payload:

```json
"user": {
  "email": "frodo@shire.com",
  "password": "my friend Sam"
}
```

All of the fields are required.

Example success return payload:

```json
{
  "data": {
    "user_id": 1234,
    "name": "Frodo Baggins",
    "token": "abcdefghijklmnop"
  }
}
```

`user_id` is the logged-in user's ID (of course).

`name` is the logged-in user's name, for display purposes.

The `token` value should be passed as part of an HTTP `Authorization` header, like so:
`Authorization: Token token=<token value>` (without the angle brackets, of course).

Tokens do not expire.

### GET `/stats`

- **Authentication** None
- **Normal HTTP Response Code** 200

Returns some overall statistics for the site.

Example return payload:

```json
{
"data": {
    "models": {
      "mostCollected": {
        "character": [
          {
            "id": 260, "name": "Boromir",                      "slug": "/fellowship/boromir",          "total": 244
          },
          {
            "id": 523, "name": "Witch-king of Angmar",         "slug": "/mordor/witch-king",           "total": 229
          },
          {
            "id": 677, "name": "Théoden with armour on horse", "slug": "/rohan/theoden-horse-starter", "total": 221
          },
          {
            "id": 150, "name": "Frodo (Fellowship)",           "slug": "/fellowship/frodo-fellowship", "total": 217
          },
          {
            "id": 787, "name": "Théoden with armour",          "slug": "/rohan/theoden-starter",       "total": 215
          }
        ],
        "hero": [
          {
            "id": 543, "name": "Ringwraith",                   "slug": null, "total": 1071
          },
          {
            "id": 544, "name": "Ringwraith on horse",          "slug": null, "total": 680
          },
          {
            "id": 537, "name": "Orc Captain",                  "slug": null, "total": 516
          },
          {
            "id": 399, "name": "Uruk-hai Captain with shield", "slug": null, "total": 338
          },
          {
            "id": 545, "name": "Ringwraith on Fell Beast",     "slug": null, "total": 239
          }
        ],
        "monster": [
          {
            "id": 571, "name": "Mordor Troll",          "slug": null, "total": 445
          },
          {
            "id": 600, "name": "Cave Troll with chain", "slug": null, "total": 263
          },
          {
            "id": 370, "name": "Mûmak",                 "slug": null, "total": 205
          },
          {
            "id": 249, "name": "Great Eagle",           "slug": null, "total": 159
          },
          {
            "id": 601, "name": "Cave Troll with spear", "slug": null, "total": 141
          }
        ],
        "warrior": [
          {
            "id": 296, "name": "Warrior of the Dead",          "slug": null, "total": 4136
          },
          {
            "id": 692, "name": "Rider of Rohan",               "slug": null, "total": 3959
          },
          {
            "id": 422, "name": "Uruk-hai Warrior with shield", "slug": null, "total": 3772
          },
          {
            "id": 563, "name": "Orc with shield",              "slug": null, "total": 3678
          },
          {
            "id": 420, "name": "Uruk-hai Warrior with pike",   "slug": null, "total": 3578
          }
        ]
      },
      "mostPainted": {
        "character": [
          {
            "id": 523, "name": "Witch-king of Angmar", "slug": "/mordor/witch-king",           "total": 124
          },
          {
            "id": 260, "name": "Boromir",              "slug": "/fellowship/boromir",          "total": 122
          },
          {
            "id": 150, "name": "Frodo (Fellowship)",   "slug": "/fellowship/frodo-fellowship", "total": 114
          },
          {
            "id": 386, "name": "Lurtz",                "slug": "/isengard/lurtz",              "total": 106
          },
          {
            "id": 190, "name": "Pippin (Fellowship)",  "slug": "/fellowship/pippin",           "total": 88
          }
        ],
        "hero": [
          {
            "id": 543, "name": "Ringwraith",                   "slug": null, "total": 529
          },
          {
            "id": 544, "name": "Ringwraith on horse",          "slug": null, "total": 280
          },
          {
            "id": 537, "name": "Orc Captain",                  "slug": null, "total": 238
          },
          {
            "id": 399, "name": "Uruk-hai Captain with shield", "slug": null, "total": 168
          },
          {
            "id": 122, "name": "Easterling Captain",           "slug": null, "total": 99
          }
        ],
        "monster": [
          {
            "id": 571, "name": "Mordor Troll",          "slug": null, "total": 167
          },
          {
            "id": 600, "name": "Cave Troll with chain", "slug": null, "total": 128
          },
          {
            "id": 370, "name": "Mûmak",                 "slug": null, "total": 108
          },
          {
            "id": 249, "name": "Great Eagle",           "slug": null, "total": 74
          },
          {
            "id": 608, "name": "Tentacle",              "slug": null, "total": 57
          }
        ],
        "warrior": [
          {
            "id": 296, "name": "Warrior of the Dead",          "slug": null, "total": 2169
          },
          {
            "id": 563, "name": "Orc with shield",              "slug": null, "total": 1745
          },
          {
            "id": 564, "name": "Orc with spear",               "slug": null, "total": 1666
          },
          {
            "id": 422, "name": "Uruk-hai Warrior with shield", "slug": null, "total": 1627
          },
          {
            "id": 692, "name": "Rider of Rohan",               "slug": null, "total": 1542
          }
        ]
      },
      "totalOwned": 194991,
      "totalPainted": 79550
    },
    "users": {
      "total": 563
    }
  }
}
```

### [TODO] POST /userfigure
### GET `/userhistory`

- **Authentication** User
- **Normal HTTP Response Code** 200
- **Error HTTP Response Code** 401 (unauthenticated)
- **Query Parameters**

|Parameter Name|Notes|
|--------------|-----|
|from| starting date, in YYYY-MM-dd form
| to | ending date, in YYYY-MM-dd form

Retrieves all of the user's activity between the start and end dates (inclusive),
sorted in increasing date order.

Example (truncated) return payload:

```json
{
  "data": [
    {
      "amount": 1,
      "figure_id": 876,
      "id": 39518,
      "name": "Rutabi",
      "notes": null,
      "op": "buy_unpainted",
      "op_date": "2022-03-01",
      "plural_name": null,
      "user_id": 1
    },
    {
      "amount": 1,
      "figure_id": 155,
      "id": 39521,
      "name": "Frodo (Barrow Downs)",
      "notes": null,
      "op": "paint",
      "op_date": "2022-08-21",
      "plural_name": null,
      "user_id": 1
    },
    {
      "amount": 5,
      "figure_id": 27,
      "id": 39528,
      "name": "Warrior of Arnor",
      "notes": null,
      "op": "buy_unpainted",
      "op_date": "2022-10-01",
      "plural_name": "Warriors of Arnor",
      "user_id": 1
    }
  ]
}
```

`id` is the ID of the history record itself.

`user_id` is always the ID of the authenticated user.

The other fields are the same as the input payload of the
[PUT `/userhistory`](#put-user-history-id) service.

### PUT `/userhistory/:id`

- **Authentication** User
- **Normal HTTP Response Code** 204 (not 200)
- **Error HTTP Response Codes**
    . 401 Authentication failed
    . 422 Bad payload

Updates an existing
[user_figure_history](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#user_figure_history)
record identified by the `:id` part of the URL, assuming it is owned by the authenticated user.

Example input payload:

```json
"history": {
  "user_id": 123,
  "amount": 4,
  "figure_id": 456,
  "op": "buy_unpainted",
  "op_date": "2023-04-02",
  "notes": "ordered 2023-03-15"
}
```

All of of the fields except `notes` are required.

This service has no effect on the user's actual inventory numbers. So using this method means the user's inventory
in the `user_figures` table may no longer match the sum of the user's `user_figure_history` records.

### DELETE `/userhistory/:id`

- **Authentication** User
- **Normal HTTP Response Code** 204 (not 200)
- **Error HTTP Response Code** 401 Authentication failed

Deletes the [user_figure_history](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#user_figure_history)
record identified by the `:id` part of the URL, assuming it is owned by the authentication user.

This service has no effect on the user's actual inventory numbers. So using this method means the user's inventory
in the `user_figures` table may no longer match the sum of the user's `user_figure_history` records.

### POST `/userscenarios`

- **Authentication** User
- **Normal HTTP Response Code** 200
- **Error HTTP Response Codes**
  . 401 Authentication failed
  . 422 Rating is out of range, or bad scenario ID

Creates or updates the user's scenario rating.

Example input payload:

```json
{
  "user_scenario": {
    "scenario_id": 385,
    "rating": 4
  }
}
```

The `scenario_id` is the ID of the scenario as returned by the [GET `scenarios`](#get-scenarios)
service.

The `rating` should be 1, 2, 3, 4, or 5 to set the user's rating for the given scenario, or 0
to remove the user's rating altogether (to allow unintended ratings to be "erased").

Example success return payload:

```json
{
  "avg_rating": 4.0,
  "num_votes": 1,
  "owned": 53,
  "painted": 53,
  "rating": 4
}
```

On a successful call, the service recomputes the vote count and rating for the scenario using the
ratings submitted by all users, and returns them as `num_votes` and `avg_rating`, respectively.

`rating` is always the same input payload rating.

`owned` and `painted` are the number of figures required for the scenario which the user has collected
and painted, respectively.  They are here through happenstance and shouldn't be relied on to always
be included here.


### POST `/users`

- **Authentication** None
- **Normal HTTP Response Code** 200
- **Error HTTP Response Code** 422

Creates a new user account with the given email and password.

Example input payload:

```json
{
  "user": {
    "name": "Frodo Baggins",
    "email": "frodo@shire.com",
    "password": "my friend Sam"
  }
}
```

All of the fields are required.

Example success return payload:

```json
{
  "data": {
    "id": 1234
    "email": "frodo@shire.com"
  }
}
```

Example error return payload:

```json
{
  "errors": {
    "email": [
      "has already been taken"
    ]
  }
}
```

### PUT `/users/:id`

- **Authentication** Required
- **Normal HTTP Response Code** 200
- **Error HTTP Response Codes**
  . 401 Authentication failed
  . 422 Can't update email to another user's email address

Updates an existing user's account, either the password, or the email address, or both.

Example input payload:

```json
{
  "user": {
    "id": 1234
    "email": "frodo@rivendell.org",
    "password": "Elrond"
  }
}
```

`id` and either or both of `email` and `password` are required.

Example success return payload:

```json
{
  "data": {
    "id": 1234
    "email": "frodo@rivendell.org"
  }
}
```

Example error return payload:
```json
{
  "errors": {
    "email": [
      "has already been taken"
    ]
  }
}
```
