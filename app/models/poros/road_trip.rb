class RoadTrip
  attr_reader :id,
              :origin,
              :destination,
              :end_lat,
              :end_long,
              :travel_time,
              :arrival_time,
              :arrival_forecast

  def initialize(info)
    @id = rand(10000)
    @origin = info[:start_address]
    @destination = info[:end_address]
    @end_lat = info[:end_location][:lat]
    @end_long = info[:end_location][:lng]
    @travel_time = info[:duration][:text]
    @arrival_time = info[:duration][:value] + Time.now.to_i
    @arrival_forecast = nil
  end

  def set_arrival_forecast(info)
    @arrival_forecast = Forecast.new(info, destination)
  end
end
