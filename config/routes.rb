Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :restaurants
  resources :categories
  resources :products
  resources :tables
  
  get "restaurants/:id/qrcode", to: "restaurants#qr_code", as: :restaurant_qr_code
  get "tables/:id/qrcode", to: "tables#qr_code", as: :table_qr_code
  get "users/:id/dashboard", to: "users#manager_dashboard", as: :manager_dashboard
  root to: "home#index" 
end
