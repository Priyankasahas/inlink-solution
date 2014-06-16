InlinkOnline::Application.routes.draw do
  get 'home/index'

  devise_for :User, :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  # Devise Routes
  devise_scope :User do
    get "login", :to => "devise/sessions#new", :as => "login"
    get "logout", :to => "devise/sessions#destroy", :as => "logout"
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  root to: "home#index"

  resources :users do
    get "new_role" => "users#new_role", :as => :new_role
    post "add_role" => "users#add_role", :as => :add_role
  end

  get "/users/:user_id/remove_role/:id" => "users#remove_role", :as => :remove_role

  resources :tenant_applications do
    get "new_role_privilege" => "tenant_applications#new_role_privilege", :as => :new_role_privilege
    post "add_role_privilege" => "tenant_applications#add_role_privilege", :as => :add_role_privilege
  end
  resources :blogs
  resources :role_privileges

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end