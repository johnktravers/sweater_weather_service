class AmypodeService
  def get_antipode_info(geocode)
    url = 'https://amypode.herokuapp.com/api/v1/antipodes'
    response = Faraday.get(url) do |req|
      req.params['lat'] = geocode.lat
      req.params['long'] = geocode.long
      req.headers['api_key'] = ENV['AMYPODE_API_KEY']
    end

    JSON.parse(response.body, symbolize_names: true)[:data]
  end
end
