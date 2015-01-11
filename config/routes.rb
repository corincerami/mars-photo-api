Rails.application.routes.draw do
  resources :photos, only: [:show, :index]
end
