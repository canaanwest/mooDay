Rails.application.routes.draw do
  root 'sessions#home'

  get '/auth/:provider/callback', to: 'sessions#login', as: 'login'
  get '/logout', to: 'sessions#logout', as: 'logout'

  resources :pieces
end
