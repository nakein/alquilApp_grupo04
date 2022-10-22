Rails.application.routes.draw do
  devise_for :clientes
  resources :clientes
  root "main#home"
end
