Webplatform::Application.routes.draw do
  #get 'user_sessions/new'

  #get 'user_sessions/create'

  #get 'user_sessions/destroy'

  resources :user_sessions
  root 'home#index'

  resources :mentor_applications do
    resources :build, controller: 'mentor_applications/build'
  end

  resources :mentee_applications do
    resources :build, controller: 'mentee_applications/build'
  end
  
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
end
