Webplatform::Application.routes.draw do

  get 'organiser' =>'organiser#index'

  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout
  
  resource :user_sessions, only: [:create]
  root 'home#index'

  resources :mentor_applications do
    resources :build, controller: 'mentor_applications/build'
  end

  resources :mentee_applications do
    resources :build, controller: 'mentee_applications/build'
  end
  

  resources :password_resets
end
