Rails.application.routes.draw do
  resources :vehiculos
  get 'perfil/mi_perfil'
  get 'billetera/mi_billetera'
  patch 'billetera/cargar_creditos'
  devise_for :usuarios, :controllers => {registrations: 'registrations'}
  resources :usuarios
  
  resources :supervisors
  delete '/supervisors/:id', to:'supervisors#destroy'
  get '/supervisors/new', to: 'supervisors#new'
  root "main#home"
end
