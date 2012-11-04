Litsocial::Application.routes.draw do
  ActiveAdmin.routes(self)

  #         new_user_session GET    /users/sign_in(.:format)               devise/sessions#new
  #             user_session POST   /users/sign_in(.:format)               devise/sessions#create
  #     destroy_user_session DELETE /users/sign_out(.:format)              devise/sessions#destroy
  #            user_password POST   /users/password(.:format)              devise/passwords#create
  #        new_user_password GET    /users/password/new(.:format)          devise/passwords#new
  #       edit_user_password GET    /users/password/edit(.:format)         devise/passwords#edit
  #                          PUT    /users/password(.:format)              devise/passwords#update
  # cancel_user_registration GET    /users/cancel(.:format)                devise/registrations#cancel
  #        user_registration POST   /users(.:format)                       devise/registrations#create
  #    new_user_registration GET    /users/sign_up(.:format)               devise/registrations#new
  #   edit_user_registration GET    /users/edit(.:format)                  devise/registrations#edit
  #                          PUT    /users(.:format)                       devise/registrations#update
  #                          DELETE /users(.:format)                       devise/registrations#destroy
  devise_for :users, :only => []
  devise_scope :user do
    get     '/sign_in'             => 'devise/sessions#new',          as: :new_user_session
    post    '/sign_in'             => 'devise/sessions#create',       as: :user_session
    delete  '/sign_out'            => 'devise/sessions#destroy',      as: :destroy_user_session
    post    '/reset_password'      => 'devise/passwords#create',      as: :user_password
    get     '/reset_password/new'  => 'devise/passwords#new',         as: :new_user_password
    get     '/reset_password/edit' => 'devise/passwords#edit',        as: :edit_user_password
    put     '/reset_password'      => 'devise/passwords#update'
    post    '/sign_up'             => 'devise/registrations#create',  as: :user_registration
    get     '/sign_up'             => 'devise/registrations#new',     as: :new_user_registration

    # Not Routing:
    # devise/registrations#cancel
    # devise/registrations#edit
    # devise/registrations#update
    # devise/registrations#destroy
  end


  resources :stories
  resources :series
  resources :pages, only: [:index, :show]
  resources :news_posts, only: [:index, :show], path: 'news'
  resources :users, only: [:index, :show]

  get 'forums/categories/:id' => 'forum_posts#category', as: :forum_category
  resources :forum_posts, path: 'forums'


  get 'account'         => 'account#show',    as: :account

  %w[stories forums watches favs notifications edit cancel].each do |name|
    get "account/#{name}" => "account##{name}", as: "#{name}_account"
  end
  put 'account'         => 'account#update'
  delete 'account'      => 'account#destroy'
  resources :messages, :path => "/account/messages", except: [:edit, :update] do
    member do 
      put :report
    end
    collection do 
      get :sent
    end
  end
  resources :notifications, :path => '/account/notifications', only: [:destroy]
  resources :watches, only: [:create, :destroy]
  resources :favs, only: [:create, :destroy]
  resources :reports, only: [:create]



  post 'convert_word_doc' => 'home#convert_word_doc', as: :convert_word_doc

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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
