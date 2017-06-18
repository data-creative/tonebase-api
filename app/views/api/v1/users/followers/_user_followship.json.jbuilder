json.extract! user_followship, :id

json.follower user_followship.user, :id, :username, :image_url

json.followed_at user_followship.created_at
