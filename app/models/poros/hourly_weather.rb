class HourlyWeather < Weather
  attr_reader :time, :temp

  def initialize(info, timezone)
    super
    @time = parse_local_time(info[:time], timezone)
    @temp = info[:temperature].round.to_s + '°'
  end

  private

  def parse_local_time(unix_time, timezone)
    utc_time = Time.at(unix_time).utc.to_datetime
    local_time = timezone.utc_to_local(utc_time)
    local_time.strftime('%l %p')
  end
end
