Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :pictures do
    collection do
      post :confirm
    end
  end
  
  get '/' , to: 'pictures#index'
  get 'favorites', to: 'pictures#favorites'
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/inbox"
  end
  
  resources :users, only: [:new, :create, :show, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]

end
