Rails.application.routes.draw do

  devise_for :users, path: 'accounts', controllers: {
    sessions: 'users/sessions'
  }

  resources :users, only: [:show], param: :slug, path: "" do
    resources :members
    resources :trials
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  # get 'app', to: 'app#index'
  # get 'token', to: 'get_token#index'
  resources :token, except: [:destroy, :edit], controller: 'get_token'

  post 'checkout/create', to: 'checkout#create'
  resources :webhooks, only: [:create]
  resource :connect_onboard_user, only: [:create]
end