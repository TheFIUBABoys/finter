Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'home#index'

  get 'home/index'
  get 'topics/follow/:id', to: 'topics#follow', as: 'follow_topic'
  get 'topics/unfollow/:id', to: 'topics#unfollow', as: 'unfollow_topic'

  resources :topics, only: [:index, :show]
  resources :notifications, only: [:show, :create, :destroy]
end
