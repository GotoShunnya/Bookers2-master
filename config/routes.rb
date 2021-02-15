Rails.application.routes.draw do
  devise_for :users
  root to:"users#top"
  get "about"=>"homes#about"

  resources :books, only: [:index, :create, :show, :edit, :update, :destroy]
  resources :users, only: [:index, :create, :show, :edit, :update]

end
