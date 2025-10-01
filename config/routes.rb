Rails.application.routes.draw do
  get 'users', to: 'users#index', as: 'users'
  get 'users/:id', to: 'users#show', as: 'user'
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
  resources :reports, only: [] do
    collection do
      get :art_items
    end
  end

  get 'art_items/delete_file_attachment/:id', to: 'art_items#delete_file_attachment', as: :delete_file

  get 'static_pages/home'

  # Sentry test endpoint (only available in staging and production)
  if Rails.env.staging? || Rails.env.production?
    get 'sentry-test', to: 'static_pages#sentry_test'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "static_pages#home"

  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks", sessions: "users/sessions"} do
    delete 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
  end
end
