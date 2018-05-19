Rails.application.routes.draw do
  root 'sessions#home'

  get '/auth/:provider/callback', to: 'sessions#login', as: 'auth_callback'
  get '/logout', to: 'sessions#logout', as: 'logout'

  resources :pieces
end
