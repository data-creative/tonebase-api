json.extract! user, :id, :email, :password, :username, :confirmed, :visible, :role, :access_level,
  :customer_uuid,
  :oauth, :oauth_provider

#if user.user_profile
#  json.profile user.user_profile, :first_name, :last_name, :bio, :image_url, :hero_url, :birth_year, :professions
#else
#  json.profile({})
#end # or more simply ... json.profile user.user_profile_attributes
json.profile user.user_profile_attributes

#if user.user_music_profile
#  json.music_profile user.user_music_profile, :guitar_owned, :guitar_models_owned, :fav_composers, :fav_performers, :fav_periods
#else
#  json.music_profile({})
#end # or more simply ... json.music_profile user.user_music_profile_attributes
json.music_profile user.user_music_profile_attributes

json.follows user.follows, :id, :username, :image_url

json.followers user.followers, :id, :username, :image_url

json.favorite_videos user.favorite_videos, :id, :title

json.extract! user, :created_at, :updated_at
