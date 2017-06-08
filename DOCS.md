# Web Service Documentation

This document provides a reference for how the Client Application should expect to interface with the API Server. See also:

  + [Entity Relationship Diagram](/erd.png)
  + [Example Client Application (Express)](https://github.com/s2t2/tonebase-api-client-example)

## Requests

The API's current operating version is `v1`, so all endpoint URLs in this document assume a prefix of `/api/v1`.

### Authorization

The API only fulfills authorized requests. To send an authorized request, pass a valid client token in the request headers, for example:

    curl https://tonebase-api.herokuapp.com/api/v1/hello -H 'Authorization: Token token="abc123"'

    curl https://tonebase-api.herokuapp.com/api/v1/instruments -H 'Authorization: Token token="abc123"'

    curl https://tonebase-api.herokuapp.com/api/v1/instruments -H 'Authorization: Token token="abc123"' -H 'Content-Type: application/json' -X POST -d '{"name":"My instrument","description":"Produces musical sounds."}'

    curl https://tonebase-api.herokuapp.com/api/v1/users/search?query[email]=search4me@gmail.com -H 'Authorization: Token token="abc123"' --globoff

## Responses

The API uses the following HTTP response codes:

code | major status | minor status | description
--- | --- | --- | ---
200 | Success | OK | The resource(s) were returned successfully. Or the resource was updated successfully.
201 | Success | Created | The resource was created successfully.
204 | Success | No Content | The resource was destroyed successfully.
400 | Client Error | Bad Request | Make sure you are passing the correct URL parameters. If you are using a "search" endpoint, make sure you are passing a `query` URL parameter.
401 | Client Error | Unauthorized | The API requires you to pass an access token in the headers. Ensure you are passing a valid token.
404 | Client Error | Not found | The resource wasn't found. Ensure the resource identifier is correct and other parameter values are valid.
422 | Client Error | Unprocessable | You tried to create or update a resource but something went wrong. Maybe there are validation errors.

### Error Messages

When there are Client Errors, the API also returns descriptive error messages, such as:

  + `{"id": ["not found"]}`
  + `{"name": ["can't be blank"]}`
  + `{"name": ["has already been taken"]}`
  + `{"advertiser": ["can't be blank", "must exist"]}`
  + `{"price": ["can't be blank", "is not a number"]}`
  + `{"role": ["can't be blank", "is not included in the list"]}`

## Resources

Each section below describes a class of resource within the scope of this system, as an example JSON representation of that resource, and a list of operations available to be performed on that resource.

Each resource contains the attributes `id`, `created_at`, and `updated_at`, in addition to the other attributes listed below.


















### `Instrument`

A musical instrument.

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

Attributes:

name | type | description
--- | --- | ---
name | String | The instrument name.
description | Text | A description of the instrument.

### `Advertiser`

An organization seeking a targeted audience for their product advertisement(s).

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

Attributes:

name | type | description
--- | --- | ---
name | String | The organization's name.
description | Text | A description of the organization.
url | String | The organization's website.

### `Ad`

A message promoting an advertiser's product or service.

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

Attributes:

name | type | description
--- | --- | ---
advertiser_id | Integer | References the advertiser who placed this ad.
title | String | A display title.
content | Text | The ad's content.
url | String | Where the ad redirects the user.
image_url | String | The ad's image source.

### `AdPlacement`

Describes a period of time during which an ad is visible to users.

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

Attributes:

name | type | description
--- | --- | ---
ad_id | Integer | References the ad.
start_date | Date | The first day an ad should be visible to users.
end_date | Date | The last day an ad should be visible to users.
price | Integer (cents USD) | How much the advertiser is paying to run this ad during this period of time.

### `AdInstrument`

Associates ads with instruments.

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

Attributes:

name | type | description
--- | --- | ---
ad_id | Integer | References the ad.
instrument_id | Integer | References the instrument.




























### `User`

Depending on the user's `role`, he/she can be either
  a music student seeking further instruction (`User`),
  an artist providing musical instruction (`Artist`), or
  an admin overseeing the site (`Admin`).
A user's role can be changed, but a user can not have more than one role at any given time.

A user can have varying levels of access to site content and features depending on his/her `access_level`. By default, artists and admins have full access.

During the registration process, a user may provide self-identified demographic information and musical preferences.

Endpoints:

Action | Request Method | Endpoint URL | Comments
---	|	---	| --- | ---
List | GET | /users | Returns all users by default, regardless of role. Optionally supply a `role` parameter (e.g. `/users?role=User`) to get a subset of users assigned to the specified role.
Create | POST | /users | N/A
Show | GET | /users/:id | N/A
Update | PUT | /users/:id | N/A
Destroy | DELETE | /users/:id | N/A
Search | GET | /users/search | Supply parameters matching user attributes (e.g. `/users/search?query[email]=search4me@gmail.com`) to get a subset of matching users. This will always return an array of objects, even if there is only one match.

Example POST/PUT request body:

```` js
{
  email: "avg.joe@gmail.com",
  password: "abc123",
  username: "joe123",
  confirmed: true,
  visible: true,
  role: "User",
  access_level: "Full",
  customer_uuid: "cus_abc123def45678",
  oauth: true,
  oauth_provider: "Google",
  user_profile_attributes:{
    first_name: "Joe",
    last_name: "Averaggi",
    bio: "I love guitar and I'm hoping to get better!",
    image_url: "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg",
    hero_url: "https://my-bucket.s3.amazonaws.com/my-dir/hero-image.jpg",
    birth_year: 1975,
    professions: ["Student", "Performer", "Instructor"]
  },
  user_music_profile_attributes: {
    guitar_owned: true,
    guitar_models_owned: ["Gibson ABC", "Fender XYZ"],
    fav_composers: ["Bach"],
    fav_performers: ["Talenti"],
    fav_periods: ["Classical", "Contemporary", "Baroque"]
  }
}
````

> NOTE: for GET requests, `user_profile_attributes` is called `profile`, and `user_music_profile_attributes` is called `music_profile`.

Attributes:

name | type | description
--- | --- | ---
email | String | The user's email address, to be used for authentication and communication.
password | String | An encrypted version of the user's password used for authentication.
username | String | The user's unique nickname to be used for identification across the platform.
confirmed | Boolean | Whether or not the user has clicked the link sent to them in a confirmation email. If `true`, the user's email address is verified.
visible | Boolean | Whether or not the user should be displayed on the site. Indicates if a user or artist is active, or whether he/she has been deactivated. Deactivation allows ToneBase to retain the user record while allowing the user to not participate in the site.
role | String | The user's role (one of: `"User"`, `"Artist"`, or `"Admin"`).
access_level | String | Further specifies the actions a user can perform (one of: `"Full"` or `"Limited"`).
customer_uuid | String | References the payment service's customer resource.
oauth | Boolean | Indicates if another service authenticates this user.
oauth_provider | String | The other service which authenticates this user (i.e. `"Google"`, `"Facebook"`, etc.).

Profile Attributes:

name | type | description
--- | --- | ---
first_name | String | The user's first name or nickname.
last_name | String | The user's last name or surname.
bio | Text | A description of user interests, skills, and goals.
image_url | String | The user's profile image source.
hero_url | String | The user's hero/background image source.
birth_year | Integer | The user's year of birth.
professions | Array | A list of the user's professions.

Music Profile Attributes:

name | type | description
--- | --- | ---
guitar_owned | Boolean | Whether or not the user owns a guitar.
guitar_models_owned | Array | A list of guitars the user owns.
fav_composers | Array | A list of the user's favorite music composers.
fav_performers | Array | A list of the user's favorite music performers.
fav_periods | Array | A list of the user's favorite music periods.

### `Artist`

Reference [`User`](#user) documentation.

### `Admin`

Reference [`User`](#user) documentation.

### `UserFollowship`

Allows one user to follow another.

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

Attributes:

name | type | description
--- | --- | ---
user_id | Integer | References the user who is following another.
followed_user_id | Integer | References the user who is followed by another. The followed is most likey an artist.










































### `Video`

An audio-visual recording of an artist's music instructions.

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
  tags: ["borouque", "maestrelli", "g-major"],
  video_parts_attributes:[
    {source_url: "https://www.youtube.com/watch?v=abc123", number: 1, duration: 333},
    {source_url: "https://www.youtube.com/watch?v=def456", number: 2, duration: 333},
    {source_url: "https://www.youtube.com/watch?v=ghi789", number: 3, duration: 333}
  ],
  video_scores_attributes:[
    {image_url: "https://my-bucket.s3.amazonaws.com/my-dir/score-1-image.jpg", starts_at: 25, ends_at: 500},
    {image_url: "https://my-bucket.s3.amazonaws.com/my-dir/score-2-image.jpg", starts_at: 750, ends_at: 999}
  ]
}
````

Attributes:

name | type | description
--- | --- | ---
user_id | Integer | References the user (artist) who posted this video.
instrument_id | Integer | References the instrument of instruction.
title | String | A display title.
description | Text | A description of the video.
tags | Array | A list of descriptive tags for further classification. Enables robust video search capabilities.

Video Part Attributes:

name | type | description
--- | --- | ---
video_id | Integer | References the global video of which it is a part.
source_url | String | References a video resource on the video service.
number | Integer | The sort order of this video part (e.g. 1, 2, 3). The "X" in "Part number X of Y".
duration | Integer (seconds) | The length of the video part in seconds.

Video Score Attributes:

name | type | description
--- | --- | ---
video_id | Integer | References the global video of which it is a part.
image_url | String | References the score's image source.
starts_at | Integer (seconds) | Begin displaying the score when the global video duration reaches this duration. The minimum should be `1`.
ends_at | Integer (seconds) | Stop displaying the score after the global video duration reaches this duration. The maximum should be equal to the global video's duration.

### `UserFavoriteVideo`

Allows a user to mark a video as being one of their favorites.

Endpoints:

Action | Request Method | Endpoint URL
---	|	---	|	---
Create | POST | /user_favorite_videos
Destroy | DELETE | /user_favorite_videos/:id

Example POST/PUT request body:

```` js
{
  user_id: 40,
  video_id: 13
}
````

Attributes:

name | type | description
--- | --- | ---
user_id | Integer | References the user who likes this video.
video_id | Integer | References the video being liked.

### `UserViewVideo`

An event logged by the client application when a user views a video. The most ideal time to log one of these events is when the user starts viewing the video, else perhaps when the user visits the video show page, but be consistent. Really this resource just provides a benchmark for comparing against in-depth analytics provided by the video service.

Endpoints:

Action | Request Method | Endpoint URL
---	|	---	|	---
List | GET | /user_view_videos
Create | POST | /user_view_videos

Example POST/PUT request body:

```` js
{
  user_id: 40,
  video_id: 13
}
````

Attributes:

name | type | description
--- | --- | ---
user_id | Integer | References the user who viewed this video.
video_id | Integer | References the video being viewed.
