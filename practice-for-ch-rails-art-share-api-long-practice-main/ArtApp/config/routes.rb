Rails.application.routes.draw do
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    # root "articles#index"
    resources :users, only: [:destroy, :create, :index, :show, :update] do
        resources :artworks, only: [:index] do
            resources :likes, only: [:create, :index, :destroy]
        end
        resources :comments, only: [:index] do
            resources :likes, only: [:create, :index, :destroy]
        end
    end

    resources :users do 
      member do
        get 'favorites'
      end
    end
    
    resources :artworks, only: [:destroy, :create, :show, :update] do
        resources :comments, only: [:index]
        resources :likes, only: [:index]
    end
    
    resources :artwork_shares, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy] do
        resources :likes, only: [:index]
    end



    # get '/users/', to: 'users#index'
    # get '/users/new', to: 'users#new'
    # post '/users/', to: 'users#create'
    # get '/users/:id', to: 'users#show'
    # get '/users/:id/edit', to: 'users#edit'
    # patch '/users/:id', to: 'users#update'
    # delete '/users/:id', to: 'users#destroy'

end
