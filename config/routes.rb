Rails.application.routes.draw do
  devise_for :users
  get 'storefront/all_items'

  get 'storefront/items_by_category'

  get 'storefront/items_by_price'

  root 'storefront#all_items'
  get 'price' => 'storefront#items_by_price'
  get 'category' => 'storefront#items_by_category'

  resources :categories
  resources :products
  
end
