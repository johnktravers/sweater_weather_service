class AntipodeSerializer
  include FastJsonapi::ObjectSerializer

  attributes :location_name, :forecast, :search_location

  attribute :forecast do |antipode|
    {
      summary: antipode.forecast.current_weather.summary,
      current_temp: antipode.forecast.current_weather.temp
    }
  end
end
