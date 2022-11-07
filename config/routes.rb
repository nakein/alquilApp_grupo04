Rails.application.routes.draw do
  resources :vehiculos
  get 'perfil/mi_perfil'
  get 'billetera/mi_billetera'
  patch 'billetera/cargar_creditos'
  devise_for :usuarios, :controllers => {registrations: 'registrations'}
  resources :usuarios
  resources :supervisors
  devise_scope :usuario do
    get "supervisor" => "supervisor_controller"
  end
  root "main#home"
end
