class UnsplashService
  def get_image_info(location)
    response = Faraday.get('https://api.unsplash.com/search/photos') do |req|
      req.params['client_id'] = ENV['UNSPLASH_CLIENT_ID']
      req.params['query'] = location
      req.params['per_page'] = 1
      req.params['orientation'] = 'landscape'
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
