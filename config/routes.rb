# feedbacks_path   GET   /feedbacks(.:format)  feedbacks#index
# POST   /feedbacks(.:format)  feedbacks#create
# new_feedback_path  GET   /feedbacks/new(.:format)  feedbacks#new
# edit_feedback_path   GET   /feedbacks/:id/edit(.:format)   feedbacks#edit
# feedback_path  GET   /feedbacks/:id(.:format)  feedbacks#show
# PATCH  /feedbacks/:id(.:format)  feedbacks#update
# PUT  /feedbacks/:id(.:format)  feedbacks#update
# DELETE   /feedbacks/:id(.:format)  feedbacks#destroy
Oldweb::Application.routes.draw do
  #resources :feedbacks

  #resources :ir_messages

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

  #携帯サイトへのリダイレクト
  constraints host: "www2.yamaokaya.jp" do
    get '/' => 'forward#index'
    get 'index(.:format)' => 'forward#index'
  end
  constraints host: "www.yamaokaya.jp" do
    get '/' => 'forward#index'
    get 'index(.:format)' => 'forward#index'
  end
  constraints host: "yamaokaya.jp" do
    get '/' => 'forward#index'
    get 'index(.:format)' => 'forward#index'
  end

  TopController
  root 'top#index'
  get 'index(.:format)' => 'top#index'

  CompanyController.route_keys do |path,key|
    get path => key
  end

  get '/shops(.:format)' => 'shop#shops'
  get 'shop/m' => 'shop#mobile'
  ShopController.route_keys do |path,key|
    get path => key
  end




  #Menu
  MenuController.route_keys do |path,key|
    get path => key
  end

  #Property
  PropertyController.route_keys do |path,key|
    get path => key
  end

  #Recruit
  RecruitController.route_keys do |path,key|
    get path => key
  end
  post 'recruit/entry' => 'recruit#entry_post'

  #IR
  IrController.route_keys do |path,key|
    get path => key
  end

  post 'ir/contact' => 'ir#send_message'

  #feedbacks
  get 'feedbacks(.:format)' => 'feedbacks#index'
  post 'feedbacks(.:format)' => 'feedbacks#send_message'
  get 'feedbacks_search' => 'feedbacks#search'
  get 'feedbacks/:id(.:format)' => 'feedbacks#api'
  #site
  SiteController.route_keys do |path,key|
    get path => key
  end

  #news
  NewsController.route_keys do |path,key|
    get path => key
  end
  # get 'company/index' => 'company#index'
  # get 'company/history' => 'company#history'
  # get 'company/sns_guideline' => 'company#sns_guideline'
  # get 'company/aniv_25' => 'company#aniv_25'


end
