Rails.application.routes.draw do
  root 'restaurants#index'
  devise_for :users

  resources :restaurants

  get '/reviews/test' => 'reviews#test'

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :restaurants, only: [:index, :destroy]
    resources :reviews, only: [:index, :destroy]
  end

  resources :restaurants do
    resources :reviews, only: [:new, :create, :show] do
      member do
        put "like", to: "reviews#upvote"
        put "dislike", to: "reviews#downvote"
      end
    end
  end
end
