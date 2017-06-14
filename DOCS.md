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

Example GET response:

```` js
{
  "id":1,
  "name":"Guitar",
  "description":"A musical instrument classified as a fretted string instrument with anywhere from four to 18 strings, usually having six.",
  "created_at":"2017-06-11T18:16:10.778Z",
  "updated_at":"2017-06-11T18:16:10.791Z"
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

Example GET response:

```` js
{
  "id":1,
  "name":"Fendie",
  "description":"The leader in Sitar manufacturing and distribution.",
  "url":"https://www.fendie.com/",
  "created_at":"2017-06-12T19:58:08.222Z",
  "updated_at":"2017-06-12T19:58:08.497Z"
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

Example GET response:

```` js
{
  "id":1,
  "title":"Buy a Fendie",
  "content":"Fendie sitars are the best.",
  "url":"https://www.fendie.com/promo",
  "image_url":"https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg",
  "created_at":"2017-06-12T20:06:01.327Z",
  "updated_at":"2017-06-12T20:06:11.733Z",
  "advertiser":{
    "id":1,
    "name":"Fendie",
    "description":"The leader in Sitar manufacturing and distribution.",
    "url":"https://www.fendie.com/"
  },
  "instruments":[
    {
      "id":1,
      "name":"Guitar",
      "description":"A musical instrument classified as a fretted string instrument with anywhere from four to 18 strings, usually having six."
    }
  ]
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

Example GET response:

```` js
{
  "id":1,
  "ad":{
    "id":1,
    "title":"Buy a Fendie",
    "content":"Fendie sitars are the best.",
    "url":"https://www.fendie.com/promo",
    "image_url":"https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg"
  },
  "start_date":"2017-07-01",
  "end_date":"2017-07-08",
  "price":25000,
  "created_at":"2017-06-12T20:11:50.830Z",
  "updated_at":"2017-06-12T20:11:50.830Z"
}
````





























### `User`

Depending on the user's `role`, he/she can be either
  a music student seeking further instruction (`User`),
  an artist providing musical instruction (`Artist`), or
  an admin overseeing the site (`Admin`).
A user's role can be changed, but a user can not have more than one role at any given time.

A user can have varying levels of access to site content and features depending on his/her `access_level`. By default, artists and admins have full access.

During the registration process, a user may provide self-identified demographic information and musical preferences.

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

`UserProfile` Attributes:

name | type | description
--- | --- | ---
first_name | String | The user's first name or nickname.
last_name | String | The user's last name or surname.
bio | Text | A description of user interests, skills, and goals.
image_url | String | The user's profile image source.
hero_url | String | The user's hero/background image source.
birth_year | Integer | The user's year of birth.
professions | Array | A list of the user's professions.

`UserMusicProfile` Attributes:

name | type | description
--- | --- | ---
guitar_owned | Boolean | Whether or not the user owns a guitar.
guitar_models_owned | Array | A list of guitars the user owns.
fav_composers | Array | A list of the user's favorite music composers.
fav_performers | Array | A list of the user's favorite music performers.
fav_periods | Array | A list of the user's favorite music periods.

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

Example GET response:

```` js
{
  "id":139,
  "email":"avg.joe@gmail.com",
  "password":"abc123",
  "username":"joe123",
  "confirmed":true,
  "visible":true,
  "role":"User",
  "access_level":"Full",
  "customer_uuid":"cus_abc123def45678",
  "oauth":true,
  "oauth_provider":"Google",
  "profile":{
    "first_name":"Joe",
    "last_name":"Averaggi",
    "bio":"I love guitar and I'm hoping to get better!",
    "image_url":"https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg",
    "hero_url":"https://my-bucket.s3.amazonaws.com/my-dir/hero-image.jpg",
    "birth_year":1993,
    "professions":["Student"]
  },
  "music_profile":{
    "guitar_owned":true,
    "guitar_models_owned":["Gibson ABC","Fender XYZ"],
    "fav_composers":["Bach"],
    "fav_performers":["Talenti"],
    "fav_periods":["Classical","Contemporary","Baroque"]
  },
  "follows":[
    {"id":255,"username":"anotherPro15","image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"},
    {"id":258,"username":"anotherPro18","image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"},
    {"id":260,"username":"anotherPro20","image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"},
    {"id":268,"username":"anotherPro28","image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"}
  ],
  "followers":[],
  "favorite_videos":[
    {"id":12,"title":"Finale from Sonata #2"},
    {"id":15,"title":"Finale from Sonata #5"},
    {"id":16,"title":"Finale from Sonata #6"}
  ],
  "recently_viewed_videos":[
    {"video_id":18,"viewed_at":"2017-06-12T20:16:56.017Z"},
    {"video_id":12,"viewed_at":"2017-06-12T20:16:59.130Z"},
    {"video_id":18,"viewed_at":"2017-06-12T20:16:59.870Z"}
  ],
  "inbox":[
    { // refers to `user_notifications` join entity
      "id":227,
      "marked_read":false,
      "created_at":"2017-06-12T21:16:08.282Z",
      "updated_at":"2017-06-12T21:16:08.282Z",
      "notification":{
        "id":27,
        "broadcastable_type":"Video",
        "broadcastable_id":26,
        "event":"NewVideo",
        "headline":"Another Pro posted a new video. Watch it now!",
        "url":null
      }
    }
  ],
  "created_at":"2017-06-12T20:16:48.102Z",
  "updated_at":"2017-06-12T20:16:48.102Z"
}
````

### `Artist`

Reference [`User`](#user) documentation.

Example GET response:

```` js
{
  "id":264,
  "email":"talenti.pro@gmail.com",
  "password":"abc123",
  "username":"talentiPro",
  "confirmed":true,
  "visible":true,
  "role":"Artist",
  "access_level":"Full",
  "customer_uuid":null,
  "oauth":null,
  "oauth_provider":null,
  "profile":{
    "first_name":"Talenti",
    "last_name":"Pro",
    "bio":"My music. My passion.",
    "image_url": "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg",
    "hero_url": "https://my-bucket.s3.amazonaws.com/my-dir/hero-image.jpg",
    "birth_year":1975,
    "professions":["Performer", "Instructor"]
  },
  "music_profile":{},
  "follows":[],
  "followers":[
    {"id":142, "username":"another3", "image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"},
    {"id":178,"username":"another39","image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"},
    {"id":207,"username":"another68","image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"},
  ],
  "favorite_videos":[],
  "recently_viewed_videos":[],
  "notifications":[],
  "created_at":"2017-06-12T20:16:48.963Z",
  "updated_at":"2017-06-12T20:16:48.963Z"
}
````

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
description | Text | A description of the video.
tags | Array | A list of descriptive tags for further classification. Enables robust video search capabilities.

`VideoPart` Attributes:

name | type | description
--- | --- | ---
video_id | Integer | References the global video of which it is a part.
source_url | String | References a video resource on the video service.
number | Integer | The sort order of this video part (e.g. 1, 2, 3). The "X" in "Part number X of Y".
duration | Integer (seconds) | The length of the video part in seconds.

`VideoScore` Attributes:

name | type | description
--- | --- | ---
video_id | Integer | References the global video of which it is a part.
image_url | String | References the score's image source.
starts_at | Integer (seconds) | Begin displaying the score when the global video duration reaches this duration. The minimum should be `1`.
ends_at | Integer (seconds) | Stop displaying the score after the global video duration reaches this duration. The maximum should be equal to the global video's duration.

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

Example GET response:

```` js
{
  "id":13,
  "title":"Finale from Sonata #3",
  "description":"The final moments of master composer Maestrelli's most famous piece. Composed in 1820.",
  "tags":["borouque","maestrelli","g-major"],
  "parts":[
    {"source_url":"https://www.youtube.com/watch?v=abc123","number":1,"duration":333},
    {"source_url":"https://www.youtube.com/watch?v=def456","number":2,"duration":333},
    {"source_url":"https://www.youtube.com/watch?v=ghi789","number":3,"duration":333}
  ],
  "scores":[
    {"image_url":"https://my-bucket.s3.amazonaws.com/my-dir/score-1-image.jpg","starts_at":25,"ends_at":500},
    {"image_url":"https://my-bucket.s3.amazonaws.com/my-dir/score-2-image.jpg","starts_at":750,"ends_at":900}
  ],
  "artist":{
    "id":270,
    "username":"anotherPro30",
    "image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"
  },
  "instrument":{
    "id":1,
    "name":"Guitar",
    "description":"A musical instrument classified as a fretted string instrument with anywhere from four to 18 strings, usually having six."
  },
  "favorited_by":[
    {"id":235,"username":"another96","image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"},
    {"id":232,"username":"another93","image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"},
    {"id":208,"username":"another69","image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"}
  ],
  "viewed_by":[
    {"id":225,"username":"another86","image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"},
    {"id":194,"username":"another55","image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"},
    {"id":223,"username":"another84","image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"},
    {"id":187,"username":"another48","image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"}
  ],
  "created_at":"2017-06-12T20:16:50.978Z",
  "updated_at":"2017-06-12T20:16:50.978Z"
}
````

### `UserFavoriteVideo`

Allows a user to mark a video as being one of their favorites.

Attributes:

name | type | description
--- | --- | ---
user_id | Integer | References the user who likes this video.
video_id | Integer | References the video being liked.

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

### `UserViewVideo`

An event logged by the client application when a user views a video. The most ideal time to log one of these events is when the user starts viewing the video, else perhaps when the user visits the video show page, but be consistent. Really this resource just provides a benchmark for comparing against in-depth analytics provided by the video service.

Attributes:

name | type | description
--- | --- | ---
user_id | Integer | References the user who viewed this video.
video_id | Integer | References the video being viewed.


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

Example GET response:

```` js
{
  "user_id":151,
  "video_id":14,
  "viewed_at":"2017-06-12T20:16:55.092Z"
}
````














### `Notification`

An informational message about system activity which is auto-generated as a result of that activity occurring.

Attributes:

name | type | description
--- | --- | ---
broadcastable_type | string | References the kind of resource which triggered this notification (polymorphic).
broadcastable_id | Integer | References the resource which triggered this notification (e.g. a video).
event | String | Describes the kind of event that triggered this notification (e.g. `"NewVideo"`).
headline | String | The message title a user will see in their inbox.
url | String | An optional url to redirect a user who clicks on the headline in their inbox.


Endpoints:

Action | Request Method | Endpoint URL
---	|	---	|	---
List | GET | /notifications
Show | GET | /notifications/:id
Destroy | DELETE | /notifications/:id

Example GET response:

```` js
{
  "id":14,
  "broadcastable_type":"Video",
  "broadcastable_id":13,
  "event":"NewVideo",
  "headline":"Another Pro posted a new video. Watch it now!",
  "url":null,
  "notified_users":[
    {"id":230,"username":"another91","image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"},
    {"id":219,"username":"another80","image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"},
    {"id":179,"username":"another40","image_url":"https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"},
  ],
  "created_at":"2017-06-12T20:16:50.988Z",
  "updated_at":"2017-06-12T20:16:50.988Z"
}
````

### `UserNotification`

Enables a user to manage an inbox of notifications by marking each as "read" or "unread".

Attributes:

name | type | description
--- | --- | ---
user_id | Integer | References the user receiving the notification.
notification_id | Integer | References the notification.
marked_read | Boolean | Whether or not the user has marked the notification as being read. Default value is false.


Endpoints:

Action | Request Method | Endpoint URL
---	|	---	|	---
Update | PUT | /user_notifications/:id

Example PUT request body:

```` js
{
  user_id: 1,
  notification_id:1,
  marked_read: true
}
````

### `Announcement`

A message promoting system features, community events, etc.

Attributes:

name | type | description
--- | --- | ---
title | String | A display title.
content | Text | The announcement's message body.
url | String | Where the announcement redirects the user.
image_url | String | The announcement's image source.
broadcast | Boolean | Whether the announcement, upon initial creation only, should be broadcast to all users' notification inboxes.

Endpoints:

Action | Request Method | Endpoint URL
---	|	---	|	---
List | GET | /announcements
Create | POST | /announcements
Show | GET | /announcements/:id
Update | PUT | /ads/:announcements
Destroy | DELETE | /ads/:announcements

Example POST/PUT request body:

```` js
{
  title: "New Feature ABC",
  content: "This new feature allows you to do cool things.",
  url: "https://blog.tonebase.com/posts/new-feature-abc",
  image_url: "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg",
  broadcast: false
}
````

Example GET response:

```` js
{
  "id":5,
  "title":"Fill out our survey please!",
  "content":null,
  "url":"https://surveymonkey.com/surveys/abc",
  "image_url":null,
  "broadcast":true,
  "created_at":"2017-06-11T18:16:24.031Z",
  "updated_at":"2017-06-11T18:16:24.031Z"
}
````





























## Resourceless Endpoints

These endpoints are more REST-less than REST-full.

### Metrics

Endpoints:

Action | Request Method | Endpoint URL
---	|	---	|	---
N/A | GET | /metrics/users_total
N/A | GET | /metrics/users_over_time

#### Total Users

Example GET response:

```` js
{
  "total":50505
}
````

#### Users over Time

Example GET response:

```` js
[
  {"user_id": 1, "registered_at": "2017-06-11T18:16:24.031Z", "current_role":"Artist", "current_access_level":"Full"},
  {"user_id": 2, "registered_at": "2017-06-12T18:16:24.031Z", "current_role":"User", "current_access_level":"Limited"},
  {"user_id": 3, "registered_at": "2017-06-13T18:16:24.031Z", "current_role":"Admin", "current_access_level":"Full"},
]
````
