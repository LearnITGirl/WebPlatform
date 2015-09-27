Webplatform::Application.routes.draw do

  resource :user_sessions
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
