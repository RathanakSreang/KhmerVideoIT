Rails.application.routes.draw do

  devise_for :users
  devise_scope :user do
    get "sign_out", to: "devise/sessions#destroy"
  end
  mount Ckeditor::Engine => '/ckeditor'
  namespace :admin do
    root "activities#index"
    get "about"=> "static_pages#about"
    get "edit_about"=> "static_pages#edit_about"
    patch "update_about"=> "static_pages#update_about"    
    resources :videos
    resources :tags
    resources :articles
    resources :users
    resources :activities, only: [:index]
    resources :comments, only: [:show, :index, :destroy]
  end

  resources :tags, only: [:show]
  resources :users, only: [:show]
  resources :searchs, only: [:index]
  resources :articles, only: [:show, :index] do
    resources :comments
  end
  resources :videos, only: [:show, :index] do
    resources :comments
  end
  root "static_pages#home"
  get "about" => "static_pages#about"

end
