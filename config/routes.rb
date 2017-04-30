Rails.application.routes.draw do
  devise_for :users
  root to: "scores#index"

  resources :games, only: [:new, :create, :index]
  resources :scores, only: [:index]
end
