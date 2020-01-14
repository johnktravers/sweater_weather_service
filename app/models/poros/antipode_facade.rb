class AntipodeFacade
  attr_reader :input_location

  def initialize(location)
    @input_location = location
  end

  def get_antipode
    geocode = get_geocode(input_location)
    antipode = get_antipode(geocode)
    get_antipode_name(antipode)
    get_antipode_forecast(antipode)
    antipode
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
end
