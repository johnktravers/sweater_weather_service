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
    forecast = Forecast.new(info, location_name)
    @forecast = AntipodeForecast.new(forecast)
  end

  private

  def find_city_name(info)
    if antipode_exists?(info)
      address = info[:results].find { |address_info| city_address?(address_info) }
      address[:formatted_address]
    end
  end

  def antipode_exists?(info)
    return false if !info[:results][0]
    address_comps = info[:results][0][:address_components]
    !address_comps[0][:types].include?('natural_feature')
  end

  def city_address?(address_info)
    address_types = address_info[:address_components][0][:types]
    address_types.include?('locality') || address_types.include?('administrative_area_level_1')
  end
end
