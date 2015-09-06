Webplatform::Application.routes.draw do
  root 'home#index'

  resources :mentor_applications do
    resources :build, controller: 'mentor_applications/build'
  end
end
