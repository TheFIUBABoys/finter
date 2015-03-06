Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'home#index'

  get 'home/index'
  get 'home/sendmail'

  resources :topics, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      get 'follow'
      get 'unfollow'
    end
    resources :notifications, only: [:create]
  end
  resources :notifications, only: [:show, :create, :destroy]
end
