Rails.application.routes.draw do
  post 'vehiculos/new'
  get 'vehiculos/new'
  get 'vehiculos/index'
  get 'perfil/mi_perfil'
  get 'billetera/mi_billetera'
  patch 'billetera/cargar_creditos'
  devise_for :usuarios, :controllers => {registrations: 'registrations'}
  resources :usuarios
  root "main#home"
end
