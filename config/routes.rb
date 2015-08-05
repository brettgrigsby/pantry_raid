Rails.application.routes.draw do
  root 'welcome#index'

  get '/profile', to: 'users#show'

  resources :recipes, only: [:show, :index]

  get '/auth/facebook/callback', to: 'sessions#create'
  get '/auth/facebook', as: :login
  delete '/logout', to: 'sessions#destroy'

end
