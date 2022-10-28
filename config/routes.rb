Rails.application.routes.draw do
  get 'perfil/mi_perfil'
  get 'billetera/mi_billetera'
  devise_for :usuarios, :controllers => {registrations: 'registrations'}
  resources :usuarios
  root "main#home"
end
