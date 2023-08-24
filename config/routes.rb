Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/new'
  get 'categories/create'
  get 'categories/edit'
  get 'categories/update'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :restaurants
  resources :categories
  
  get "users/:id/dashboard", to: "users#manager_dashboard", as: :manager_dashboard
  root to: "home#index" 
end
