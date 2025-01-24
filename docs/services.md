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
the [Database Documentation](database.md).

## Table of Contents

* [`GET /about`](#get-about)
* [`PUT /about/:id`](#put-aboutid)
* [`GET /character/:id`](#get-characterid)
* [`POST /character`](#post-character)
* [`PUT /character/:id`](#put-characterid)
* [`GET /faction`](#get-faction)
* [`GET /faction/:id`](#get-factionid)
* [`GET /figure/:id`](#get-figureid)
* [`POST /figure`](#post-figure)
* [`PUT /figure/:id`](#put-figureid)
* [`GET /newsitem`](#get-newsitem)
* [`POST /newsitem`](#post-newsitem)
* [`PUT /newsitem/:id`](#put-newsitemid)
* [`DELETE /newsitem/:id`](#delete-newsitemid)
* [`POST /reset-password`](#post-reset-password)
* [`GET /search`](#get-search)
* [`PUT /scenario-faction/:id`](#put-scenario-factionid)
* [`GET /scenarios`](#get-scenarios)
* [`GET /scenarios/:id`](#get-scenariosid)
* [`POST /scenarios`](#post-scenarios)
* [`PUT /scenarios/:id`](#put-scenariosid)
* [`GET /scenarios/:scenario_id/resource`](#get-scenariosscenario_idresource)
* [`POST /scenarios/:scenario_id/resource`](#post-scenariosscenario_idresource)
* [`PUT /scenarios/:scenario_id/resource/:id`](#put-scenariosscenario_idresourceid)
* [`POST /sessions`](#post-sessions)
* [`GET /stats`](#get-stats)
* [`POST /userfigure`](#post-userfigure)
* [`GET /userhistory`](#get-userhistory)
* [`PUT /userhistory/:id`](#put-userhistoryid)
* [`DELETE /userhistory/:id`](#delete-userhistoryid)
* [`POST /userscenarios`](#post-userscenarios)
* [`POST /users`](#post-users)
* [`PUT /users/:id`](#put-usersid)

## Service Call Details
### `GET /about`

- **Authentication** none
- **Normal HTTP Response Code** 200

Retrieves the text for the "about this site"-type text and the FAQs
appearing on the same page.

Example return payload:

```json
{
  "data": {
    "about": "This web site...",
    "faqs": [
      {
        "id": 1,
        "question": "Why don't you...",
        "answer": "Because ....",
        "sort_order": 1
      },
      {
        "id": 2,
        "question": "How do I ...",
        "answer": "By clicking the ...",
        "sort_order": 2
      }
    ]
  }
}
```

Any or all of text data will contain
HTML markup that should be protected from escaping when rendered.

### `PUT /about/:id`

- **Authentication** Admin
- **Normal HTTP Response Code** 200
- **Error HTTP Response Code** 401 Unauthorized

Updates the "about this site" text and/or the FAQs.

Example input payload:

```json
{
  "body_text": "Updated this web site...",
  "faqs": [
    {
      "question": "How come you...",
      "answer": "Because ....",
      "sort_order": 1
    },
      {
        "id": 2,
        "question": "How do I ...",
        "answer": "By clicking the ...",
        "sort_order": 2
      }
    ]
}
```

Since there is only one "about" text, the actual `:id` passed to this service is irrelevant.
Both `body_text` and `faqs` must be supplied, even if unchanged.  Of course new FAQ entries
won't have an `id`, as in the first FAQ in the example payload.

The return payload is the same as [`GET /about`](#get-about).

### `GET /character/:id`

- **Authentication** Admin
- **Normal HTTP Response Code** 200
- **Error HTTP Reponse Codes**
    . 401 Authorization error
    . 422 Unknown ID

Retrieves the [character](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#characters)
with the given ID.

Example return payload:

```json
{
  "data": {
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
    "resources": [
      {
        "title": "BSiME",
        "book": "fotn",
        "issue": "3",
        "page": 23,
        "type": "painting_guide",
        "url": null
      },
      {
        "title": "Green Dragon",
        "book": null,
        "issue": null,
        "page": null,
        "type": "analysis",
        "url": "http://www.example.com"
      },
      {
        "title": null,
        "book": "fotr_jb",
        "issue": null,
        "page": 12,
        "type": "painting_guide"
        "url": null
      }
    ],
    "rules": [
      {
        "override_name": null,
        "book": "alotr",
        "issue": null,
        "page": 134,
        "url": null,
        "sort_order": 1,
        "obsolete": false
      },
      {
        "override_name": "Nandor the Relentless",
        "book": "mordor",
        "issue": null,
        "page": 13,
        "url": null,
        "sort_order": 2,
        "obsolete": true
      }
    ]
  }
}
```

### `POST /character`

- **Authentication** Admin
- **Normal HTTP Response Code** 200
- **Error HTTP Response Codes**
    + 401 Authorization error
    + 422 bad input payload

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
      { "id": 500, "name": "Gollum (Fish)" },
      { "id": 369, "name": "Watcher of Karna" }
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

### `PUT /character/:id`

- **Authentication** Admin
- **Normal HTTP Response Code** 200
- **Error HTTP Response Codes**
    + 401 Authorization error
    + 422 bad input payload

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
    "book": "dotn",
    "faction": "arnor",
    "figures": [
      { "id": 1, "name": "Bûhrdur" },
      { "id": 500, "name": "Gollum (Fish)" },
      { "id":369, "name":"Watcher of Karna" }
    ],
    "id": 1234,
    "name": "Test New Character, New Name",
    "num_analyses": 0,
    "num_painting_guides": 1,
    "page": 9,
    "resources": [
      {
        "title": "Sample Painting Guide",
        "book": null,
        "issue": null,
        "page": null,
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

### `GET /faction`

- **Authentication** User (Optional)
- **Normal HTTP Response Code** 200

Gets a list of factions.  Exact results depend on whether an authentication token is passed or not.

Example return payload when no authentication token is passed:

```json
{
  "data": {
    "factions": [
      {
        "id": 46,
        "abbrev": "arathorn",
        "name": "Arathorn's Stand",
        "alignment": 0,
        "legacy": false,
        "keywords": "menOfTheNorth"
      },
      {
        "id": 51,
        "abbrev": "carn_dum",
        "name": "Army of Carn Dûm",
        "alignment": 1,
        "legacy": false,
        "keywords": "angmar"
      },
      ...
   }
}
```

The factions are returns in alphabetical order by `"name"`.

The fields correspond exactly to the [army_lists](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#army-lists) table.

Example return payload when an authentication token is passed:

```json
{
  "data":
    {
      "thranduil": { "owned": 30, "painted": 24 },
      "rangers": { "owned": 30, "painted": 8 },
      "dunharrow": { "owned": 0, "painted": 0 },
      ...
      "Totals": { "owned": 2216, "painted": 1276 }
    }
}
```

The above results are truncated for brevity. The results always have an entry in `"data"`
for each [army_list](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#army-lists)
whether the user has any figures or not in that faction.

The special entry `"Totals"` is the number of figures in the user's entire collection.  Since
figures can belong to multiple factions, the amounts here are *not* a simple sum of the
faction figures!

### `GET /faction/:id`

- **Authentication** User (Optional)
- **Normal HTTP Response Code** 200
- **Error HTTP Response Code** 404 Bad faction id

Gets a list of the figures belonging to the given faction, organized by type.  If the request
has an authenticated user token, the list includes the users collected and painted inventory as well.

Example return payload:

```json
{
  "data": {
    "sources": [
      "book": "alotr2",
      "issue": null,
      "page": 18,
      "url": null
    ],
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

The `"unique"` field is only true within the `"heroes"` array.  It indicates unique heroes such as Aragorn
that cannot be fielded more than once in an army.

The `"owned"` and `"painted"` keys will always be present, even for requests without an authenticated
user token.  Of course in such cases they are always zero.

### `GET /figure/:id`

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
        "title": "SomePainter",
        "book": null,
        "issue": null,
        "page": null,
        "type": "painting_guide",
        "url":"https://www.example.com"
      }
    ],
    "rules": [
      {
        "override_name": null,
        "book": "alotr",
        "issue": null,
        "page": 57,
        "url": null,
        "sort_order": null,
        "obsolete": false
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



### `POST /figure`

- **Authentication** Admin
- **Normal HTTP Response Code** 200
- **Error HTTP Response Code** 401 Authorization error

Creates a new [figures](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#figures)
record.

There are two possible types of payload:

1. Example input payload for creating a new figure *ab initio*:

```json
{
  "figure": {
    "factions": [
      "arnor"
    ],
    "name": "New Figure",
    "plural_name": "New Figure Names",
    "slug": "/arnor/new-figure",
    "type": "hero",
    "unique": true
  }
}
```

`"name"` and `"type"` are required, the other fields are optional.

`"type"` is one of the [figure type](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#figure-type)
strings.

`"unique"` should be `true` for unique named figures (Frodo, Imrahil) and false for everything else.

`"slug"` is an arbitrary unique string for the figure.  It's currently used by the front end to
construct a URL for the figure's silhouette, so it's only populated for those figures for which
the front end actually has silhouettes.

`"factions"` is an array of [faction](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#faction)
strings.

2. Example input payload for creating a new figure copied from another figure:

```json
{
  "figure": {
    "name": "New Figure Name",
    "plural_name": "New Figure Names",
    "same_as": 123
  }
}
```

`"name"` and `"same_as"` are required. `"plural_name"` is optional.  With this payload, the newly created
figure will be assigned the same figure type, uniqueness, and associated faction(s), character(s), and scenario roles,

Example response payload for either type of input payload:

```json
{
  "data": {
    "factions": [
      "arnor"
    ],
    "history": [],
    "id": 920,
    "name": "New Figure",
    "owned": 0,
    "painted": 0,
    "plural_name": "New Figure Names",
    "resources": [],
    "rules": [],
    "scenarios": [],
    "slug": "/arnor/new-figure",
    "type": "hero",
    "unique": true
  }
}
```

The `"id"` field is the figure ID, which is needed for subsequent operations on this figure.

The `"history"`, `"owned"`, `"painted"`, `"resources"`, and `"rules"` fields will always be empty.

Use [`POST /userfigure`](#post-userfigure) to modify `"owned"`, `"painted"`, and `"history"`.

Use [`POST /character`](#post-character) and [`PUT /character`](#put-character) to modify
`"resources"` and `"rules"`.

To associate a figure with a scenario, use the [`PUT /scenario-faction/:id`](#put-scenariofactionid) service.

### `PUT /figure/:id`

- **Authentication** Admin
- **Normal HTTP Response Code** 200
- **Error HTTP Response Code** 401 Authorization error

Updates the generic, non user-specific and non-character-specific fields for
[figure](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#figures) record.

Example input payload:

```json
{
  "figure": {
    "factions": [
      "arnor",
      "beornings",
      "trolls"
    ],
    "id": 920,
    "name": "New Figure2",
    "plural_name": "New Figure2 Names",
    "slug": "/arnor/new-figure2",
    "type": "hero",
    "unique": true
  }
}
```

The fields are the same as the [`POST`](#put-figureid) service, with the addition of `"id"` to determine
which figure to update.

Example response:

```json
{
  "data": {
    "factions": [
      "arnor",
      "beornings",
      "trolls"
    ],
    "history": [],
    "id": 920,
    "name": "New Figure2",
    "owned": 0,
    "painted": 0,
    "plural_name": "New Figure2 Names",
    "resources": [],
    "rules": [],
    "scenarios": [],
    "slug": "/arnor/new-figure2",
    "type": "hero",
    "unique": true
  }
}
```

Fields and notes are per the [`POST`](#put-figureid) service.

### `GET /newsitem`

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

### `POST /newsitem`

- **Authentication** Admin
- **Normal HTTP Response Code** 200
- **Error HTTP Response Code** 401 Authorization error

Create a news item, returning the created item:

Example input payload:

```json
{
  "item_text": "News headline",
  "item_date": "2023-04-20"
}
```

Example return payload:

```json
{
  "id": 1873,
  "item_text": "News headline",
  "item_date": "2023-04-20"
}
```


### `PUT /newsitem/:id`

- **Authentication** Admin
- **Normal HTTP Response Code** 200
- **Error HTTP Response Code** 401 Authorization error

Edit a news item, returning the edited item.

Example input payload:

```json
{
  "id": 1278,
  "item_text": "New News headline",
  "item_date": "2024-05-21"
}
```

The return payload is the same as the input payload.

### `DELETE /newsitem/:id`

- **Authentication** Admin
- **Normal HTTP Response Code** 204 (not 200)
- **Error HTTP Response Code** 401 Authorization error

Deletes the given news item.  There is no return payload.

### `POST /reset-password`

This service does not work in production because I never succeeded in getting an email
server configured.  So it is not documented here.  Maybe someday.

### `GET /search`

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
[book](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#books) string
wherein the scenario is found.  For example, a scenario from **Gondor at War** will have `"gaw"`
in the `book` field.

### `PUT /scenario-faction/:id`

- **Authentication** Admin
- **Normal HTTP Response Code** 200
- **Error HTTP Response Code**
  . 401 Authorization error
  . 422 bad data

Updates a [`scenario_factions`](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#scenario_factions)
record.

There is no separate `POST` service to create a faction because factions must be associated with
scenarios and so are created as a side effect when a scenario is created via
[`POST /scenarios`](https://github.com/dptww1/sbg_inv_be/blob/master/docs/services.md#todo-post-scenarios).

Example input payload:

```json
{
  "scenario_faction": {
    "actual_points": "0",
    "faction": "fellowship",
    "id": 1001,
    "roles": [
      {
        "_expanded": false,
        "amount": "1",
        "figures": [
          {
            "figure_id": "724",
            "name": "Bilbo Baggins (Goblintown)",
            "plural_name": "null",
            "type": "f",
            "unique": false
          },
          {
            "figure_id": "725",
            "name": "Bilbo Baggins (Riddles)",
            "plural_name": "null",
            "type": "f",
            "unique": false
          }
        ],
        "name": "Bilbo Baggins",
        "plural_name": "",
        "scenario_faction_id": 1001,
        "sort_order": 1
      },
      {
        "_expanded": false,
        "amount": "1",
        "figures": [
          {
            "figure_id": "763",
            "name": "Thorin Oakenshield",
            "plural_name": "null",
            "type": "f",
            "unique": false
          }
        ],
        "name": "Thorin Oakenshield",
        "plural_name": "",
        "scenario_faction_id": 1001,
        "sort_order": 2
      }
    ],
    "sort_order": "1",
    "suggested_points": "0"
  }
}
```

The return payload is the contents of the input `"scenario_faction"` object.  There is no root
`"data"` field containing the object, which is how most/all of the other services return their
data.

After adjusting the roles and figures assigned to the faction, the owning scenario's
`"size"` is updated to reflect the new total number of figures in that scenario.

### `GET /scenarios`

- **Authentication** User (Optional)
- **Normal HTTP Response Code** 200

Gets all the scenarios in the system, ordered by increasing "historical" date.

Example response, limited to a single scenario for space reasons:

```json
{
  "data": [
    {
      "blurb": "Sauron's forces seek the Elven haven of Imladris.",
      "date_age": 2,
      "date_day": 0,
      "date_month": 0,
      "date_year": 3431,
      "id": 336,
      "location": "eriador",
      "map_height": 48,
      "map_width": 48,
      "name": "Watchpost Attack",
      "num_votes": 9,
      "rating": 3.444444417953491,
      "scenario_factions": [
        {
          "actual_points": 0,
          "faction": "rivendell",
          "id": 671,
          "sort_order": 1,
          "suggested_points": 0
        },
        {
          "actual_points": 0,
          "faction": "mordor",
          "id": 672,
          "sort_order": 2,
          "suggested_points": 0
        }
      ],
      "scenario_resources": {
        "magazine_replay": [],
        "podcast": [],
        "source": [
          {
            "book": "bgime",
            "date": "2019-05-23",
            "id": 563,
            "issue": "36",
            "notes": null,
            "page": 6,
            "resource_type": "source",
            "scenario_id": 336,
            "sort_order": 335,
            "title": "BGiME",
            "url": null
          }
        ],
        "terrain_building": [],
        "video_replay": [],
        "web_replay": []
      },
      "size": 71,
      "user_scenario": {
        "avg_rating": 3.444444417953491,
        "num_votes": 9,
        "owned": 71,
        "painted": 68,
        "rating": 0
      }
    },
    {
      ...
    },
    ...
  ]
}
```

Most of the fields come directly from the
[scenarios](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#scenarios) table.

The `"scenario_factions"` fields come directly from the
[scenario_factions](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#scenario_factions) table.

The `"scenario_resources"` fields come from the
[scenario_resources](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#scenario_resources) table.
The back end breaks the resources out by
[type](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#scenario-resource-type)
as a convenience for the front end.

If the request doesn't have a legitimate authorization token, the `"owned"`, `"painted"`, and `"rating"`
fields of the `"user_scenario"` object within each scenario will be 0.

### `GET /scenarios/:id`

- **Authentication** User (Optional)
- **Normal HTTP Response Code** 200

Gets the details of a specific scenario.

```json
{
  "data": {
    "blurb": "Gandalf and Saruman face off in the tower of Orthanc in this non-SBG scenario.",
    "date_age": 3,
    "date_day": 10,
    "date_month": 7,
    "date_year": 3018,
    "id": 318,
    "location": "orthanc",
    "map_height": 12,
    "map_width": 12,
    "name": "Wizards' Duel",
    "num_votes": 1,
    "rating": 5,
    "rating_breakdown": [ 0, 0, 0, 0, 1 ],
    "scenario_factions": [
      {
        "actual_points": 0,
        "faction": "fellowship",
        "id": 635,
        "roles": [
          {
            "amount": 1,
            "figures": [
              {
                "figure_id": 217,
                "name": "Gandalf the Grey (Hobbit)",
                "owned": 0,
                "painted": 0
              },
              {
                "figure_id": 213,
                "name": "Gandalf the Grey (with Bilbo)",
                "owned": 1,
                "painted": 0
              }
            ],
            "id": 4188,
            "name": "Gandalf the Grey",
            "num_owned": 1,
            "num_painted": 1,
            "sort_order": 1
          }
        ],
        "sort_order": 1,
        "suggested_points": 0
      },
      {
        "actual_points": 0,
        "faction": "isengard",
        "id": 636,
        "roles": [
          {
            "amount": 1,
            "figures": [
              {
                "figure_id": 845,
                "name": "Saruman the White (Middle Earth)",
                "owned": 1,
                "painted": 1
              },
              {
                "figure_id": 241,
                "name": "Saruman (Orthanc)",
                "owned": 1,
                "painted": 0
              }
            ],
            "id": 4189,
            "name": "Saruman",
            "num_owned": 1,
            "num_painted": 1,
            "sort_order": 1
          }
        ],
        "sort_order": 2,
        "suggested_points": 0
      }
    ],
    "scenario_resources": {
      "magazine_replay": [],
      "podcast": [],
      "source": [
          {
            "book": "bgime",
            "date": "2019-05-18",
            "id": 545,
            "issue": "13",
            "notes": null,
            "page": 8,
            "resource_type": "source",
            "scenario_id": 318,
            "sort_order": 317,
            "title": "BGiME",
            "url": null
          }
      ],
      "terrain_building": [],
      "video_replay": [],
      "web_replay": []
    },
    "size": 2,
    "user_scenario": {
        "avg_rating": 5,
        "num_votes": 1,
        "owned": 2,
        "painted": 2,
        "rating": 0
    }
  }
}
```

Most of the attributes come directly from the
[`scenarios`](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#scenarios),
[`scenario_factions`](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#scenario_factions),
[`figures`](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#figures),
and [`user_scenarios`](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#user_scenarios) tables.

The `"rating"` is the average rating of the scenario among all user ratings for the scenario.  It
will be between 1-5, but can be (and often is) a floating point value, not just an integer.

The `"ratings_breakdown"` is always an array of five elements, with element `n`
being the number of ratings for the scenario of value `n + 1`.

For unauthenticated requests, the `"num_owned"`, `"num_painted"`,
`"owned"`, and `"painted"` fields throughout the return payload will be 0.

The `"user_scenario.rating"` field will only be non-zero for scenarios
rated (1-5) by the currently-authenticated user.  Otherwise it will be 0.

The `"scenario_resources"` are sorted into type-specific buckets for the
convenience of the front end.

### `POST /scenarios`
- **Authentication** Admin
- **Normal HTTP Response Code** 201 (not 200)
- **Error HTTP Response Code**
  . 401 Authorization error
  . 422 Bad data

Creates a new [scenario](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#scenarios).

Example input payload:

```json
{
  "scenario": {
    "blurb": "Some descriptive text.",
    "date_age": "3",
    "date_day": "2",
    "date_month": "4",
    "date_year": "3018",
    "location": "eriador",
    "map_height": "48",
    "map_width": "48",
    "name": "Another Test Scenario",
    "scenario_factions": [
      {
        "actual_points": "0",
        "faction": "fellowship",
        "sort_order": "1",
        "suggested_points": "0"
      },
      {
        "actual_points": "0",
        "faction": "angmar",
        "sort_order": "2",
        "suggested_points": "0"
      }
    ],
    "size": "0"
  }
}
```

All of the shown fields are required and map directly to fields in the
(scenarios)[https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#scenarios] and
(scenario_factions)[https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#scenario_factions]
tables.

There should always be exactly two factions.

`"location"` is a [Location](#https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#location) string.

`"faction"` is a [Faction](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#faction) string.

The response payload matches the return from the
[`GET /scenarios/:id`](https://github.com/dptww1/sbg_inv_be/blob/master/docs/services.md#todo-get-scenariosid)
service, with `"id"` fields provided for the `"scenario"` and `"scenario_factions"`.  Of course since the
scenario is new, the returned `"scenario_resources"` and `"user_scenario"` fields in the main object and the
`"roles"` fields in the `"scenario_factions"` will no have actual data.

### `PUT /scenarios/:id`
- **Authentication** Admin
- **Normal HTTP Response Code** 201 (not 200)
- **Error HTTP Response Code**
  . 401 Authorization error
  . 422 Bad data

Updates a [scenario](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#scenarios).

Identical to [`POST /scenarios`](https://github.com/dptww1/sbg_inv_be/blob/master/docs/services.md#todo-post-scenarios)
except that the `"scenario"` and `"scenario_factions"` objects must have their `"id"` fields set.

### `GET /scenarios/:scenario_id/resource`

- **Authentication** None
- **Normal HTTP Response Code** 200
- **Query Parameters**

|Parameter Name|Notes|
|--------------|-----|
| n | number resources to return, default 5
| from | starting date, yyyy-MM-dd, default 2000-01-01
| to | ending date, yyyy-MM-dd, default 3001-01-01

Gets the most recent
[resources](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#scenario-resources)
The resources are ordered by modification date, newest to oldest.

The `":scenario_id"` path part is irrelevant to the service.  It's only present due to how Phoenix
wants to set up resources.  I probably overlooked a better way to do this.

Example response:

```json
{
  "data": [
    {
      "book": null,
      "date": "2024-01-13",
      "id": 1065,
      "issue": null,
      "notes": null,
      "page": null,
      "resource_type": "video_replay",
      "scenario_id": 456,
      "scenario_name": "Osgiliath",
      "sort_order": 399,
      "title": "An SBG Club",
      "url": "https://www.youtube.com/not_a_real_id"
    },
    {
      "book": null,
      "date": "2024-01-06",
      "id": 1064,
      "issue": null,
      "notes": null,
      "page": null,
      "resource_type": "web_replay",
      "scenario_id": 237,
      "scenario_name": "Weathertop",
      "sort_order": 398,
      "title": "Some Guy",
      "url": "https://www.example.com/replay"
    }
  ]
}
```

The `"scenario_id"` and `"scenario_name"` give the scenario the resource is for.

The remaining fields correspond directly with the fields in the
[scenario_resources](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#scenario_resources)
table.

### `POST /scenarios/:scenario_id/resource`

- **Authentication** Admin
- **Normal HTTP Response Code** 204 (not 200)
- **Error HTTP Response Code**
  . 401 Authorization error
  . 422 bad data

Creates a [resource](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#scenario_resources)
associated with a scenario.

Example input payload:

```json
{
    "resource": {
        "book": "sbg",
        "issue": 99,
        "page": 10,
        "resource_type": 5,
        "title": "Some Guy"
    }
}
```

`"resource_type"` is a
[Scenario Resource Type](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#scenario-resource-type)
value.

The above would be an example of input for a physical resource, in this case a magazine replay.  For online
resource types, supply a `"url"` field within the `"resource"` and the `"book"`, `"issue"`, and `"page"`
values can be `null`.

### `PUT /scenarios/:scenario_id/resource/:id`

- **Authentication** Admin
- **Normal HTTP Response Code** 204 (not 200)
- **Error HTTP Response Code**
  . 401 Authorization error
  . 422 bad data

Updates a [resource](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#scenario_resources)
associated with a scenario.

Example input payload:

```json
{
    "resource": {
        "id": 1067,
        "book": "sbg",
        "issue": 99,
        "page": 10,
        "resource_type": 5,
        "title": "Some Guy"
    }
}
```

The same notes as [`POST /scenarios/:scenario_id/resource`](#todo-post-scenariosscenario_idresource)
service except that the scenario resource ID must be specified as the `"id"` field within the `"resource"`.

### `POST /sessions`

- **Authentication** None
- **Normal HTTP Response Code** 201 (not 200!)
- **Error HTTP Response Code** 401 Authorization error

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

### `GET /stats`

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

### `POST /userfigure`

- **Authentication** Admin
- **Normal HTTP Response Code** 204 (not 200!)
- **Error HTTP Response Code**
    . 401 Authorization error
    . 422 unknown figure ID

Updates the user's inventory for a given figure.

```json
{
  "user_figure": {
    "id": 920,
    "new_owned": 3,
    "new_painted": 0,
    "notes": "asdf",
    "op": "buy_unpainted",
    "op_date": "2024-01-15"
  }
}
```

The `"id"` field is the ID of the figure being adjusted.

The `"new_owned"` and `"new_painted"` fields are the new *totals* for that category for the figure,
not just a relative change.

The `"op"` field is one of the
[user_figure_op](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#user-figure-op) strings.

In addition to adjusting the
[user_figures](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#user_figures)
record, the service adds a
[user_figure_history](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#user_figure_history)
record using the `"notes"`, `"op"`, and `"op_date"` fields.

This service also launches the
[RecalcUserScenarioTask](https://github.com/dptww1/sbg_inv_be/blob/master/lib/sbg_inv/web/tasks/recalc_user_scenario_task.ex) to recalculate the
[user_scenario](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#user_scenarios)
rollups for each scenario for the current user, based on the newly-adjusted inventory.  This task works in the
background and so results will not be immediately available.  It seems to work quickly enough for human users, though.

### `GET /userhistory`

- **Authentication** User
- **Normal HTTP Response Code** 200
- **Error HTTP Response Code** 401 Authorization error
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
[`PUT /userhistory`](#put-userhistoryid) service.

### `PUT /userhistory/:id`

- **Authentication** User
- **Normal HTTP Response Code** 204 (not 200)
- **Error HTTP Response Codes**
    + 401 Authorization error
    + 422 Bad payload

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

### `DELETE /userhistory/:id`

- **Authentication** User
- **Normal HTTP Response Code** 204 (not 200)
- **Error HTTP Response Code** 401 Authorization error

Deletes the [user_figure_history](https://github.com/dptww1/sbg_inv_be/blob/master/docs/database.md#user_figure_history)
record identified by the `:id` part of the URL, assuming it is owned by the authentication user.

This service has no effect on the user's actual inventory numbers. So using this method means the user's inventory
in the `user_figures` table may no longer match the sum of the user's `user_figure_history` records.

### `POST /userscenarios`

- **Authentication** User
- **Normal HTTP Response Code** 200
- **Error HTTP Response Codes**
  + 401 Authorization error
  + 422 Rating is out of range, or bad scenario ID

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


### `POST /users`

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

### `PUT /users/:id`

- **Authentication** Required
- **Normal HTTP Response Code** 200
- **Error HTTP Response Codes**
  + 401 Authorization error
  + 422 Can't update email to another user's email address

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
