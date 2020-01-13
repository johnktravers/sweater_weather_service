Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast',  to: 'forecasts#show'
      get '/antipode',  to: 'antipodes#show'
    end
  end
end
