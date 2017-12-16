Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show, :create, :destroy]

  resources :orders, only: [:index, :create] do 
    collection do 
      get 'shipt_search/:id' => :shipt_search
    end
  end 

  resources :orderitems, only: [:index] do 
    collection do 
      get 'search_by_date_range/start_date=:start_date/end_date=:end_date' => :search_by_date_range
    end 
  end 

  resources :products, except: [:new, :edit] do 
    collection do 
      post 'add_categories' => :add_categories
    end 
  end 

  resources :categories, only: [:index, :create, :destroy]

  
end
