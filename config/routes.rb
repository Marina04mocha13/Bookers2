Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :create, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    member do
      get :following, :followers
    end
  end

  resources :chats, only: [:show, :create]

  get "search" => "searches#search"
  get "home/about"=> "homes#about", as: "about"

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
