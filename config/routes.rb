Rails.application.routes.draw do



  get 'homepages/index'


  root to: "homepages#index"


  resources :locations, only: [:create, :index, :show, :new]
  resources :hunts

  resources :locations do
    resources :hunts
  end

  resources :hunts do
    resources :questionsets
  end

  resources :questionsets do
    resources :huntsplayedusers
  end
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }, except: :destroy

end
