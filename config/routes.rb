Rails.application.routes.draw do

  namespace :admin do
    root to: "homes#top"
    resources :items, except: [:destroy]
    resources :genres, only: [:create, :index, :edit, :update]
    get "customers/:id/orders" => "customers#order", as: "customer_orders"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_items, only: [:update]
  end

  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about", as: "about"
    get "customers/leave" => "customers#leave", as: "leave_customer"
    patch "customers/resign" => "customers#resign", as: "resign_customer"
    resource :customers, only: [:show, :edit, :update]
    resources :items, only: [:index, :show]
    delete "cart_items" => "cart_items#destroy_all", as: "destroy_all_cart_items"
    resources :cart_items, only: [:create, :index, :update, :destroy]
    post "orders/confirm" => "orders#confirm", as: "confirm_order"
    get "orders/thank" => "orders#thank", as: "thank_order"
    resources :orders, only: [:new, :create, :index, :show]
    resources :addresses, except: [:new, :show]

  end

  devise_for :admins, module: "admins"
  devise_for :customers, module: "customers"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
