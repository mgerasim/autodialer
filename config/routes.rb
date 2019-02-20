Rails.application.routes.draw do

  get '/cabinet_in', to: 'cabinet#new'

  post '/cabinet_in', to: 'cabinet#create'

  delete '/cabinet_out', to: 'cabinet#destroy'

  get 'cabinet/new'

  get 'cabinet/create'

  get 'cabinet/destroy'

  resources :employees
  resources :leads
  resources :machines
  resources :dialplans
  resources :votes
  resources :configs
  resources :configurations
  resources :spools
  get 'cdr/index'

  resources :answers
  get 'register/status'

  get 'register/reload'

  get 'register',	to: 'register#status'
  
  get 'register_reload', to: 'register_reload#reload'

  resources :tranks
  get 'help/outgoing_destroy_all'
  get 'help/answers_destroy_all'
  get 'help/cdr_destroy_all'
  get 'help/asterisk_restart'
  get 'help/extensions'
  get 'help/trank_enable_all'
  get 'help/trank_disable_all'
  get 'help/trank_check'

  resources :outgoings
  resources :sips
  get 'sip/show'

  get 'sip/edit'
  
  post 'sip/save'

  resources :settings
  #get 'settings/show'
  #get 'settings/edit'
  #post 'settings/edit'
  #get '/settings', to: 'settings#show'
  resources :tasks
  root 'sessions#new'
  get 'sessions/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'outgoings/destroy_all'
  get 'help/cdr'
  get 'help/cdr_clear'
end
