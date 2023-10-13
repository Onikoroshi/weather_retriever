require "test_helper"

class WeatherInformationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weather_information = weather_informations(:one)
  end

  test "should get new" do
    get new_weather_information_url
    assert_response :success
  end

  test "should create weather_information" do
    expected_hash = { "hello" => "there" }
    weather_service_stub = Minitest::Mock.new
    weather_service_stub.expect :retrieve_weather_info_by_lat_lng, expected_hash, [String, String]

    OpenWeatherService.stub :new, weather_service_stub do
      assert_difference("WeatherInformation.count") do
        post weather_informations_url, params: { weather_information: { latitude: "234", longitude: "432", postal_code: "1235456", country_code: "US" } }
      end

      assert_redirected_to weather_information_url(WeatherInformation.last)
    end
  end

  test "should show weather_information" do
    get weather_information_url(@weather_information)
    assert_response :success
  end
end
