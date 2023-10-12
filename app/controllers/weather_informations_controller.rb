class WeatherInformationsController < ApplicationController
  before_action :set_weather_information, only: %i[ show edit update destroy ]

  # GET /weather_informations or /weather_informations.json
  def index
    @weather_informations = WeatherInformation.all
  end

  # GET /weather_informations/1 or /weather_informations/1.json
  def show
  end

  # GET /weather_informations/new
  def new
    @weather_information = WeatherInformation.new
  end

  # GET /weather_informations/1/edit
  def edit
  end

  # POST /weather_informations or /weather_informations.json
  def create
    data = OpenWeatherService.new.retrieve_weather_info_by_zip_code(weather_information_params[:zip_code])
    @weather_information = WeatherInformation.new(weather_information_params)
    @weather_information.data = data

    respond_to do |format|
      if @weather_information.save
        format.html { redirect_to weather_information_url(@weather_information), notice: "Weather information was successfully created." }
        format.json { render :show, status: :created, location: @weather_information }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @weather_information.errors, status: :unprocessable_entity }
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

    # Only allow a list of trusted parameters through.
    def weather_information_params
      params.require(:weather_information).permit(:zip_code, :data)
    end
end
