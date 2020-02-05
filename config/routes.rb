##
#Author: Curtis Spence
Rails.application.routes.draw do
  resources :records

  resources :records do
    member do
      get :delete
    end
  end

  root 'records#index'
  
  get 'records/index'
  get 'records/edit'
  get 'records/new'
  get 'records/delete'

  post 'records/advancedSort'
  post 'records/sorting'
  post 'records/refresh'
  post 'records/deleteAll'
  post 'records/persist'

  resources :records

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
