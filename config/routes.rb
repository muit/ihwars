Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'devise_registrations', :sessions => 'devise_sessions' }
  get "/users/:id" => "users#profile", as: :user_profile
  post "/users/:id" => "users#attack"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#index'

  get "/base"                 => "base#index"
  get "/base/create"          => "base#create"
  get "/base/info"            => "base#info"
  
  get "/user/resources"       => "base#resources"

  get "/base/building/info"   => "building#info"
  get "/base/building/create" => "building#create"
  get "/base/building/update" => "building#update"
  get "/base/building/cost"   => "building#cost"

  get "/base/entity/info"     => "entity#info"
  get "/base/entity/create"   => "entity#create"
  get "/base/entity/cost"     => "entity#cost"

  get "/rank" => "rank#rank"

  get "/simulator" => "combat_simulator#simulator"
  post "/simulator/" => "combat_simulator#run"

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
