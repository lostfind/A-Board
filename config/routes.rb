Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'forums#index'

  # get '/forums/(:name)-:id(.:format)', to: 'forums#show'
  resources :forums
  resources :posts
  resources :replies

  get '/quotes/:id', to: 'replies#quote'
end
