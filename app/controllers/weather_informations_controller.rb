class WeatherInformationsController < ApplicationController
  before_action :set_weather_information, only: %i[ show edit update destroy ]
  before_action :blank_weather_information, only: %i[ new create ]

  # GET /weather_informations or /weather_informations.json
  def index
    @weather_informations = WeatherInformation.all
  end

  # GET /weather_informations/1 or /weather_informations/1.json
  def show
    @given_address = params[:given_address]
  end

  # GET /weather_informations/new
  def new
  end

  # GET /weather_informations/1/edit
  def edit
  end

  # POST /weather_informations or /weather_informations.json
  def create
    respond_to do |format|
      begin
        @weather_information = WeatherInformation.build_information(weather_information_params)
        from_cache = @weather_information.from_cache?

        if @weather_information.save
          format.html { redirect_to weather_information_url(@weather_information, given_address: weather_information_params[:given_address]), notice: "Weather information was successfully #{from_cache ? "retrieved from cache" : "added to cache"}." }
          format.json { render :show, status: :created, location: @weather_information }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @weather_information.errors, status: :unprocessable_entity }
        end
      rescue => e
        ap e.message
        ap e.backtrace
        error_message = "Malformed Address. Please choose one of the suggestions"
        flash[:error] = error_message
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: error_message, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weather_informations/1 or /weather_informations/1.json
  def update
    respond_to do |format|
      if @weather_information.update(weather_information_params)
        format.html { redirect_to weather_information_url(@weather_information), notice: "Weather information was successfully updated." }
        format.json { render :show, status: :ok, location: @weather_information }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @weather_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_informations/1 or /weather_informations/1.json
  def destroy
    @weather_information.destroy

    respond_to do |format|
      format.html { redirect_to weather_informations_url, notice: "Weather information was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather_information
      @weather_information = WeatherInformation.find(params[:id])
    end

    def blank_weather_information
      @weather_information = WeatherInformation.new
    end

    # Only allow a list of trusted parameters through.
    def weather_information_params
      params.require(:weather_information).permit(:postal_code, :country_code, :latitude, :longitude, :data, :given_address)
    end
end
