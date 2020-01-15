class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  attributes :location,
             :today_summary,
             :tonight_summary,
             :temp_high,
             :temp_low,
             :current_weather,
             :hourly_weather,
             :daily_weather
end
