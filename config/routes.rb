ActionController::Routing::Routes.draw do |map|
  map.home '/', :controller => 'welcome', :action => 'index'
  map.login '/admin/login', :controller => 'admin', :action => 'login'
  map.logout '/admin/logout', :controller => 'admin', :action => 'logout'
  map.register '/admin/register', :controller => 'admin', :action => 'register'
  map.validate_registration 'admin/validate/:registration_key/:id', :controller => 'admin', :action => 'validate'
  map.playing_status '/games/playing_status/:id', :controller => 'games', :action => 'playing_status'
  map.not_playing 'players/not_playing/:player_id/:game_id', :controller => 'players', :action => 'not_playing'
  map.playing 'players/playing/:player_id/:game_id', :controller => 'players', :action => 'playing'
  map.edit_player 'players/edit/:id', :controller => 'players', :action => 'edit'
  map.resources :users

#  map.resources :players
  map.resources :games
  map.resources :schedules

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
