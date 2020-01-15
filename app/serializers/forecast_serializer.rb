class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  attributes :address,
             :timezone,
             :current_weather,
             :hourly_weather,
             :daily_weather

  attribute :timezone { |forecast| forecast.timezone.identifier }
end
