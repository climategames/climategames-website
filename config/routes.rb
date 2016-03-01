Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :reports
    end
  end

  scope "(:locale)", locale: /en|fr/ do
    resources :awards
    resources :teams
    resources :reports do
      resources :report_awards
    end

    get 'thanks', to: 'reports#thanks'

    get "/map" => "reports#index"

    namespace :moderation do

      get 'signup', to: 'moderators#new', as: 'signup'
      get 'login', to: 'sessions#new', as: 'login'
      get 'logout', to: 'sessions#destroy', as: 'logout'
      get 'dashboard', to: 'dashboard#show', as: 'dashboard'
      resources :game_states, only: [:index]
      resources :moderators
      resources :report_awards
      resources :reports
      resources :sessions

      get '/' => "locales#index"
    end
  end

  get "git_sha" => "diagnostics#git_sha"
  get "env" => "diagnostics#env"

  namespace :admin do
    resources :trello_cards, only: [:index]
  end

  get '/docs/d12-en-v7.little.pdf', :to => redirect('/docs/d12.en.pdf')
  get '/docs/d12-fr-v7.petit.pdf', :to => redirect('/docs/d12.fr.pdf')

  root to: 'locales#index'

  # This line mounts Refinery's routes at the root of your application.
  # This means, any requests to the root URL of your application will go to Refinery::PagesController#home.
  # If you would like to change where this extension is mounted, simply change the
  # configuration option `mounted_path` to something different in config/initializers/refinery/core.rb
  #
  # We ask that you don't use the :as option here, as Refinery relies on it being the default of "refinery"
  mount Refinery::Core::Engine, at: Refinery::Core.mounted_path

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
