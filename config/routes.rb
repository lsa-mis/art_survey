Rails.application.routes.draw do
  resources :users
  resources :page_informations
  resources :annotations, except: :destroy
  get 'art_item_images/index'
  resources :art_items do
    resources :art_item_images, only: :index
  end  
  resources :accesses
  resources :permissions
  resources :departments
  resources :appraisal_types
  resources :roles

  get 'art_items/delete_file_attachment/:id', to: 'art_items#delete_file_attachment', as: :delete_file

  get 'static_pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "static_pages#home"

  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks", sessions: "users/sessions"} do
    delete 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
  end
end
