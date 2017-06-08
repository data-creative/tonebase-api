json.extract! video, :id, :title, :description, :tags

json.parts video.parts, :source_url, :number, :duration

json.scores video.scores, :image_url, :starts_at, :ends_at

json.artist video.user, :id, :username, :image_url

json.instrument video.instrument, :id, :name, :description

json.favorited_by video.favorited_by_users, :id, :username, :image_url

json.recently_viewed_by video.recently_viewed_by_users, :id, :username, :image_url

json.extract! video, :created_at, :updated_at
