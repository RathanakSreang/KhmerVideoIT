Rails.application.routes.draw do

  devise_for :users
  devise_scope :user do
    get "sign_out", to: "devise/sessions#destroy"
  end
  mount Ckeditor::Engine => '/ckeditor'
  namespace :admin do
    root "static_pages#dashboard"
    get "about"=> "static_pages#about"
    get "edit_about"=> "static_pages#edit_about"
    patch "update_about"=> "static_pages#update_about"
    resources :videos
    resources :tutorials
    resources :languages
    resources :articles
  end

  resources :users, only: [:show]
  resources :tutorials, only: [:show, :index]
  resources :articles, only: [:show, :index]
  resources :videos, only: [:show, :index]
  root "static_pages#home"
  get "about" => "static_pages#about"

end
