Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests
  post '/cats/:id/deny' => 'cat_rental_requests#deny', :as => 'deny_rental'
  post '/cats/:id/approve' => 'cat_rental_requests#approve', :as => 'approve_rental'
end
