Rails.application.routes.draw do
  resources :alquilers do
    member do
      get :finished
    end
  end
  resources :vehiculos
  get 'perfil/mi_perfil'
  get 'billetera/mi_billetera'
  patch 'billetera/cargar_creditos'
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
end
