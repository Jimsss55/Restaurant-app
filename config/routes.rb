Rails.application.routes.draw do

  resources :customers do
    resources :order_items, except: [ :index ]
  end

  devise_for :users

  resources :menu_items

  resources :customer_tables


  resources :users, only: [ :index ]

  root "menu_items#index"
end
