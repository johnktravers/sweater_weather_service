class Geocode
  attr_reader :address, :lat, :long

  def initialize(info)
    if info[:results].first
      @address = info[:results][0][:formatted_address]
      @lat = info[:results][0][:geometry][:location][:lat]
      @long = info[:results][0][:geometry][:location][:lng]
    end
  end
end
