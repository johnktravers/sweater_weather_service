class Antipode
  attr_reader :lat, :long, :search_location, :location_name, :forecast

  def initialize(info, search_location)
    @lat = info[:attributes][:lat]
    @long = info[:attributes][:long]
    @search_location = search_location
    @location_name = nil
    @forecast = nil
  end

  def set_location_name(info)
    @location_name = info[:results][-2][:formatted_address]
  end

  def set_forecast(info)
    @forecast = Forecast.new(info, location_name)
  end
end
