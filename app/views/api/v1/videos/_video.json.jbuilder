json.extract! video, :id

json.artist video.user, :id, :username, :image_url

json.instrument video.instrument, :id, :name, :description

json.extract! video, :title, :description, :tags, :created_at, :updated_at
