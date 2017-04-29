Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :games, only: [:new, :create, :index]
end
