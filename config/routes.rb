Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'

        get '/revenue', to: 'revenue#show'
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/:id/revenue/', to: 'revenue#show'

        get '/:id/favorite_customer', to: 'favorite_customer#show'
        get '/:id/customers_with_pending_invoices', to: 'pending_customers#show'
      end

      resources :merchants, only: [:index, :show], module: :merchants do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end


      namespace :customers do
        get "/find", to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'

        get '/:id/favorite_merchant', to: 'favorite_merchant#show'
      end

      resources :customers, only: [:index, :show], module: :customers do
        resources :invoices, only: [:index]
        resources :transactions, only: [:index]
      end


      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'

        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/:id/best_day', to: 'best_day#show'
      end

      resources :items, only: [:index, :show], module: :items do
        resources :merchant, only: [:index]
        resources :invoice_items, only: [:index]
      end


      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      resources :invoice_items, only: [:index, :show], module: :invoice_items do
        resources :item, only: [:index]
        resources :invoice, only: [:index]
      end


      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      resources :invoices, only: [:index,:show], module: :invoices do
        resources :merchant, only: [:index]
        resources :customer, only: [:index]
        resources :items, only: [:index]
        resources :invoice_items, only: [:index]
        resources :transactions, only: [:index]
      end


      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      resources :transactions, only: [:index, :show], module: :transactions do
        resources :invoice, only: [:index]
      end
    end
  end
end
