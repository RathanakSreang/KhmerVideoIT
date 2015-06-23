Rails.application.routes.draw do

  resources :videos, only: [:show, :index]
  root "statis_pages#home"

  get "statis_pages/help"

  get "statis_pages/about"

  get "statis_pages/contact"

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
