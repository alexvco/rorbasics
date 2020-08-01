json.extract! user, :id, :email, :type, :first_name, :last_name, :created_at, :updated_at
json.url user_url(user, format: :json)
