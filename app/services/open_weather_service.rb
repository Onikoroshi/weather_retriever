class OpenWeatherService
  def client
    @client ||= OpenWeather::Client.new(
      api_key: Rails.application.credentials.open_weather[:api_key]
    )
  end

  def retrieve_weather_info_by_zip_code(zip_code)
    client.current_weather(zip: zip_code, country: "US")
  end
end
