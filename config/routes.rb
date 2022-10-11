Rails.application.routes.draw do
  
  resources :categories, param: :slug  

  #delete '/categories/:slug', to: 'categories#destroy'
  #patch '/categories/:slug', to: 'categories#update'
  #post '/categories', to: 'categories#create'
  #get '/categories/new', to: 'categories#new', as: :new_category
  #get '/categories', to: 'categories#index'
  #get '/categories/:slug', to: 'categories#show', as: :category
  #get '/categories/:slug/edit', to: 'categories#edit', as: :edit_category

  resources :products, path: '/'

end
