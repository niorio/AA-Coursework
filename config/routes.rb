Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: [:index, :destroy] do
    resources :comments, only: :new
    post '/upvote', to: 'votes#upvote'
    post '/downvote', to: 'votes#downvote'
  end
  resources :comments, except: [:index, :new] do
    post '/upvote', to: 'votes#upvote'
    post '/downvote', to: 'votes#downvote'
  end
end
