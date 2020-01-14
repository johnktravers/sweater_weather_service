class RoadTripSerializer
  include FastJsonapi::ObjectSerializer

  attributes :origin, :destination, :travel_time

  attribute :arrival_forecast do |road_trip|
    {
      local_time: road_trip.arrival_forecast.current_weather.time,
      temperature: road_trip.arrival_forecast.current_weather.temp,
      summary: road_trip.arrival_forecast.current_weather.summary
    }
  end
end
