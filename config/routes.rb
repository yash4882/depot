Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  resources :support_requests, only: [ :index, :update ]
  
  resources :users
  resources :orders
 
  
  
  resources :line_items do
    member do
      get :item_delete
    end
  end

  resources :carts
  resources :products

  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as: 'store_index', via: :all
  end

  post 'payments/create', to: 'payments#create'
  get 'payments/create', to: 'payments#create'
  get 'store/contact', to: 'store#contact'
  get 'store/questions', to: 'store#questions'
  get 'store/news', to: 'store#news'

  resources :products do
    resources :comments
  end

end
