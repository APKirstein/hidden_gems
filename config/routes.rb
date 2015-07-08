Rails.application.routes.draw do
  root 'restaurants#index'
  devise_for :users

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :restaurants, only: [:index, :destroy]
    resources :reviews, only: [:destroy]
  end

  resources :restaurants do
    resources :reviews, only: [:new, :create, :show, :destroy]
  end
end
