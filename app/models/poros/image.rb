class Image
  attr_reader :id, :url, :photographer_name, :photographer_url

  def initialize(info)
    @id = rand(10000)
    if info[:results].first
      search_image(info)
    else
      default_image(info)
    end
  end

  private

  def search_image(info)
    @url = info[:results][0][:urls][:raw]
    @photographer_name = info[:results][0][:user][:name]
    @photographer_url = info[:results][0][:user][:portfolio_url]
  end

  def default_image(info)
    @url = 'https://images.unsplash.com/photo-1528872042734-8f50f9d3c59b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjExMDU5Mn0'
    @photographer_name = 'Agustinus Nathaniel'
    @photographer_url = 'https://agustinusnathaniel.com'
  end
end
