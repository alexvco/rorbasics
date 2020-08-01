json.extract! image, :id, :filename, :imageable_id, :imageable_type, :created_at, :updated_at
json.url image_url(image, format: :json)
