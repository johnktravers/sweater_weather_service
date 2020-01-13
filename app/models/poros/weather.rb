class Weather
  attr_reader :time, :summary, :icon

  def initialize(info, timezone)
    @time = get_local_time(info[:time], timezone)
    @summary = info[:summary]
    @icon = info[:icon]
  end

  private

  def get_local_time(unix_time, timezone)
    utc_time = Time.at(unix_time).utc.to_datetime
    timezone.utc_to_local(utc_time)
  end
end
