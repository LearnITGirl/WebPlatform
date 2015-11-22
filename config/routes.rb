Webplatform::Application.routes.draw do


  #get 'organisers_registration/create'

  #get 'organisers_registration/update'

  root 'home#index'
  resources :organisers, only: [:index]
  resources :organisers_registration, only: [:create, :edit, :update]
  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout

  resource :user_sessions, only: [:create]
  resources :subscription, only: [:index, :create]
  get  "first_edition" => "home#first_edition_projects"
  get "sponsors" => "home#sponsors"
  get  "mentee_dashboard" => "mentee_profiles#dashboard"

  resource :mentee_profile, only: [:show]

  resources :mentor_applications do
    resources :build, controller: 'mentor_applications/build'
  end

  resources :mentee_applications do
    resources :build, controller: 'mentee_applications/build'
  end

  resources :password_resets
end
