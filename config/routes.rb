Rails.application.routes.draw do
  root 'home#index'
  get 'home/update', to: 'home#update'
end
