class Forecast
  attr_reader :id,
              :location,
              :timezone,
              :today_summary,
              :tonight_summary,
              :temp_high,
              :temp_low,
              :current_weather,
              :hourly_weather,
              :daily_weather

  def initialize(info, location)
    @id = rand(10000)
    @location = location
    @timezone = TZInfo::Timezone.get(info[:timezone])
    @current_weather = CurrentWeather.new(info[:currently], timezone)
    @hourly_weather = create_hourly_weather(info[:hourly][:data][0..23], timezone)
    @daily_weather = create_daily_weather(info[:daily][:data], timezone)
    @today_summary = info[:daily][:data][0][:summary]
    @tonight_summary = get_tonight_summary(info, timezone)
    @temp_high = info[:daily][:data][0][:temperatureHigh].round.to_s + '°'
    @temp_low = info[:daily][:data][0][:temperatureLow].round.to_s + '°'
  end

  private

  def create_hourly_weather(info, timezone)
    info.map { |hourly_info| HourlyWeather.new(hourly_info, timezone) }
  end

  def create_daily_weather(info, timezone)
    info.map { |daily_info| DailyWeather.new(daily_info, timezone) }
  end

  def get_tonight_summary(info, timezone)
    current_time = get_local_time(info[:currently][:time], timezone)
    current_hour = current_time.strftime('%H').to_i
    if current_hour < 20
      eight_pm_summary(info[:hourly][:data], timezone)
    else
      info[:hourly][:data][0][:summary]
    end
  end

  def get_local_time(unix_time, timezone)
    utc_time = Time.at(unix_time).utc.to_datetime
    timezone.utc_to_local(utc_time)
  end

  def eight_pm_summary(hourly_info, timezone)
    info = hourly_info.find do |hour_info|
      get_local_time(hour_info[:time], timezone).strftime('%H').to_i == 20
    end
    info[:summary]
  end
end
