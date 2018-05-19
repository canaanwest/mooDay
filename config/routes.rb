Rails.application.routes.draw do
  root 'sessions#root'

  get '/auth/:provider/callback', to: 'sessions#login', as: 'auth_callback'
  get '/logout', to: 'sessions#logout', as: 'logout'

  resources :pieces
  get '/redirect', to: 'sessions#redirect', as: "redirect"
  get '/callback', to: 'sessions#callback', as: "callback"
  get '/calendars', to: 'sessions#calendars', as: "calendars"
end
