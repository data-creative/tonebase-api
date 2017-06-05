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
--- | --- | --- | ---
200 | Success | OK | The resource(s) were returned successfully. Or the resource was updated successfully.
201 | Success | Created | The resource was created successfully.
204 | Success | No Content | The resource was destroyed successfully.
404 | Client Error | Not found | The resource wasn't found. Ensure the resource identifier is correct and other parameter values are valid.
422 | Client Error | Unprocessable | You tried to create or update a resource but something went wrong. Maybe there are validation errors.

### Error Messages

When there are Client Errors, the API also returns descriptive error messages, such as:

  + `{"id": ["not found"]}`
  + `{"name": ["can't be blank"]}`
  + `{"name": ["has already been taken"]}`
  + `{"advertiser"=>["can't be blank", "must exist"]}`
  + `{"price"=>["can't be blank", "is not a number"]}`
  + `{"role"=>["can't be blank", "is not included in the list"]}`

## Resources

Each section below describes a class of resource within the scope of this system, as well as an example JSON representation of that resource, and a list of operations available to be performed on that resource.



















### `Instrument`

A musical instrument.

Attributes:

name | type | description
--- | --- | ---
name | String | The instrument name.
description | Text | A description of the instrument.

Endpoints:

Action | Request Method | Endpoint URL
---	|	---	|	---
List | GET | /instruments
Create | POST | /instruments
Show | GET | /instruments/:id
Update | PUT | /instruments/:id
Destroy | DELETE | /instruments/:id

Example POST/PUT request body:

```` js
{
  name: "Sitar",
  description: "The sitar is a plucked stringed instrument used mainly in Hindustani music and Indian classical music."
}
````

### `Advertiser`

An organization seeking a targeted audience for their product advertisement(s).

Attributes:

name | type | description
--- | --- | ---
name | String | The organization's name.
description | Text | A description of the organization.
url | String | The organization's website.

Endpoints:

Action | Request Method | Endpoint URL
---	|	---	|	---
List | GET | /advertisers
Create | POST | /advertisers
Show | GET | /advertisers/:id
Update | PUT | /advertisers/:id
Destroy | DELETE | /advertisers/:id

Example POST/PUT request body:

```` js
{
  name: "Fendie",
  description: "The leader in Sitar manufacturing and distribution.",
  url: "https://www.fendie.com/"
}
````

### `Ad`

A message promoting an advertiser's product or service.

Attributes:

name | type | description
--- | --- | ---
advertiser_id | Integer | References the advertiser who placed this ad.
title | String | A display title.
content | Text | The ad's content.
url | String | Where the ad redirects the user.
image_url | String | The ad's image source.

Endpoints:

Action | Request Method | Endpoint URL
---	|	---	|	---
List | GET | /ads
Create | POST | /ads
Show | GET | /ads/:id
Update | PUT | /ads/:id
Destroy | DELETE | /ads/:id

Example POST/PUT request body:

```` js
{
  advertiser_id: 1,
  title: "Buy a Fendie",
  content: "Fendie sitars are the best.",
  url: "https://www.fendie.com/promo",
  image_url: "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg"
}
````

### `AdPlacement`

Describes a period of time during which an ad is visible to users.

Attributes:

name | type | description
--- | --- | ---
ad_id | Integer | References the ad.
start_date | Date | The first day an ad should be visible to users.
end_date | Date | The last day an ad should be visible to users.
price | Integer (cents USD) | How much the advertiser is paying to run this ad during this period of time.

Endpoints:

Action | Request Method | Endpoint URL
---	|	---	|	---
List | GET | /ad_placements
Create | POST | /ad_placements
Show | GET | /ad_placements/:id
Update | PUT | /ad_placements/:id
Destroy | DELETE | /ad_placements/:id

Example POST/PUT request body:

```` js
{
  ad_id: 1,
  start_date: "2017-07-01",
  end_date: "2017-07-08",
  price: 25000
}
````

### `AdInstrument`

Associates ads with instruments.

Attributes:

name | type | description
--- | --- | ---
ad_id | Integer | References the ad.
instrument_id | Integer | References the instrument.

Endpoints:

