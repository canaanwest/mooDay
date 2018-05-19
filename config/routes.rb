Rails.application.routes.draw do
  root 'sessions#root'
  #
  # get '/auth/:provider/callback', to: 'sessions#login', as: 'auth_callback'
  get '/logout', to: 'sessions#logout', as: 'logout'

  resources :pieces
  get '/login', to: 'sessions#login', as: "login"
  get '/callback', to: 'sessions#callback', as: "callback"
  get '/events', to: 'sessions#events', as: 'events'
  # get '/calendars', to: 'sessions#calendars', as: "calendars"
end
