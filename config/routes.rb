Rails.application.routes.draw do

  namespace :admin do
    root "static_pages#dashboard"    
    resources :videos
  end

  resources :videos, only: [:show, :index]
  root "static_pages#home"

  get "static_pages/help"

  get "static_pages/about"

  get "static_pages/contact"
end
