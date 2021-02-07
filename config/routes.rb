Rails.application.routes.draw do
  root "home#index"
  devise_for :users

  resources :friend_requests, only: %i[create update] do
    collection do
      get :pending
      get :accepted
      get :rejected
    end
  end

  resources :users, only: :index
  resources :locations, only: %i[create new]

  get "/timeline", to: "home#timeline"
  get "/:id", to: "users#show"
end
