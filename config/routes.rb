Rails.application.routes.draw do
  resources :photos, only: [:show]
end
