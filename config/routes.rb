Rails.application.routes.draw do
  resources :rates
  resources :alquilers do
    member do
      patch :finished
      get :comprobar_estado
    end
  end
  resources :vehiculos
  get 'perfil/mi_perfil'
  get 'billetera/mi_billetera'
  get 'billetera/medios_pago'
  patch 'billetera/cargar_creditos'
  patch 'billetera/agregar_card'
  delete 'billetera/destroy_card'
  get 'billetera/new_card'
  get 'billetera/new_cvu'
  patch 'billetera/agregar_cvu'
  delete 'billetera/destroy_cvu'
  get 'estado/mi_estado'
  delete 'vehiculos/destroy/:id', to: 'vehiculos#destroy'
  devise_for :usuarios, :controllers => {registrations: 'registrations'}
  resources :usuarios do
    member do
      get :license_validated
      get :account_validated
      get :ban
      delete 'usuarios/destroy/:id', to: 'usuarios#destroy'
    end
  end
resources :perfil, only: [:edit]

  resources :vehiculos
  resources :vehiculos do
    member do
      patch :updateEnable
      patch :updateDisable
    end
  end
  resources :supervisors
  delete '/supervisors/:id', to:'supervisors#destroy'
  get '/supervisors/new', to: 'supervisors#new'
  resources :administradors
  delete '/administradors/:id', to:'administradors#destroy'
  get '/administradors/new', to: 'administradors#new'
  root "main#home"

  resources :reports

  get 'stats/vehiculos'
  get 'stats/usuarios'

  resources :penalties
end
