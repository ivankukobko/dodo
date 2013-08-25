Dodo::Application.routes.draw do

  root :to => "home#index"
  #root :to => "dashboard#index"
  get '/dashboard' => 'dashboard#index'

  resources :info_pages, :path => 'help', :only => [ :index, :show ]
  resources :worklogs do
    member do
      get 'bill'
      get 'unbill'
    end
  end

  resources :sessions, :only => [:new, :create]
  get '/logout' => 'sessions#destroy', :as => :logout
  get '/auth/:provider/callback', :to => 'sessions#create'
  post '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'


  resources :users
  get '/me' => 'users#me', :as => :me
  get '/me/edit' => 'users#edit', :as => :edit_me
  resources :authentications, :only => [ :create, :destroy ]

  resources :invitations do
    member do
      get :accept
    end
  end

  resources :projects do
    resources :todo_lists, :path => 'lists'
    resources :collaborators, :only => [ :create, :update, :destroy ]
    resources :invitations, :only => [ :new, :create, :destroy ] do
      member do
        get :accept
      end
    end
    resources :worklogs
  end

  resources :todo_lists, :path => 'lists' do
    resources :todo_items, :path => 'tasks' do
      collection do
        post :sort
      end
      member do
        get :complete
        get :uncomplete
      end
    end
  end

  resources :todo_items, :path => 'tasks' do
    member do
      get :complete
      get :uncomplete
    end
    collection do
      post :sort
    end
    resources :comments
    resources :worklogs
  end

  namespace :admin do
    resources :info_pages, :path => 'help'
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.
end
