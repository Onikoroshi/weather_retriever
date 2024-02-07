class WeatherInformationsController < ApplicationController
  before_action :set_weather_information, only: %i[ show ]
  before_action :blank_weather_information, only: %i[ new create ]

  def show
    @given_address = params[:given_address]
  end

  def new
  end

  def create
    respond_to do |format|
      begin
        # Code to run to use Rails cache
        # @weather_information = WeatherInformation.build_information_with_rails_cache(weather_information_params)

        # Code to run to use custom cache
        @weather_information = WeatherInformation.build_information(weather_information_params)

        from_cache = @weather_information.from_cache?

        if @weather_information.save
          # Code to run to use Rails cache
          # format.html {
          #   @given_address = weather_information_params[:given_address]
          #   flash[:notice] = "Weather information was successfully #{from_cache ? "retrieved from cache" : "added to cache"}."
          #   render :show, status: 422 # This is a hack to force turbolinks to render without redirecting. The full solution would likely involve disabling turbolinks in this particular situation.
          # }

          # Code to run to use custom cache
          format.html { redirect_to weather_information_url(@weather_information, given_address: weather_information_params[:given_address]), notice: "Weather information was successfully #{from_cache ? "retrieved from cache" : "added to cache"}." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      rescue => e
        ap e.message
        ap e.backtrace
        error_message = "Malformed Address. Please choose one of the suggestions"
        flash[:error] = error_message
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_weather_information
    @weather_information = WeatherInformation.find(params[:id])
  end

  def blank_weather_information
    @weather_information = WeatherInformation.new
  end

  def weather_information_params
    params.require(:weather_information).permit(:postal_code, :country_code, :latitude, :longitude, :data, :given_address)
  end
end
