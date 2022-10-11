Rails.application.routes.draw do
  
  resources :categories, param: :slug  
  resources :products, path: '/'

end
