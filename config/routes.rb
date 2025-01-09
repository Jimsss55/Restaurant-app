Rails.application.routes.draw do
  devise_for :users

  resources :menu_items

  resources :users, only: [ :index ]

  resources :customer_tables

  root "menu_items#index"
end
