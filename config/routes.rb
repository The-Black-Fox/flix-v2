Rails.application.routes.draw do
  root 'movies#index'
  get '/movies' => 'movies#index'
end
