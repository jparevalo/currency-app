Rails.application.routes.draw do
  root 'home#index'
  get 'home/update', to: 'home#update'
  get 'tmc/update', to: 'tmc#update'
  get 'tmc/index', to:'tmc#index'
end
