class WeatherInformation < ApplicationRecord
  attr_accessor :latitude, :longitude, :given_address, :recached

  def self.build_information(weather_information_params)
    info = self.find_or_initialize_by(postal_code: weather_information_params[:postal_code], country_code: weather_information_params[:country_code])

    if info.ready_to_recache?
      data = OpenWeatherService.new.retrieve_weather_info_by_lat_lng(weather_information_params[:latitude], weather_information_params[:longitude])
      info.data = data
      info.recached = true
    end

    info
  end

  def ready_to_recache?
    new_record? || updated_at < 30.minutes.ago
  end

  def from_cache?
    true != recached
  end

  def temperature
    return nil if data.blank?
    kelvin = data.dig("main", "temp")
    farenheit = ((kelvin.to_f - 273.15) * 9 / 5 + 32).round(2) unless kelvin.nil?
  end

  def humidity
    return nil if data.blank?
    data.dig("main", "humidity")
  end

  def wind_speed
    return nil if data.blank?
    metric = data.dig("wind", "speed")
    miles_per_hour = (metric.to_f * 2.23694).round(2) unless metric.nil?
  end

  def wind_direction_degrees
    return nil if data.blank?
    data.dig("wind", "deg")
  end

  def sky_description
    return nil if data.blank?
    data.dig("weather", 0, "description")
  end

  def sky_icon_uri
    return nil if data.blank?
    data.dig("weather", 0, "icon_uri")
  end
end
