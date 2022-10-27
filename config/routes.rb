Rails.application.routes.draw do
  get 'perfil/mi_perfil'
  devise_for :usuarios, :controllers => {registrations: 'registrations'}
  resources :usuarios
  root "main#home"
end
