json.extract! weather_information, :id, :zip_code, :data, :created_at, :updated_at
json.url weather_information_url(weather_information, format: :json)
