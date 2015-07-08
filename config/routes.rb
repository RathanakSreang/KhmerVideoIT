Rails.application.routes.draw do
  devise_for :users, skip: [:session, :password, :registration],
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
    mount Ckeditor::Engine => '/ckeditor'
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
  get "*path", to: redirect("/kh/%{path}")
  get "", to: redirect("/kh/")
end
