Webplatform::Application.routes.draw do
  root 'home#index'
  get  "first-edition" => "home#firstEditionProjects"

  resources :mentor_applications do
    resources :build, controller: 'mentor_applications/build'
  end

  resources :mentee_applications do
    resources :build, controller: 'mentee_applications/build'
  end
end
