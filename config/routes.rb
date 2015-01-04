Rails.application.routes.draw do

  devise_for :users

  get 'homepages/index'


  root to: "homepages#index"


  resources :locations, only: [:create, :index, :show, :new]
  resources :hunts

  resources :locations do
    resources :hunts
  end


  resources :hunts do
    resources :quizzes
  end


end
