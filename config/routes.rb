Rails.application.routes.draw do
  devise_for :admins, module: "admins"
  devise_for :customers, module: "customers"

  namespace :admin do
    root to: "homes#top"
    resources :items
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
