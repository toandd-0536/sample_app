Rails.application.routes.draw do
  root "static_pages#home"
  get "static_pages/home"
  get "static_pages/help"
  resources :users
  resources :account_activations, only: :edit
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
