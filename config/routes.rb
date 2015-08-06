Rails.application.routes.draw do
  root 'welcome#index'

  get '/profile', to: 'users#show'
  get '/pantry', to: 'pantries#show'

  resources :recipes, only: [:show, :index, :new, :create, :edit] do
    resources :recipe_steps, only: [:new, :create]
    resources :recipe_ingredients, only: [:new, :create]
  end

  get '/auth/facebook/callback', to: 'sessions#create'
  get '/auth/facebook', as: :login
  delete '/logout', to: 'sessions#destroy'

end
