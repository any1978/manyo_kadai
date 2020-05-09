Rails.application.routes.draw do
  resources :labels
  root to: 'tasks#index'
  
  resources :users, only: [:new, :create, :show, :edit, :update]

  namespace :admin do
    resources :users
  end

  resources :sessions, only: [:new, :create, :destroy]

  resources :tasks 
    # collection do
    #   get 'search'
    # end
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# end

