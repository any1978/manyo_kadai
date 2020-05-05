Rails.application.routes.draw do
  root to: 'tasks#index'
  
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]

  resources :tasks do
    # collection do
    #   get 'search'
    # end
  end

  namespace path :admin do
    resources :users
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
