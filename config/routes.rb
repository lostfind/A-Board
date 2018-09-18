Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'forums#index'

  # get '/forums/(:name)-:id(.:format)', to: 'forums#show'
  resources :forums
  resources :posts
  resources :replies

  post 'posts/:id/edit(.:format)', to: 'posts#edit'
  post 'replies/:id/edit(.:format)', to: 'replies#edit'
  get '/quotes/:id', to: 'replies#quote'

  get '/search', to: 'search#index'
end
