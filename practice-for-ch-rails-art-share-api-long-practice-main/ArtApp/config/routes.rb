Rails.application.routes.draw do
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    # root "articles#index"

    resources :users, only: [:destroy, :create, :index, :show, :update] do
        resources :artworks, only: [:index]
    end

    
    resources :artworks, only: [:destroy, :create, :show, :update]
    resources :artwork_shares, only: [:create, :destroy]


    # get '/users/', to: 'users#index'
    # get '/users/new', to: 'users#new'
    # post '/users/', to: 'users#create'
    # get '/users/:id', to: 'users#show'
    # get '/users/:id/edit', to: 'users#edit'
    # patch '/users/:id', to: 'users#update'
    # delete '/users/:id', to: 'users#destroy'

end
