Rails.application.routes.draw do
  resources :members
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  # get 'app', to: 'app#index'
  # get 'token', to: 'get_token#index'
  resources :token, except: [:destroy, :edit], controller: 'get_token'
end