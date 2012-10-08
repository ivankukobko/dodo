Dodo::Application.routes.draw do

  root :to => "home#index"
  #root :to => "dashboard#index"

  resources :help, :controller => 'InfoPages', :only => [ :index, :show ]
  resources :worklogs

  resources :sessions, :only => [:new, :create]
  get '/logout' => 'sessions#destroy', :as => :logout
  get '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'


  resources :users
  match 'me' => 'users#me', :as => :me
  match 'me/edit' => 'users#edit', :as => :edit_me
  resources :authentications, :only => [ :create, :destroy ]

  resources :invitations do
    member do
      get :accept
    end
  end

  resources :projects do
    resources :todo_lists
    resources :collaborators, :only => [ :create, :update, :destroy ]
    resources :invitations, :only => [ :new, :create, :destroy ] do
      member do
        get :accept
      end
    end
    resources :worklogs
  end

  resources :todo_items do
    member do
      get :complete
      get :incomplete
    end
    collection do
      post :sort
    end
    resources :comments
    resources :worklogs
  end

  resources :todo_lists do
    resources :todo_items do
      collection do
        post :sort
      end
      member do
        get :complete
        get :incomplete
      end
    end
  end

  namespace :admin do
    resources :help, :controller => :info_pages
  end


  # The priority is based upon order of creation:
  # first created -> highest priority.

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
  # match ':controller(/:action(/:id(.:format)))'
end
