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

An organization seeking a targeted audience.

Example:

```` js
{
  name: "Fendie",
  description: "The leader in Sitar manufacturing and distribution.",
  url: "https://www.fendie.com/",
  contact: {} // an unstructured object optionally containing contact information like a sales representative's name and phone number and email address.
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















<hr>





### Unimplemented

This table contains a list of API endpoints planned but not yet implemented.

Dev Group	| Primary Resource | Action | Request Method | Endpoint URL
---	|	---	|	---	|	---	|	---
1-Core	|	Artist (User)	|	1-List | GET | /api/artists
1-Core	|	Artist (User)	|	3-Show	|	GET	|	/api/artists/:id
1-Core	|	Artist (User)	|	4-Update	|	PUT	|	/api/artists/:id
1-Core	|	Artist (User)	|	5-Destroy	|	DELETE	|	/api/artists/:id
1-Core	|	User	|	1-List	|	GET	|	/api/users
1-Core	|	User	|	2-Create	|	POST	|	/api/users
1-Core	|	User	|	3-Show	|	GET	|	/api/users/:id
1-Core	|	User	|	4-Update	|	PUT	|	/api/users/:id
1-Core	|	User	|	5-Destroy	|	DELETE	|	/api/users/:id
2-Comms	|	Ad	|	1-List	|	GET	|	/api/ads
2-Comms	|	Ad	|	2-Create	|	POST	|	/api/ads
2-Comms	|	Ad	|	3-Show	|	GET	|	/api/ads/:id
2-Comms	|	Ad	|	4-Update	|	PUT	|	/api/ads/:id
2-Comms	|	Ad	|	5-Destroy	|	DELETE	|	/api/ads/:id
2-Comms	|	AdPlacement	|	1-List	|	GET	|	/api/ads/:id/placements
2-Comms	|	AdPlacement	|	2-Create	|	POST	|	/api/ads/:id/placements
2-Comms	|	AdPlacement	|	3-Show	|	GET	|	/api/ads/:id/placements/:id
2-Comms	|	AdPlacement	|	4-Update	|	PUT	|	/api/ads/:id/placements/:id
2-Comms	|	AdPlacement	|	5-Destroy	|	DELETE	|	/api/ads/:id/placements/:id
2-Comms	|	Alert	|	1-List	|	GET	|	/api/alerts
2-Comms	|	Alert	|	2-Create	|	POST	|	/api/alerts
2-Comms	|	Alert	|	3-Show	|	GET	|	/api/alerts/:id
2-Comms	|	Alert	|	4-Update	|	PUT	|	/api/alerts/:id
2-Comms	|	Alert	|	5-Destroy	|	DELETE	|	/api/alerts/:id
2-Comms	|	UserAlert	|	1-List	|	GET	|	/api/users/:id/alerts
2-Comms	|	UserAlert	|	2-Create	|	POST	|	/api/users/:id/alerts
2-Comms	|	UserAlert	|	3-Show	|	GET	|	/api/users/:id/alerts/:id
2-Comms	|	UserAlert	|	4-Update	|	PUT	|	/api/users/:id/alerts/:id
2-Comms	|	UserAlert	|	5-Destroy	|	DELETE	|	/api/users/:id/alerts/:id
3-Interactivity	|	Favorite	|	2-Create	|	POST	|	/api/favorites
3-Interactivity	|	Favorite	|	5-Destroy	|	DELETE	|	/api/favorites
3-Interactivity	|	Follow	|	2-Create	|	POST	|	/api/follow
3-Interactivity	|	Follow	|	5-Destroy	|	DELETE	|	/api/follow
3-Interactivity	|	Video	|	1-List	|	GET	|	/api/videos
3-Interactivity	|	Video	|	2-Create	|	POST	|	/api/videos
3-Interactivity	|	Video	|	3-Show	|	GET	|	/api/videos/:id
3-Interactivity	|	Video	|	4-Update	|	PUT	|	/api/videos/:id
3-Interactivity	|	Video	|	5-Destroy	|	DELETE	|	/api/videos/:id
3-Interactivity	|	View	|	1-List	|	GET	|	/api/views/
3-Interactivity	|	View	|	2-Create	|	POST	|	/api/views/
3-Interactivity	|	View	|	3-Show	|	GET	|	/api/views/:id
4-Payments	|	Payment	|	1-List	|	GET	|	/api/payments
4-Payments	|	Payment	|	3-Show	|	GET	|	/api/payments/:id
