class OpenWeatherService
  def client
    @client ||= OpenWeather::Client.new(
      api_key: Rails.application.credentials.open_weather[:api_key]
    )
  end

  def retrieve_weather_info_by_postal_code(postal_code)
    client.current_weather(zip: postal_code, country: "US")
  end

  def retrieve_weather_info_by_lat_lng(latitude, longitude)
    client.current_weather(lat: latitude, lon: longitude)
  end
end
