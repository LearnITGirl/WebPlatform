Webplatform::Application.routes.draw do

  root 'home#index'

  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout

  resource :user_sessions, only: [:create]
  get  "first_edition" => "home#first_edition_projects"
  get "sponsors" => "home#sponsors"
  get  "mentee-profile" => "mentee_profile#index"
  get  "mentee-dashboard" => "mentee_profile#dashboard"

  resources :mentor_applications do
    resources :build, controller: 'mentor_applications/build'
  end

  resources :mentee_applications do
    resources :build, controller: 'mentee_applications/build'
  end

  resources :password_resets
end
