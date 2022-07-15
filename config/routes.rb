Rails.application.routes.draw do
  resources :items
  devise_for :users#, controllers: {omniauth_callbacks: "users/omniauth_callbacks", sessions: "users/sessions"} do
  #   delete 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
  # end
  get 'static_pages/home'
  get 'static_pages/about'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :departments
  # Defines the root path route ("/")
  root to: "static_pages#home"
end
