Rails.application.routes.draw do
  #devise_for :users, controller: {
    # registrations: 'users/registrations'
    #}

    resources :chats, only: [:create, :show]
    devise_for :users, controllers: {
      registrations: 'users/registrations'
    }
    
    root 'home#top'
    get 'home/about' => 'home#about'

    resources :users,only: [:show,:index,:edit,:update] do
      member do
        get :following, :followers
      end
    end

    resources :books do
      resource :favorites, only: [:create, :destroy]
      resources :book_comments, only: [:create, :destroy]
    end
    resources :relationships, only: [:create, :destroy]

    
    get 'search' => 'searches#search'

end