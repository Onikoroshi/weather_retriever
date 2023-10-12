Rails.application.routes.draw do
  resources :weather_informations
  root 'weather_informations#new'
end
