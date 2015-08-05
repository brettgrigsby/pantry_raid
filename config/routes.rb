Rails.application.routes.draw do
  root 'welcome#index'

  get '/profile', to: 'users#show'
end
