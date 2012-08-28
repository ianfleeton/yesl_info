YeslInfo::Application.routes.draw do
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
  root to: 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  resources :addresses

  resources :domains do
    member do
      get 'nslookup'
      get 'whois'
    end
  end

  resources :hosting_accounts do
    collection do
      get 'backups'
    end
    member do
      post 'backed_up'
    end
  end

  resources :email_addresses

  match 'links' => 'home#links', as: :links
  match 'passwords' => 'home#passwords', as: :passwords
  match 'webpanel_logins' => 'home#webpanel_logins', as: :webpanel_logins

  resources :note_pads

  resources :numbers

  resources :organisations do
    collection do
      get 'contacts'
    end
    member do
      post 'contacted'
    end
  end

  resources :sessions

  resources :timesheet_entries

  resources :to_dos do
    collection do
      post 'update_multiple'
    end
  end

  resources :users do
    collection do
      get 'forgot_password'
      post 'forgot_password_send'
    end
  end
end
