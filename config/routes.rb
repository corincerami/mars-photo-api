Rails.application.routes.draw do
  root "api/v1/rovers#index"

  namespace :api do
    namespace :v1 do
      resources :rovers, only: [:show, :index] do
        resources :photos, only: :index
      end
      resources :photos, only: :show
    end
  end
end
