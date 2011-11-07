LearnTesting::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" } 

  resources :authentications, :except => ['index', 'edit', 'update', 'show'] do
    collection do
      get 'pending'
    end
  end

  match '/auth/:provider/callback' => 'authentications#create'

  root :to => "info#index"

  match '/info/how_assessments_work' => 'info#how_assessments_work'

  resources :info, :as => "info", :except => ['edit', 'update', 'new', 'create', 'show', 'destroy'] do
  end

  resources :users, :as => "user", :except => ['edit', 'update'] do
    collection do
      get 'pending'
      get 'flash_messages'
      put :update_attribute_on_the_spot
    end

    member do
      put 'approve'
    end
  end

  resources :learnings, :except => ['destroy', 'index'] do
    collection do
      get 'search'
    end
    
    member do
      put 'approve'
    end

    resources :assessments, :except => ['destroy', 'index', 'show', 'new', 'create', 'edit']
  end
end
