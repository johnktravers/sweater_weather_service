class Api::V1::ForecastsController < ApplicationController
  def show
    geocode = get_geocode(params[:location])
    forecast = get_forecast(geocode.lat, geocode.long, geocode.address)
    serialized_forecast = ForecastSerializer.new(forecast)
    render json: serialized_forecast
  end

  private

  def get_geocode(location)
    geocode_service = GoogleGeocodingService.new
    geocode_info = geocode_service.get_geocode_info(location)
    Geocode.new(geocode_info)
  end

  def get_forecast(lat, long, address)
    dark_sky_service = DarkSkyService.new
    forecast_info = dark_sky_service.get_forecast_info(lat, long)
    Forecast.new(forecast_info, address)
  end
end
