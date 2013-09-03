YeslInfo::Application.routes.draw do
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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root to: 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  resources :addresses

  resources :databases

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

  get 'links' => 'home#links', as: :links
  get 'passwords' => 'home#passwords', as: :passwords
  get 'webpanel_logins' => 'home#webpanel_logins', as: :webpanel_logins

  resources :note_pads

  resources :numbers

  resources :organisations do
    collection do
      get 'contacts'
    end
    member do
      post 'contacted'
      post 'more_timesheet_entries'
    end
  end

  resources :sessions do
    delete 'destroy', on: :collection
  end

  resources :timesheet_entries do
    collection do
      post 'more_timesheet_entries'

      get 'report'
      post 'generate_report'
    end
  end

  resources :to_dos do
    collection do
      get 'calendar'
      post 'update_multiple'
    end
  end

  resources :users do
    collection do
      get 'forgot_password'
      post 'forgot_password_send'
    end

    member do
      post 'more_timesheet_entries'
    end
  end
end
