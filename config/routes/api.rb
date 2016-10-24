Webplatform::Application.routes.draw do
  namespace :api do
    resources :mentee_applications, only: [:create]
  end
end
