Rails.application.routes.draw do
  devise_for :users

  resources :menu_items

  root 'menu_items#index'
end
