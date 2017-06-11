json.extract! notification, :id, :broadcastable_type, :broadcastable_id, :event, :headline, :url

json.notified_users notification.users, :id, :username, :image_url

json.extract! notification, :created_at, :updated_at
