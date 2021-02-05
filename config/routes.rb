Rails.application.routes.draw do
  devise_for :users

  resources :friend_requests, only: [] do
    collection do
      get :pending
      get :accepted
      get :rejected
    end
  end

  root "home#index"
end
