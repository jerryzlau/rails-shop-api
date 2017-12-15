Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources :users, only: [:show, :create, :destroy]

  resources :orders, only: [] do 
    collection do 
      get 'shipt_search/:id' => :shipt_search
    end
  end 

  # resources :products, only: [:index, :create, :destroy, :edit]

  # resources :categories, only: [:index, :create, :destory, :edit]

  
end
