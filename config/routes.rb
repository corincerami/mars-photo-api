Rails.application.routes.draw do
  root "photos#index"

  resources :photos, only: [:show, :index]

  namespace :api do
    namespace :v1 do
      resources :photos, only: [:show, :index]
    end
  end
end
