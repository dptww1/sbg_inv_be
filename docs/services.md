# Service Calls

The document describes the SBG Inventory HTTP service calls.  The
[front end][https://github.com/dptww1/sbg_inv_be] is responsible for
the user interface but all the real work happens in the back end using
these service calls.

The services are hosted at `https://homely-uncomfortable-wreckfish.gigalixirapp.com/api`.
For brevity, I document a service call without that prefix, so the call listed as
`/scenarios/-1/resource` is actually located at
`https://homely-uncomfortable-wreckfish.gigalixirapp.com/api/scenarios/-1/resource`.

The services are primarily designed for user inventory tracking, and so usually require
authenticated credentials.  However some services work whether the caller is authenticated
or not, returning just the user-independent data in the latter case.

Here's an example JSON block, just for kicks:

```json
{
  "user": "Dave",
  "password": "nope",
  "email": "dave@davetownsend.org"
}
```
