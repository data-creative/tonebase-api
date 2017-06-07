json.extract! user, :id, :email, :password, :confirmed, :visible, :role, :access_level,
  :first_name, :last_name, :bio, :image_url, :hero_url,
  :customer_uuid,
  :oauth, :oauth_provider,
  :profile, :music_profile

json.follows user.follows, :id, :username, :image_url

json.followers user.followers, :id, :username, :image_url

json.favorite_videos user.favorite_videos, :id, :title

json.extract! user, :created_at, :updated_at
