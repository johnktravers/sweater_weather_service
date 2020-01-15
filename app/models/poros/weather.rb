class Weather
  attr_reader :summary, :icon

  def initialize(info, timezone)
    @summary = info[:summary]
    @icon = info[:icon]
  end
end
