class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :address,
             :latitude,
             :longitude,
             :timezone,
             :current_weather,
             :hourly_weather,
             :daily_weather

  attribute :timezone { |forecast| forecast.timezone.identifier }
end
