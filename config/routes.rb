Rails.application.routes.draw do
  resources :users
  resources :posts
  resources :comments, only: :create

  root 'sessions#new'

  get 'logout', to: 'sessions#destroy', as: 'logout'

  post '/sessions', to: 'sessions#create'

  get '/sign_up', to: 'users#new', as: 'sign_up'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy]
      resources :posts, only: [:index, :create, :show, :update, :destroy]
      resources :comments, only: [:index, :create, :show, :update, :destroy]
    end
  end
end
