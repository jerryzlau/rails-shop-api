Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :create, :destroy]

  resources :orders, only: [:create, :destroy, :edit]

  resources :products, only: [:create, :destroy, :edit]

  resources :categories, only: [:create, :destory, :edit]
  
end
