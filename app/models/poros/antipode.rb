class Antipode
  attr_reader :id, :lat, :long, :search_location, :location_name, :forecast

  def initialize(info, search_location)
    @id = 1
    @lat = info[:attributes][:lat]
    @long = info[:attributes][:long]
    @search_location = search_location
    @location_name = nil
    @forecast = nil
  end

  def set_location_name(info)
    address = find_city_name(info)
    @location_name = address
  end

  def set_forecast(info)
    @forecast = Forecast.new(info, location_name)
  end

  private

  def find_city_name(info)
    info[:results].find do |address_info|
      address_types = address_info[:address_components][0][:types]
      address_types.include?('locality') || address_types.include?('administrative_area_level_1')
    end[:formatted_address]
  end
end
