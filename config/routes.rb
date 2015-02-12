MusicApp::Application.routes.draw do
  root 'bands#index'

  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :new, :destroy]

  resources :bands
  get 'bands/:id/albums/new', to: 'albums#new', as: 'new_band_album'

  resources :albums, only: [:create, :edit, :show, :update, :destroy]
  get 'albums/:album_id/tracks/new', to: 'tracks#new', as: 'new_album_track'

  resources :tracks, only: [:create, :edit, :show, :update, :destroy]

end
