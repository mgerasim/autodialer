Rails.application.routes.draw do
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
end
