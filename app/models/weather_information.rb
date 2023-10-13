class WeatherInformation < ApplicationRecord
  attr_accessor :latitude, :longitude, :given_address

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
