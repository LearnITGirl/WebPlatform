Webplatform::Application.routes.draw do

  root 'home#index'
  resources :organisers, only: [:index, :create] do
    collection do
      get :dashboard
    end
  end

  resources :organiser_registrations, only: [ :edit, :update]
  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout

  resource :user_sessions, only: [:create]
  resources :newsletters, only: [:create]
  get  "first_edition" => "home#first_edition_projects"
  get "sponsors" => "home#sponsors"
  #get "mentee_dashboard" => "mentee_profiles#dashboard"
  #post "mentee_dashboard/missing_mentor" => "mentee_profiles#missing_mentor"

  resources :mentee_profiles, only: [:show] do
    collection do
      get :dashboard
      post :missing_mentor
    end
  end
  resource :mentor_profile, only: [:show] do
    collection do
      get :dashboard
    end
  end

  resources :mentor_applications do
    resources :build, controller: 'mentor_applications/build'
  end

  resources :mentee_applications do
    resources :build, controller: 'mentee_applications/build'
  end

  resources :password_resets
  resources :polls, only: [:create]
  resources :email_templates do
    collection do
      post :search
    end
    member do
      post :deliver
    end
  end
end
