Rails.application.routes.draw do
    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
    root 'home#top'
    get 'home/about' => 'home#about'
    resources :users,only: [:show,:index,:edit,:update]
    resources :books do
      resource :favorites, only: [:create, :destroy]
      resources :book_comments, only: [:create, :destroy]
    end

  end