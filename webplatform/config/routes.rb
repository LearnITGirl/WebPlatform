Webplatform::Application.routes.draw do
  root 'home#index'
  get 'subscribe' => 'subscribe#index'
  post 'subscribe/subscribe' => 'subscribe#subscribe'
end
