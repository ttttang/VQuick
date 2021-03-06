Rails.application.routes.draw do
  #Custom devise registration controller
  devise_for :users, controllers: {registrations: "users/registrations"}

  #Homepage 
  root "pages#home"

  #EVENTS CREATED BY ADMIN
  get 'createdevents'=>'events#createdevents'

  #Events for individual users
  get 'myevents' => 'events#myevents'

  #General business pages
  get 'pages/about_us'
  get 'pages/contact'
  get 'pages/home'
  
  #Attending and unattending events
  get 'attendevent' => 'events#attend'
  get 'unattend'=>'events#unattend'

  
  get'organizations/[:id]'=>'organizations/#show'

  #Resources

  get 'events'=>'events#index'
  resources :charges
  resources :events
  resources :organizations
  #resources :users
  



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
