Rails.application.routes.draw do



  get 'homepages/index'


  root to: "homepages#index"


  resources :locations, only: [:create, :index, :show, :new]
  resources :hunts

  resources :locations, only: [:create, :index, :show, :new] do
    resources :hunts
  end

  resources :hunts do
    resources :questionsets, only: [:create, :index, :show, :new, :update, :edit]
  end

  resources :questionsets, only: [:create, :index, :show, :new, :update, :edit] do
    resources :huntsplayedusers, only: [:create, :index, :show, :new]
  end
  resources :users, only: [:index]
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" },
  except: [:destroy]

end
