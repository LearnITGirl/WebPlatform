Webplatform::Application.routes.draw do

  root 'home#index'
  resources :organisers, only: [:index, :create, :destroy, :edit, :update] do
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
  get "mentor_dos_and_donts" => "home#mentor_dos_and_donts"
  get "mentee_dos_and_donts" => "home#mentee_dos_and_donts"
  get "faq" => "home#faq"
  get "timeline" => "home#timeline"
  get "learning_material/php" => "learning_material#php"

  resources :mentee_profiles, only: [:show, :edit, :update] do
    collection do
      get :dashboard
      post :dashboard
      post :missing_mentor
    end
  end
 
  post 'tasks/create'
  post 'tasks/destroy'
  post 'tasks/update'
  resources :tasks

  get "mentor_evaluation/:application_id" => "evaluations#mentor", as: "mentor_evaluation"
  get "mentee_evaluation/:application_id" => "evaluations#mentee", as: "mentee_evaluation"
  post "evaluation/:application_id" => "evaluations#create_evaluation"
  get "evaluation/:application_id/skip" => "evaluations#skip", as: "skip_evaluation"
  get "evaluation/:application_id/cancel" => "evaluations#cancel", as: "cancel_evaluation"
  patch "evaluation/reject_mentee" => "evaluations#reject_mentee", as: :reject_mentee_application
  patch "evaluation/reject_mentor" => "evaluations#reject_mentor", as: :reject_mentor_application

  resources :mentor_profiles, only: [:show] do
    collection do
      get :dashboard
      post :missing_mentee
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
