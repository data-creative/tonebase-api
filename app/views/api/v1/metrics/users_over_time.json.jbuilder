json.array! @users do |user|
  json.user_id user.id
  json.registered_at user.created_at
  json.current_role user.role
  json.current_access_level user.access_level
end
