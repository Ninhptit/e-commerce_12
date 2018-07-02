Rails.application.routes.draw do
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  get "/login/google", to: redirect("/auth/google_oauth2")
  get "login/facebook", to: redirect("/auth/facebook")
  post "/login", to: "sessions#create"
  get "/auth/:provider/callback", to: "sessions#callback"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :account_activations, only: :edit
  resources :products, only: %i(index show) do
    resources :comments, only: %i(create destroy)
  end
  
  namespace :admin do
    get "/", to: "dashbroads#index"
    resources :categories
    resources :products
    resources :promotions
    resources :type_products
  end

  resources :orders
  resources :order_details
  resources :password_resets, only: %i(new create edit update)
end
