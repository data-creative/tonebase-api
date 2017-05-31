# Web Service Documentation

This document provides a reference for how the Client Application should expect to interface with the API Server.

NOTE: The API's current operating version is `v1`, so all endpoint URLs in this document assume a prefix of `/api/v1`.

## Requests

### POST Request Parameters

When issuing POST requests to a particular endpoint, pass parameters for the given resource nested inside an object named after that resource. For example, the request `POST api/v1/things` should pass a request body which resembles the following:

```` js
{
  thing: { // <-- name this object after the resource you are trying to create!
    name: "My Thing",
    description: "A thing."
  }
}
````

## Responses

The API uses the following HTTP response codes:

code | major status | minor status | description
--- | --- | ---
200 | Success | OK | The resource(s) were returned successfully. Or the resource was updated successfully.
201 | Success | Created | The resource was created successfully.
204 | Success | No Content | The resource was destroyed successfully.
404 | Client Error | Not found | The resource wasn't found. Ensure the resource identifier is correct.
422 | Client Error | Unprocessable | You tried to create or update a resource but something went wrong. Maybe there are validation errors.

When there are Client Errors, the API also returns descriptive error messages, such as:

  + `{"id": ["not found"]}`
  + `{"name": ["can't be blank"]}`
  + `{"name": ["has already been taken"]}`

## Resources

Each section below describes a class of resource within the scope of this system, as well as an example JSON representation of that resource, and a list of operations available to be performed on that resource.

### Instrument

A musical instrument.

Attributes:

name | type | description
--- | --- | ---
name | String | The instrument name.
description | Text | A description of the instrument.

Example:

```` js
{
  name: "Sitar",
  description: "The sitar is a plucked stringed instrument used mainly in Hindustani music and Indian classical music."
}
````

Endpoints:

Action | Request Method | Endpoint URL
---	|	---	|	---
List | GET | /instruments
Create | POST | /instruments
Show | GET | /instruments/:id
Update | PUT | /instruments/:id
Destroy | DELETE | /instruments/:id

### Advertiser

An organization seeking a targeted audience for their product advertisement(s).

Attributes:

name | type | description
--- | --- | ---
name | String | The organization's name.
description | Text | A description of the organization.
url | String | The organization's website.
metadata | Object | An unstructured place to store other information about the organization.

Example:

```` js
{
  name: "Fendie",
  description: "The leader in Sitar manufacturing and distribution.",
  url: "https://www.fendie.com/",
  metadata: {}
}
````

Endpoints:

Action | Request Method | Endpoint URL
---	|	---	|	---
List | GET | /advertisers
Create | POST | /advertisers
Show | GET | /advertisers/:id
Update | PUT | /advertisers/:id
Destroy | DELETE | /advertisers/:id
