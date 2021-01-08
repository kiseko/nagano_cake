Rails.application.routes.draw do
  devise_for :admins, module: "admins"
  devise_for :customers, module: "customers"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
