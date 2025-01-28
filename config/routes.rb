Rails.application.routes.draw do
  resources :customers do
    resources :order_items, except: [ :index ]
    resources :payment_details, except: [ :update, :edit ]
  end

  devise_for :users

  resources :menu_items, except: [ :show ]

  resources :customer_tables

  resources :users, only: [ :index ]

  root "menu_items#index"
end
