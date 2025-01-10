Rails.application.routes.draw do
  resources :order_items

  resources :customers, except: [ :edit, :update ] do
    resources :order_items, only: [ :new, :create ]
  end

  devise_for :users

  resources :menu_items

  resources :customer_tables


  resources :users, only: [ :index ]

  root "menu_items#index"
end
