LearnTesting::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" } 

  resources :authentications, :except => ['index', 'edit', 'update', 'show'] do
    collection do
      get 'pending'
    end
  end

  match '/auth/:provider/callback' => 'authentications#create'

  root :to => "info#index"

  resources :info, :as => "info", :except => ['edit', 'update', 'new', 'create', 'show', 'destroy'] 
  match '/info/how_assessments_work' => 'info#how_assessments_work'
  match '/info/an_example' => 'info#an_example'
  match '/info/how_disciplines_work' => 'info#how_disciplines_work'
  match '/info/how_categories_work' => 'info#how_categories_work'

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

  resources :learnings, :except => ['index'] do
    collection do
      get 'browse'
      get 'search'
      get 'pending_assessments'
      get 'pending_approvals'
    end
    
    member do
      put 'approve'
    end

    resources :assessments, :except => ['destroy', 'index', 'show', 'new', 'create', 'edit']
  end
end
