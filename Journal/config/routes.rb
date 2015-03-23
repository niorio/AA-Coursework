Rails.application.routes.draw do
  root 'root#root'
  resources :posts, only: [:show, :create, :destroy, :update, :index]

end
