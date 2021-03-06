Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/facebook/callback', to: 'sessions#create'
  get '/auth/facebook', as: :login
  delete '/logout', to: 'sessions#destroy'

  get '/profile', to: 'users#show'

  get '/order', to: 'orders#show'

  get '/pantry', to: 'pantries#show'
  put '/pantry', to: 'pantries#update'

  get '/possibilities', to: 'recipes#possibilities'

  resources :pantry_ingredients, only: [:create]

  resources :orders, only: [:new, :create, :index]

  resources :recipes, only: [:show, :index, :new, :create, :edit] do
    resources :recipe_steps, only: [:new, :create]
    resources :recipe_ingredients, only: [:new, :create]
    resources :menu_recipes, only: [:new, :create, :destroy]
  end
end
