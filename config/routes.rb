Rails.application.routes.draw do
  resources :art_items
  devise_for :users
  get 'static_pages/index'
  get 'static_pages/about'
  get 'static_pages/privacy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "static_pages#index"
end
