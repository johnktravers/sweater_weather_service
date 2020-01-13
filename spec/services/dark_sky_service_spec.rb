require 'rails_helper'

RSpec.describe DarkSkyService, type: :service do
  it 'can retrieve forecast info given a latitude and longitude' do
    service = DarkSkyService.new
    forecast_info = service.get_forecast_info(39.7392358, -104.990251)

    expect(forecast_info[:timezone]).to eq('America/Denver')
    expect(forecast_info[:currently].keys.length).to eq(19)
    expect(forecast_info[:hourly][:data].length).to eq(49)
    expect(forecast_info[:daily][:data].length).to eq(8)
  end
end
