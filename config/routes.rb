Rails.application.routes.draw do
  resources :menu_items
  devise_for :users
end
