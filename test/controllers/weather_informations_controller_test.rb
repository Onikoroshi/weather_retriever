require "test_helper"

class WeatherInformationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weather_information = weather_informations(:one)
  end

  test "should get index" do
    get weather_informations_url
    assert_response :success
  end

  test "should get new" do
    get new_weather_information_url
    assert_response :success
  end

  test "should create weather_information" do
    assert_difference("WeatherInformation.count") do
      post weather_informations_url, params: { weather_information: { data: @weather_information.data, zip_code: @weather_information.zip_code } }
    end

    assert_redirected_to weather_information_url(WeatherInformation.last)
  end

  test "should show weather_information" do
    get weather_information_url(@weather_information)
    assert_response :success
  end

  test "should get edit" do
    get edit_weather_information_url(@weather_information)
    assert_response :success
  end

  test "should update weather_information" do
    patch weather_information_url(@weather_information), params: { weather_information: { data: @weather_information.data, zip_code: @weather_information.zip_code } }
    assert_redirected_to weather_information_url(@weather_information)
  end

  test "should destroy weather_information" do
    assert_difference("WeatherInformation.count", -1) do
      delete weather_information_url(@weather_information)
    end

    assert_redirected_to weather_informations_url
  end
end
