Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources :users, only: [:show, :create, :destroy]

  resources :orders, only: [] do 
    collection do 
      get 'shipt_search/:id' => :shipt_search
    end
  end 

  resources :orderitems, only: [:index]

  resources :products, except: [:new, :edit] do 
    collection do 
      post 'add_categories/:id' => :add_categories
    end 
  end 

  # resources :categories, only: [:index, :create, :destory, :edit]

  
end
