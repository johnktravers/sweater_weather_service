module WebmockHelpers
  def stub_unsplash_api(query, json_file)
    url = "https://api.unsplash.com/search/photos?client_id=#{ENV['UNSPLASH_CLIENT_ID']}&orientation=landscape&per_page=1&query=#{query}"
    json_response = File.read("spec/fixtures/#{json_file}")
    stub_request(:get, url).to_return(status: 200, body: json_response)
  end

  def stub_geocoding_api(location, json_file)
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{ENV['GOOGLE_GEOCODING_API_KEY']}"
    json_response = File.read("spec/fixtures/#{json_file}")
    stub_request(:get, url).to_return(status: 200, body: json_response)
  end

  def stub_dark_sky_api(latlong, json_file)
    url = "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/#{latlong}?exclude=minutely,alerts,flags"
    json_response = File.read("spec/fixtures/#{json_file}")
    stub_request(:get, url).to_return(status: 200, body: json_response)
  end

  def stub_maps_api(origin, destination, json_file)
    url = "https://maps.googleapis.com/maps/api/directions/json?destination=#{destination}&key=#{ENV['GOOGLE_MAPS_API_KEY']}&origin=#{origin}"
    json_response = File.read("spec/fixtures/#{json_file}")
    stub_request(:get, url).to_return(status: 200, body: json_response)
  end
end
