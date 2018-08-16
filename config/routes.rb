Rails.application.routes.draw do
  root 'static#explore'

  get '/explore(/*whatevs)' => 'static#explore', :as => :explore

  namespace :api do
    namespace :v1 do
      resources :rovers, only: [:show, :index] do
        resources :photos, only: :index
        resources :latest_photos, only: :index
      end
      resources :photos, only: :show
      resources :manifests, only: :show

      get 'surprise', to: 'surprises#index'
    end

    namespace :v0 do
      resources :rovers, only: [:show, :index]
      resources :photos, only: [:show, :index]
    end
  end
end
