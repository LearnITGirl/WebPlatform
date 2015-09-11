Webplatform::Application.routes.draw do
  root 'home#index'
  get  "first-edition" => "home#firstEditionProjects"
end
