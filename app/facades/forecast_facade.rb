class ForecastFacade
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def create_forecast
    geocode = get_geocode(location)
    get_forecast(geocode.lat, geocode.long, geocode.address)
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
