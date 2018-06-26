Rails.application.routes.draw do
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :account_activations, only: [:edit]
  resources :products, only: [:index, :show]
  
  namespace :admin do
    get "/", to: "dashbroads#index"
    resources :categories
    resources :products
  end

  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :orders
end
