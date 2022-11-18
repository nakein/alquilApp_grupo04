Rails.application.routes.draw do
  resources :vehiculos
  get 'perfil/mi_perfil'
  #patch 'perfil/edit/:id', to: 'perfil#edit'
  get 'billetera/mi_billetera'
  patch 'billetera/cargar_creditos'
  delete 'vehiculos/destroy/:id', to: 'vehiculos#destroy'
  devise_for :usuarios, :controllers => {registrations: 'registrations'}
  resources :usuarios do
    member do
      get :license_validated
    end
  end
resources :perfil, only: [:edit]

  resources :vehiculos
  resources :supervisors
  delete '/supervisors/:id', to:'supervisors#destroy'
  get '/supervisors/new', to: 'supervisors#new'
  root "main#home"
end
