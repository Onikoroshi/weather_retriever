require "test_helper"

class WeatherInformationTest < ActiveSupport::TestCase
  def setup
    @info = weather_informations(:one)
  end

  test "building information from given params" do
    expected_hash = { "hello" => "there" }
    weather_service_stub = Minitest::Mock.new
    weather_service_stub.expect :retrieve_weather_info_by_lat_lng, expected_hash, [String, String]

    OpenWeatherService.stub :new, weather_service_stub do
      info = WeatherInformation.build_information({postal_code: "12345", country_code: "US", latitude: "123", longitude: "321"})

      assert_equal expected_hash, info.data
    end
  end

  test "ready to recache?" do
    # need to cache a new record
    @info = WeatherInformation.new
    assert @info.ready_to_recache?

    # but not a persisted one
    @info.save!
    refute @info.ready_to_recache?

    # need to cache an old record
    @info.update!(updated_at: 31.minutes.ago)
    assert @info.ready_to_recache?
  end

  test "from cache?" do
    # false if temp attribute is nil
    assert @info.from_cache?

    # false if temp attribute is false
    @info.recached = false
    assert @info.from_cache?

    # false if temp attribute is not a boolean
    @info.recached = "true"
    assert @info.from_cache?

    # true if temp attribute is true
    @info.recached = true
    refute @info.from_cache?
  end

  test "temperature" do
    # converted from 250 degrees kelvin
    assert_equal -9.67, @info.temperature

    # nil if no temp entry
    @info.data["main"].delete("temp")
    assert_nil @info.temperature

    # nil if no main entry
    @info.data.delete("main")
    assert_nil @info.temperature

    # nil if no data
    @info.data = nil
    assert_nil @info.temperature
  end

  test "humidity" do
    assert_equal "34", @info.humidity

    # nil if no humidity entry
    @info.data["main"].delete("humidity")
    assert_nil @info.humidity

    # nil if no main entry
    @info.data.delete("main")
    assert_nil @info.humidity

    # nil if no data
    @info.data = nil
    assert_nil @info.humidity
  end

  test "wind speed" do
    assert_equal 11.86, @info.wind_speed

    # nil if no wind_speed entry
    @info.data["wind"].delete("speed")
    assert_nil @info.wind_speed

    # nil if no wind entry
    @info.data.delete("wind")
    assert_nil @info.wind_speed

    # nil if no data
    @info.data = nil
    assert_nil @info.wind_speed
  end

  test "wind direction" do
    assert_equal "56", @info.wind_direction_degrees

    # nil if no wind_direction_degrees entry
    @info.data["wind"].delete("deg")
    assert_nil @info.wind_direction_degrees

    # nil if no wind entry
    @info.data.delete("wind")
    assert_nil @info.wind_direction_degrees

    # nil if no data
    @info.data = nil
    assert_nil @info.wind_direction_degrees
  end

  test "weather description" do
    assert_equal "clear skies", @info.sky_description

    # nil if no description entry
    @info.data["weather"][0].delete("description")
    assert_nil @info.sky_description

    # nil if no weather entries
    @info.data["weather"] = nil
    assert_nil @info.sky_description

    # nil if no weather entry
    @info.data.delete("weather")
    assert_nil @info.sky_description
  end

  test "sky icon URI" do
    assert_equal "http://openweathermap.org/img/wn/04n@2x.png", @info.sky_icon_uri

    # nil if no icon uri entry
    @info.data["weather"][0].delete("icon_uri")
    assert_nil @info.sky_icon_uri

    # nil if no weather entries
    @info.data["weather"] = nil
    assert_nil @info.sky_icon_uri

    # nil if no weather entry
    @info.data.delete("weather")
    assert_nil @info.sky_icon_uri
  end
end
