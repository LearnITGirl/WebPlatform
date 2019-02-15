class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Webplatform::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  draw :api

  root 'home#index'
  resources :organisers, only: [:index, :create, :destroy, :edit, :update] do
    collection do
      get :dashboard
      get :problematic_projects
      resources :skipped_applications, only: [:index]
    end
  end

  resources :organiser_registrations, only: [ :edit, :update]
  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout
  resources :award_badges, only: [:index, :create, :update]
  resources :assigned_badges, only: [:update]
  
  resource :user_sessions, only: [:create]
  resources :newsletters, only: [:create]
  get  "featured_first_edition_projects" => "home#first_edition_projects"
  get  "featured_second_edition_projects" => "home#second_edition_projects"
  get  "featured_third_edition_projects" => "home#third_edition_projects"
  get "sponsors" => "home#sponsors"
  get "mentor_dos_and_donts" => "home#mentor_dos_and_donts"
  get "mentee_dos_and_donts" => "home#mentee_dos_and_donts"
  get "faq" => "home#faq"
  get "timeline" => "home#timeline"
  get "roadmap_example" => "home#roadmap_example"
  get "about_us" => "home#about_us"
  get "privacy_policy" => "home#privacy_policy"

  resource :tutorial, only: [] do
    collection do
      get :tasks
    end
  end

  (%w'git ruby php java android python c_plus_plus html_css_javascript
   r c sql sqift mongo_db c_sharp vb_dot_net swift').each do |language|
    get "learning_materials/#{language}" => "learning_materials##{language}", as: "#{language}_learning_materials"
  end

  resources :users, only: [] do
    member do
      put :report_resignation
    end
  end

  resources :mentee_profiles, only: [:show, :edit, :update] do
    collection do
      get :dashboard
      post :dashboard
      post :missing_mentor
    end
    post "user_status" => "mentee_profiles#user_status"
  end

  resources :tasks do
    member do
      put :accept
    end
  end

  get "mentor_evaluation/:application_id" => "evaluations#mentor", as: "mentor_evaluation"
  get "mentee_evaluation/:application_id" => "evaluations#mentee", as: "mentee_evaluation"
  post "evaluation/:application_id" => "evaluations#create_evaluation"
  get "evaluation/:application_id/skip" => "evaluations#skip", as: "skip_evaluation"
  get "evaluation/:application_id/cancel" => "evaluations#cancel", as: "cancel_evaluation"
  patch "evaluation/reject_mentee" => "evaluations#reject_mentee", as: :reject_mentee_application
  patch "evaluation/reject_mentor" => "evaluations#reject_mentor", as: :reject_mentor_application

  resources :mentor_profiles, only: [:show, :edit, :update] do
    collection do
      get :dashboard
      post :missing_mentee
    end
    post "user_status" => "mentor_profiles#user_status"
  end

  resources :mentor_applications, only: [:new]
  resources :mentee_applications, only: [:new]

  resources :user_registrations
  resources :mentor_to_mentee_matchers do
    collection do
      post :match
      post :rematch
    end
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

  resource :mentee_midterm_evaluations, only: [:new, :create]
  resource :mentor_midterm_evaluations, only: [:new, :create]
  resource :final_survey

  get 'search/participants', to: 'search#participants', as: :search_participants

  resources :midterm_evaluations

  resources :projects, only: [:show]
  resources :exports, only: [] do
    collection do
      get :surveys
      get :final_results
    end
  end

  resources :badges, only: [:index]
end
