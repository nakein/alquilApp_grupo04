Rails.application.routes.draw do
  resources :alquilers do
    member do
      get :finished
    end
  end
  resources :vehiculos
  get 'perfil/mi_perfil'
  get 'billetera/mi_billetera'
  get 'billetera/medios_pago'
  patch 'billetera/cargar_creditos'
  get 'billetera/new_card'
  patch 'billetera/agregar_card'
  delete 'billetera/destroy_card/:id', to: 'billetera#destroy_card'
  get 'billetera/new_cvu'
  patch 'billetera/agregar_cvu'
  delete 'billetera/destroy_cvu/:id', to: 'billetera#destroy_cvu'
  get 'estado/mi_estado'
  delete 'vehiculos/destroy/:id', to: 'vehiculos#destroy'
  devise_for :usuarios, :controllers => {registrations: 'registrations'}
  resources :usuarios do
    member do
      get :license_validated
      get :ban
    end
  end
resources :perfil, only: [:edit]

  resources :vehiculos
  resources :supervisors
  delete '/supervisors/:id', to:'supervisors#destroy'
  get '/supervisors/new', to: 'supervisors#new'
  root "main#home"

  resources :reports
end
