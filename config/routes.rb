Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :campaigns do
        member do
          post :preview
          post :send_test
        end
      end
      resources :subscribers
      resources :templates
    end
  end

  # Health check endpoint for load balancer
  get '/health', to: 'health#index'
end
