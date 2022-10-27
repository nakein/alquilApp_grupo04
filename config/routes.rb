Rails.application.routes.draw do
  devise_for :usuarios, :controllers => {registrations: 'registrations'}
  resources :usuarios
  resources :billetera
  root "main#home"
end
