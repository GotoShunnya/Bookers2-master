Rails.application.routes.draw do
  devise_for :admins, controllers:{
    sessions: "admins/sessions"
  }
  devise_for :users
  root to: "users#top"
  get "home/about" => "homes#about"
  get "search/search" => "searchs#search"

  resources :users, only: [:index, :create, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :books, only: [:index, :create, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
end
