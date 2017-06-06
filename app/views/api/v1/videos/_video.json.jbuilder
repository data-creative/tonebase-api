json.extract! video, :id

json.artist video.user, :id, :username, :image_url

json.instrument video.instrument, :id, :name, :description

json.favorited_by video.favorited_by_users, :id, :username, :image_url

json.extract! video, :title, :description, :tags, :created_at, :updated_at
