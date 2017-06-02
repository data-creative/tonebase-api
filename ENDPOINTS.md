The web service documentation has moved to [DOCS.md](/DOCS.md).

For now, this document contains a table of endpoints planned but not yet implemented.

Dev Group	| Primary Resource | Action | Request Method | Endpoint URL
---	|	---	|	---	|	---	|	---
1-Core	|	Artist (User)	|	1-List | GET | /api/artists
1-Core	|	Artist (User)	|	3-Show	|	GET	|	/api/artists/:id
1-Core	|	Artist (User)	|	4-Update	|	PUT	|	/api/artists/:id
1-Core	|	Artist (User)	|	5-Destroy	|	DELETE	|	/api/artists/:id
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
