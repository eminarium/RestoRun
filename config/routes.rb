Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :restaurants
  get "users/:id/dashboard", to: "users#manager_dashboard", as: :manager_dashboard
  root to: "home#index" 
end
