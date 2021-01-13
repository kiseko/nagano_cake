Rails.application.routes.draw do

  namespace :admin do
    root to: "homes#top"
    resources :items
    resources :genres, only: [:create, :index, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end

  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    resource :customers, only: [:show, :edit, :update]
    get "customers/leave" => "customers#leave", as: "leave_customer"
    patch "customers/resign" => "customers#resign", as: "resign_customer"
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:create, :index, :update, :destroy]
    delete "cart_items" => "cart_items#destroy_all", as: "destroy_all_cart_items"
    resources :orders, only: [:new, :create, :index, :show]
    post "orders/confirm" => "orders#confirm", as: "confirm_order"
    get "orders/thank" => "orders#thank", as: "thank_order"
    resources :addresses, except: [:new, :show]
  end

  devise_for :admins, module: "admins"
  devise_for :customers, module: "customers"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