Action | Request Method | Endpoint URL
---	|	---	|	---
Create | POST | /ads_instruments
Destroy | DELETE | /ads_instruments/:id

Example POST/PUT request body:

```` js
{
  ad_id: 1,
  instrument_id: 1,
}
````





























### `User`

Depending on the user's `role`, he/she can be either
  a music student seeking further instruction (`User`),
  an artist providing musical instruction (`Artist`), or
  an admin overseeing the site (`Admin`).
A user's role can be changed, but a user can not have more than one role at any given time.

A user can have varying levels of access to site content and features depending on his/her `access_level`. By default, artists and admins have full access.

Attributes:

name | type | description
--- | --- | ---
email | String | The user's email address, to be used for authentication and communication.
password | String | An encrypted version of the user's password used for authentication.
confirmed | Boolean | Whether or not the user has clicked the link sent to them in a confirmation email. If `true`, the user's email address is verified.
visible | Boolean | Whether or not the user should be displayed on the site. Indicates if a user or artist is active, or whether he/she has been deactivated. Deactivation allows ToneBase to retain the user record while allowing the user to not participate in the site.
role | String | The user's role (one of: `"User"`, `"Artist"`, or `"Admin"`).
access_level | String | Further specifies the actions a user can perform (one of: `"Full"` or `"Limited"`).
first_name | String | The user's first name or nickname.
last_name | String | The user's last name or surname.
bio | Text | A description of user interests, skills, and goals.
image_url | String | The user's profile image source.
hero_url | String | The user's hero/background image source.
customer_uuid | String | References the payment service's customer resource.
oauth | Boolean | Indicates if another service authenticates this user.
oauth_provider | String | The other service which authenticates this user (i.e. `"Google"`, `"Facebook"`, etc.).

Endpoints:

Action | Request Method | Endpoint URL | Comments
---	|	---	| --- | ---
List | GET | /users | Returns all users by default, regardless of role. Optionally supply a `role` parameter (e.g. `/users?role=User`) to get a subset of users assigned to the specified role.
Create | POST | /users | N/A
Show | GET | /users/:id | N/A
Update | PUT | /users/:id | N/A
Destroy | DELETE | /users/:id | N/A

Example POST/PUT request body:

```` js
{
  email: "avg.joe@gmail.com",
  password: "abc123",
  confirmed: true,
  visible: true,
  role: "User",
  access_level: "Full",
  first_name: "Joe",
  last_name: "Averaggi",
  bio: "I love guitar and I'm hoping to get better!",
  image_url: "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg",
  hero_url: "https://my-bucket.s3.amazonaws.com/my-dir/hero-image.jpg",
  customer_uuid: "cus_abc123def45678",
  oauth: true,
  oauth_provider: "Google",
}
````

### `Artist`

Reference [`User`](#user) documentation.

### `Admin`

Reference [`User`](#user) documentation.

### `UserFollowship`

Allows one user to follow another.

Attributes:

name | type | description
--- | --- | ---
user_id | Integer | References the user who is following another.
followed_user_id | Integer | References the user who is followed by another. The followed is most likey an artist.

Endpoints:

Action | Request Method | Endpoint URL
---	|	---	|	---
Create | POST | /user_followships
Destroy | DELETE | /user_followships/:id

Example POST/PUT request body:

```` js
{
  user_id: 2,
  followed_user_id: 1,
}
````












































### `Video`

An audio-visual recording of an artist's music instructions.

Attributes:

name | type | description
--- | --- | ---
user_id | Integer | References the user (artist) who posted this video.
instrument_id | Integer | References the instrument of instruction.
title | String | A display title.
description | String | A display title.
image_url | String | A display image source.
tags | Array | A list of descriptive tags for further classification. Enables robust video search capabilities.

Endpoints:

Action | Request Method | Endpoint URL
---	|	---	|	---
List | GET | /videos
Create | POST | /videos
Show | GET | /videos/:id
Update | PUT | /videos/:id
Destroy | DELETE | /videos/:id

Example POST/PUT request body:

```` js
{
  user_id: 1,
  instrument_id:1,
  title: "Finale from Sonata #99",
  description: "The final moments of master composer Maestrelli's most famous piece. Composed in 1817.",
  tags: ["borouque", "maestrelli", "g-major"]
}
````
