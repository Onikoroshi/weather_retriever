require "application_system_test_case"

class WeatherInformationsTest < ApplicationSystemTestCase
  setup do
    @weather_information = weather_informations(:one)
  end

  test "visiting the index" do
    visit weather_informations_url
    assert_selector "h1", text: "Weather information"
  end

  test "should create weather information" do
    visit weather_informations_url
    click_on "New weather information"

    fill_in "Data", with: @weather_information.data
    fill_in "Zip code", with: @weather_information.postal_code
    click_on "Create Weather information"

    assert_text "Weather information was successfully created"
    click_on "Back"
  end

  test "should update Weather information" do
    visit weather_information_url(@weather_information)
    click_on "Edit this weather information", match: :first

    fill_in "Data", with: @weather_information.data
    fill_in "Zip code", with: @weather_information.postal_code
    click_on "Update Weather information"

    assert_text "Weather information was successfully updated"
    click_on "Back"
  end

  test "should destroy Weather information" do
    visit weather_information_url(@weather_information)
    click_on "Destroy this weather information", match: :first

    assert_text "Weather information was successfully destroyed"
  end
end
