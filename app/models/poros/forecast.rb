class Forecast
  attr_reader :id,
              :address,
              :latitude,
              :longitude,
              :timezone,
              :current_weather,
              :hourly_weather,
              :daily_weather

  def initialize(info, address)
    @id = rand(10000)
    @address = address
    @latitude = info[:latitude]
    @longitude = info[:longitude]
    @timezone = TZInfo::Timezone.get(info[:timezone])
    @current_weather = CurrentWeather.new(info[:currently], timezone)
    @hourly_weather = create_hourly_weather(info[:hourly][:data][0..24], timezone)
    @daily_weather = create_daily_weather(info[:daily][:data], timezone)
  end

  private

  def create_hourly_weather(info, timezone)
    info.map { |hourly_info| HourlyWeather.new(hourly_info, timezone) }
  end

  def create_daily_weather(info, timezone)
    info.map { |daily_info| DailyWeather.new(daily_info, timezone) }
  end
end
