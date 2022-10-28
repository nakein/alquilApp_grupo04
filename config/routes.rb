Rails.application.routes.draw do
  get 'perfil/mi_perfil'
  devise_for :usuarios, :controllers => {registrations: 'registrations'}
  resources :usuarios
  resources :billetera
  root "main#home"
end
