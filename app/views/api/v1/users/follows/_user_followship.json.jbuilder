json.extract! user_followship, :id

json.followed_user user_followship.followed_user, :id, :username, :image_url

json.followed_at user_followship.created_at
