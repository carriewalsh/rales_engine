Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        #GET "/api/v1/merchants.json"
        #GET "/api/v1/merchants/:id.json"
        resources :items, only: [:index]
        resources :invoices, only: [:index]
        #GET "/api/v1/merchants/:id/items"
        #GET "/api/v1/merchants/:id/invoices"
      end

      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        # GET "/api/v1/merchants/find?parameters"
        # GET "/api/v1/merchants/find_all?parameters"
        # GET "/api/v1/merchants/random.json"

        get '/revenue', to: ''
        # GET "/api/v1/merchants/revenue?date=x"
        get '/most_revenue', to 'most_revenue#show'
        # GET "/api/v1/merchants/most_revenue?quantity=x"
        get '/most_items', to 'most_items#show'
        # GET "/api/v1/merchants/most_items?quantity=x"
        get '/:id/revenue/', to: 'revenue#show'
        # GET "/api/v1/merchants/:id/revenue"
        # GET "/api/v1/merchants/:id/revenue?date=x"

        get '/:id/favorite_customer', to: 'favorite_customer#show'
        # GET "/api/v1/merchants/:id/favorite_customer"
        get '/:id/customers_with_pending_invoices', to: 'pending_customers#show'
        # GET "/api/v1/merchants/:id/customers_with_pending_invoices"
      end


      resources :customers, only: [:index, :show] do
        # GET "/api/v1/customers.json"
        # GET "/api/v1/customers/:id.json"
        resources :invoices, only: [:index]
        resources :transactions, only: [:index]
        # GET "/api/v1/customers/:id/invoices"
        # GET "/api/v1/customers/:id/transactions"
      end

      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        # GET "/api/v1/customers/find?parameters"
        # GET "/api/v1/customers/find_all?parameters"
        # GET "/api/v1/customers/random.json"

        get '/favorite_merchant', to: 'favorite_merchant#show'
        # GET "/api/v1/customers/:id/favorite_merchant"
      end


      resources :items, only: [:index, :show] do
        # GET "/api/v1/items.json"
        # GET "/api/v1/items/:id.json"
        resources :merchants, only: [:index]
        resources :invoice_items, only: [:index]
        # GET "/api/v1/items/:id/merchant"
        # GET "/api/v1/items/:id/invoice_items"
      end

      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        # GET "/api/v1/items/find?parameters"
        # GET "/api/v1/items/find_all?parameters"
        # GET "/api/v1/items/random.json"
        get '/most_revenue', to: 'most_revenue#show'
        # GET "/api/v1/items/most_revenue?quantity=x"
        get '/most_items', to: 'most_items#show'
        # GET "/api/v1/items/most_items?quantity=x"
        get '/best_day', to: 'best_day'
        # GET "/api/v1/items/:id/best_day"
      end


      resources :invoice_items, only: [:index, :show] do
        # GET "/api/v1/invoice_items.json"
        # GET "/api/v1/invoice_items/:id.json"
        resources :items, only: [:index]
        resources :invoices, only: [:index]
        # GET "/api/v1/invoice_items/:id/item"
        # GET "/api/v1/invoice_items/:id/invoice"
      end

      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        # GET "/api/v1/invoice_items/find?parameters"
        # GET "/api/v1/invoice_items/find_all?parameters"
        # GET "/api/v1/invoice_items/random.json"
      end


      resources :invoices, only: [:index,:show] do
        # GET "/api/v1/invoices.json"
        # GET "/api/v1/invoices/:id.json"
        resources :merchants, only: [:items]
        resources :customers, only: [:items]
        resources :items, only: [:items]
        resources :invoice_items, only: [:index]
        resources :transactions, only: [:index]
        # GET "/api/v1/invoices/:id/merchant"
        # GET "/api/v1/invoices/:id/customer"
        # GET "/api/v1/invoices/:id/items"
        # GET "/api/v1/invoices/:id/invoice_items"
        # GET "/api/v1/invoices/:id/transactions"
      end

      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        # GET "/api/v1/invoices/find?parameters"
        # GET "/api/v1/invoices/find_all?parameters"
        # GET "/api/v1/invoices/random.json"
      end


      resources :transactions, only: [:index, :show] do
        # GET "/api/v1/transactions.json"
        # GET "/api/v1/transactions/:id.json"
        resources :invoices, only: [:index]
        # GET "/api/v1/transactions/:id/invoice"
      end

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        # GET "/api/v1/transactions/find?parameters"
        # GET "/api/v1/transactions/find_all?parameters"
        # GET "/api/v1/transactions/random.json"
      end
    end
  end
end
