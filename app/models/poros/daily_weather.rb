class DailyWeather < Weather
  attr_reader :time, :temp_high, :temp_low, :precip_probability, :precip_type

  def initialize(info, timezone)
    super
    @time = parse_local_time(info[:time], timezone)
    @temp_high = info[:temperatureHigh].round.to_s + '°'
    @temp_low = info[:temperatureLow].round.to_s + '°'
    @precip_probability = (info[:precipProbability] * 100).to_i.to_s + '%'
    @precip_type = info[:precipType]
  end

  private

  def parse_local_time(unix_time, timezone)
    utc_time = Time.at(unix_time).utc.to_datetime
    local_time = timezone.utc_to_local(utc_time)
    local_time.strftime('%A, %m/%d')
  end
end
