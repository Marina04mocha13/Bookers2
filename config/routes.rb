Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :create, :show, :edit, :update] do
    resources :relationships, only: [:create, :destroy]
    member do
      get :following, :followers
    end

  end
  
  get "search" => "searches#search"

  get "home/about"=> "homes#about", as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
