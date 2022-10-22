Rails.application.routes.draw do
  devise_for :clientes, :controllers => {registrations: 'registrations'}
  resources :clientes
  root "main#home"
end
