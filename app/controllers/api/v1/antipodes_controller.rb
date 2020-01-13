class Api::V1::AntipodesController < ApplicationController
  def show
    geocode = get_geocode(params[:location])
    antipode = get_antipode(geocode)
    get_antipode_name(antipode)
    if antipode.location_name
      get_antipode_forecast(antipode)
      serialized_antipode = AntipodeSerializer.new(antipode)
      render json: serialized_antipode
    else
      render json: antipode_error, status: 404
    end
  end

  private

  def get_geocode(location)
    geocode_service = GoogleGeocodingService.new
    geocode_info = geocode_service.get_geocode_info(location)
    Geocode.new(geocode_info)
  end

  def get_antipode(geocode)
    amypode_service = AmypodeService.new
    antipode_info = amypode_service.get_antipode_info(geocode)
    Antipode.new(antipode_info, geocode.address)
  end

  def get_antipode_name(antipode)
    geocode_service = GoogleGeocodingService.new
    location_info = geocode_service.get_location_info(antipode.lat, antipode.long)
    antipode.set_location_name(location_info)
  end

  def get_antipode_forecast(antipode)
    dark_sky_service = DarkSkyService.new
    forecast_info = dark_sky_service.get_forecast_info(antipode.lat, antipode.long)
    antipode.set_forecast(forecast_info)
  end

  def antipode_error
    { errors:
      [{
        status: '404 Not Found',
        title: 'The given location does not have an existing antipode. Please try another location.'
      }]
    }.to_json
  end
end
