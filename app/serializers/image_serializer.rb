class ImageSerializer
  include FastJsonapi::ObjectSerializer

  attributes :url, :photographer_name, :photographer_url
end
