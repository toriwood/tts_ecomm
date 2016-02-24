Rails.application.routes.draw do
  resources :line_items
  resources :carts
  get '/admin' => 'admin#power'

  devise_for :users
  
  get 'storefront/all_items'
  get 'storefront/items_by_category'

  root 'storefront#all_items'
  get 'category' => 'storefront#items_by_category'
  get 'tag' => 'storefront#items_by_tag'

  resources :categories
  resources :products

  get 'hog' => 'admin#hog_power'
  get 'share' => 'admin#give_power'
  
end
