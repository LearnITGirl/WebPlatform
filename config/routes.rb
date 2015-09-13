Webplatform::Application.routes.draw do


  root 'home#index'
  resources :organisers, only: [:index, :create]
  resources :organiser_registrations, only: [ :edit, :update]
  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout

  resource :user_sessions, only: [:create]
  resources :newsletters, only: [:create]
  get  "first_edition" => "home#first_edition_projects"
  get "sponsors" => "home#sponsors"
  get  "mentee_dashboard" => "mentee_profiles#dashboard"

  resource :mentee_profile, only: [:show]

  get "evaluation_panel" => "organizer#organizer_evaluation_panel"
  get "user_home_page" => "organizer#user_home_page"

  resources :mentor_applications do
    resources :build, controller: 'mentor_applications/build'
  end

  resources :mentee_applications do
    resources :build, controller: 'mentee_applications/build'
  end

  resources :password_resets
  resources :polls, only: [:create]
end
