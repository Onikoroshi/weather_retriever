class WeatherInformation < ApplicationRecord
  attr_accessor :latitude, :longitude, :given_address, :cached

  def self.build_information(weather_information_params)
    info = self.find_or_initialize_by(postal_code: weather_information_params[:postal_code], country_code: weather_information_params[:country_code])

    if info.ready_to_recache?
      data = OpenWeatherService.new.retrieve_weather_info_by_lat_lng(weather_information_params[:latitude], weather_information_params[:longitude])
      info.data = data
      info.cached = true
    end

    info
  end

  def ready_to_recache?
    new_record? || updated_at < 30.minutes.ago
  end

  def from_cache?
    true != cached
  end

  def temperature
    kelvin = data["main"]["temp"].to_f
    farenheit = ((kelvin - 273.15) * 9 / 5 + 32).round(2)
  end

  def humidity
    data["main"]["humidity"]
  end

  def wind_speed
    metric = data["wind"]["speed"]
    miles_per_hour = (metric * 2.23694).round(2)
  end

  def wind_direction_degrees
    data["wind"]["deg"]
  end

  def sky_description
    data["weather"][0]["description"]
  end

  def sky_icon_uri
    data["weather"][0]["icon_uri"]
  end
end
