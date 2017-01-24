Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do

      namespace :merchants do
        get 'find',     to: 'query#show'
        get 'find_all', to: 'query#index'
        get 'random',   to: 'random#show'
      end
      resources :merchants, only: [:index, :show]

      namespace :transactions do
        get 'find',     to: 'query#show'
        get 'find_all', to: 'query#index'
        get 'random',   to: 'random#show'
      end
      resources :transactions, only: [:index, :show]

      namespace :customers do
        get 'find',     to: 'query#show'
        get 'find_all', to: 'query#index'
        get 'random',   to: 'random#show'
      end
      resources :customers, only: [:index, :show]

      namespace :invoices do
        get 'find',     to: 'query#show'
      end
      resources :invoices, only: [:index, :show]
    end
  end

end
