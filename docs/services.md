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

The service URLs follow standard Phoenix
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
* [GET /newsitem](#get-newsitem)
* [POST /newsitem](#post-newsitem)
* [POST /reset-password](#post-reset-password)
* [GET /search](#get-search)
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
* [POST /sessions](#post-sessions)
* [GET `/stats`](#get-stats)
* [POST /userfigure](#post-userfigure)
* [GET /userhistory](#get-userhistory)
* [PUT /userhistory/:id](#put-userhistory-id)
* [DELETE /userhistory/:id](#delete-userhistory-id)
* [POST /userscenarios](#post-userscenarios)
* [POST `/users`](#post-users)
* [PUT /users/:id](#put-users-id)

## Service Call Details
### [TODO] GET /character/:id
### [TODO] POST /character
### [TODO] PUT /character/:id
### [TODO] GET /faction
### [TODO] GET /faction/:id
### [TODO] GET /figure/:id
### [TODO] POST /figure
### [TODO] PUT /figure/:id
### [TODO] GET /newsitem
### [TODO] POST /newsitem
### [TODO] POST /reset-password
### [TODO] GET /search
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
- **Error HTTP Response Code** 401

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

The `user_id` and `token` should be used in subsequent service calls:

* The `user_id` value is passed as part of the service call URL when needed.

* The `token` value should be passed as part of an HTTP `Authorization` header, like so:
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
### [TODO] GET /userhistory
### [TODO] PUT /userhistory/:id
### [TODO] DELETE /userhistory/:id
### [TODO] POST /userscenarios
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
