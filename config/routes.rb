Rails.application.routes.draw do
  devise_for :admins, module: "admins"
  devise_for :customers, module: "customers"

  namespace :admin do
    root to: "homes#top"
    resources :items
    resources :genres, only: [:create, :index, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end

  scope module: :public do
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:create, :index, :update, :destroy]
    delete "cart_items" => "cart_items#destroy_all", as: "destroy_all_cart_items"
    resources :orders, only: [:new, :create, :index, :show]
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
