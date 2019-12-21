Rails.application.routes.draw do

  resources :analyses
  get 'events/call'

  get 'events/dtmf'

  get 'events/summary'

  post 'events/call'

  post 'events/dtmf'

  post 'events/summary'

  get 'analysis/answers'


  resources :employees do
    member do 
      get 'active'
      get 'deactive'
    end
  end

  resources :groups do 
    member do 
      get 'active'
      get 'deactive'
    end
  end
  resources :lead_statuses
  resources :sipaccounts
  post '/cabinet_employee_status_change', to: 'cabinet#employee_status_change'

  get '/cabinet_show', to: 'cabinet#show'

  get '/cabinet_in', to: 'cabinet#new'

  post '/cabinet_in', to: 'cabinet#create'

  delete '/cabinet_out', to: 'cabinet#destroy'

  get 'cabinet/new'

  get 'cabinet/create'

  get 'cabinet/destroy'

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

  resources :tranks do
    member do
      get 'distrib'
      get 'active'
      get 'deactive'
    end
  end

  get 'help/upload_nodial'
  get 'help/lead_get_employee_sipaccount'
  get 'help/lead_update_dial_status'
  get 'help/lead_incoming'
  get 'help/outgoing_destroy_all'
  get 'help/answers_destroy_all'
  get 'help/cdr_destroy_all'
  get 'help/asterisk_restart'
  get 'help/extensions'
  get 'help/trank_enable_all'
  get 'help/trank_disable_all'
  get 'help/trank_check'
  get 'help/employee_active'
  get 'help/employee_deactive'

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
