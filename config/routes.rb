Rails.application.routes.draw do
  get 'perfil/mi_perfil'
  get 'billetera/mi_billetera'
  patch 'billetera/cargar_creditos'
  devise_for :usuarios, :controllers => {registrations: 'registrations'}
  resources :usuarios
  root "main#home"
end
