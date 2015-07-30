Rails.application.routes.draw do
  devise_for :users, skip: [:session, :registration],
              controllers: { omniauth_callbacks: "omniauth_callbacks" }

  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks",
                                    passwords: "passwords",
                                    sessions: "sessions",
                                    confirmations: "confirmations",
                                    registrations: "registrations"}, skip: [:omniauth_callbacks]
    devise_scope :user do
      get "sign_out", to: "devise/sessions#destroy"
    end
      namespace :admin do
      root "static_pages#dashboard"
      get "about"=> "static_pages#about"
      get "edit_about"=> "static_pages#edit_about"
      patch "update_about"=> "static_pages#update_about"    
      resources :videos
      resources :questions, except: [:new, :create]
      resources :tags
      resources :articles
      resources :users
      resources :activities, only: [:index]
      resources :comments, only: [:show, :index, :destroy]
    end

    resources :questions do
      resources :comments
    end
    resources :tags, only: [:show]
    resources :users, only: [:show] do
      resources :activities, only: :index
      member do
        get "question"
        get "comment"
      end
    end
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

  # get "*path", to: redirect("/#{I18n.default_locale}/%{path}")  
  # get "", to: redirect("/#{I18n.default_locale}/")
  match "errors/500", to: "errors#500", via: :all
  match "errors/404", to: "errors#404", via: :all
  match "errors/422", to: "errors#422", via: :all
  match "(errors)/:status", to: "errors#show", constraints: {status: /\d{3}/}, via: :all

  get "*path", to: redirect("/kh/%{path}"),
    constraints: lambda {|req| !req.path.starts_with?("/kh/") && !req.path.starts_with?("/en/")}
  get "", to: redirect("/kh/")
end
