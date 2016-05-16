Webplatform::Application.routes.draw do


  root 'home#index'
  resources :organisers, only: [:index, :create, :destroy, :edit, :update] do
    collection do
      get :dashboard
      get :problematic_projects
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
  get "roadmap_example" => "home#roadmap_example"
  get "about_us" => "home#about_us"

  get "learning_materials/git" => "learning_materials#git", as: "git_learning_materials"
  get "learning_materials/ruby" => "learning_materials#ruby", as: "ruby_learning_materials"
  get "learning_materials/php" => "learning_materials#php", as: "php_learning_materials"
  get "learning_materials/java" => "learning_materials#java", as: "java_learning_materials"
  get "learning_materials/android" => "learning_materials#android", as: "android_learning_materials"
  get "learning_materials/python" => "learning_materials#python", as: "python_learning_materials"
  get "learning_materials/c_plus_plus" => "learning_materials#c_plus_plus", as: "c_plus_plus_learning_materials"
  get "learning_materials/html_css_javascript" => "learning_materials#html_css_javascript", as: "html_css_javascript_learning_materials"
  get "learning_materials/r" => "learning_materials#r", as: "r_learning_materials"
  get "learning_materials/c" => "learning_materials#c", as: "c_learning_materials"
  get "learning_materials/sql" => "learning_materials#sql", as: "sql_learning_materials"
  get "learning_materials/swift" => "learning_materials#swift", as: "swift_learning_materials"
  get "learning_materials/mongo_db" => "learning_materials#mongo_db", as: "mongo_db_learning_materials"
  get "learning_materials/c_sharp" => "learning_materials#c_sharp", as: "c_sharp_learning_materials"
  get "learning_materials/vb_dot_net" => "learning_materials#vb_dot_net", as: "vb_dot_net_learning_materials"

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

  resources :mentor_applications do
    resources :build, controller: 'mentor_applications/build'
  end

  resources :mentee_applications do
    resources :build, controller: 'mentee_applications/build'
  end

  resources :user_registrations
  resources :mentor_to_mentee_matchers do
    collection do
      post :match
    end
    member do
      put :accept_pair
      put :reject_mentee
      put :reject_mentor
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
  get "midterm_evaluations/:project_id" => "midterm_evaluations#evaluate_project", as: "midterm_evaluation"
  patch "midterm_evaluations/:project_id" => "midterm_evaluations#update_project"
  
  resources :projects, only: [:show]
end
