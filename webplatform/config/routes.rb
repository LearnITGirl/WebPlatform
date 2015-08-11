Webplatform::Application.routes.draw do
  root 'home#index'

  resources :mentors do
    resources :build, controller: 'mentors/build'
  end
end
