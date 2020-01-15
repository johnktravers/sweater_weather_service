require 'rails_helper'

RSpec.describe DarkSkyService, type: :service do
  it 'can retrieve forecast info given a latitude and longitude' do
    stub_dark_sky_api('39.7392358,-104.990251', 'denver_forecast.json')

    service = DarkSkyService.new
    forecast_info = service.get_forecast_info(39.7392358, -104.990251)

    expect(forecast_info[:timezone]).to eq('America/Denver')

    expect(forecast_info[:currently][:summary]).to eq('Clear')
    expect(forecast_info[:currently][:icon]).to eq('clear-night')
    expect(forecast_info[:currently][:temperature]).to eq(39.34)
    expect(forecast_info[:currently][:humidity]).to eq(0.27)
    expect(forecast_info[:currently][:uvIndex]).to eq(0)

    expect(forecast_info[:hourly][:data][0][:summary]).to eq('Clear')
    expect(forecast_info[:hourly][:data][0][:icon]).to eq('clear-night')

    expect(forecast_info[:daily][:data][0][:summary]).to eq('Clear throughout the day.')
    expect(forecast_info[:daily][:data][0][:precipProbability]).to eq(0.03)
    expect(forecast_info[:daily][:data][0][:precipType]).to eq('snow')

    expect(forecast_info[:currently].keys.length).to eq(19)
    expect(forecast_info[:hourly][:data].length).to eq(49)
    expect(forecast_info[:daily][:data].length).to eq(8)
  end

  it 'can retrieve future forecast info for given coordinates' do
    stub_dark_sky_api('38.2542053,-104.6087488,1579068027', 'pueblo_forecast.json')

    service = DarkSkyService.new
    forecast_info = service.get_future_forecast_info(38.2542053, -104.6087488, 1579068027)

    expect(forecast_info[:timezone]).to eq('America/Denver')
    expect(forecast_info[:currently].keys.length).to eq(18)

    expect(forecast_info[:currently][:summary]).to eq('Clear')
    expect(forecast_info[:currently][:icon]).to eq('clear-night')
    expect(forecast_info[:currently][:temperature]).to eq(36.42)
    expect(forecast_info[:currently][:humidity]).to eq(0.33)
    expect(forecast_info[:currently][:uvIndex]).to eq(0)
  end
end
