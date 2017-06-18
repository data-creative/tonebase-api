json.extract! user_favorite_video, :id

json.favorite_video user_favorite_video.video, :id, :title

json.favorited_at user_favorite_video.created_at
