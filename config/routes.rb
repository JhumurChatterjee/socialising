Rails.application.routes.draw do
  devise_for :users

  resources :friend_requests, only: %i[create update] do
    collection do
      get :pending
      get :accepted
      get :rejected
    end
  end

  resources :users, only: :index

  root "home#index"
end
