Rails.application.routes.draw do
  resources :transaksis do
    resources :dtrans do
      get :autocomplete_obat_obat_name, on: :collection
      get :i_ask, on: :collection
      get :i_drop, on: :collection
      get :i_accept, on: :collection
    end
    member do
      get 'show_ask'
      get 'show_drop'
      get 'show_accept'
      get 'skrip_bpba'
      get 'skrip_drop'
      get 'skrip_accept'
      get 'validate_ask'
      get 'validate_drop'
      get 'validate_accept'
      get 'valdrop'
      get 'del'
    end
    collection do
      get :autocomplete_obat_obat_name
      post :get_accept
      get :autocomplete_outlet_outlet_name
      get :ask
      get :cek_availability
      get :drop
      get :accept
      get :reports
      get :report_ask
      get :report_drop
      get :report_accept
      post :report_ask_control
      get :report_ask_control
      post :report_drop_control
      get :report_drop_control
      post :report_accept_control
      get :report_accept_control
      post :add_ask
      
    end
  end

  resources :distances
  
  resources :safety_stocks do
    collection {post :import}
  end
  resources :ss_periods
  resources :stocks do
    get :autocomplete_obat_obat_name, on: :collection
    get :autocomplete_outlet_outlet_name, on: :collection
  end

  resources :obats
  resources :outlets
  resources :roles
  resources :outlet_types

  resources :dashboard
  root to: "dashboard#index"  

  devise_for :users
	scope "/admin" do
		resources :users
	end

  get 'obats/:id/del' => 'obats#del', as: :del_obat
  get 'outlets/:id/del' => 'outlets#del', as: :del_outlet
  get 'outlet_types/:id/del' => 'outlet_types#del', as: :del_outlet_type
  get 'users/:id/del' => 'users#del', as: :del_user
  get 'distances/:id/del' => 'distances#del', as: :del_distance
  get 'roles/:id/del' => 'roles#del', as: :del_role
  get 'stocks/:id/del' => 'stocks#del', as: :del_stock
  get 'ss_periods/:id/del' => 'ss_periods#del', as: :del_ss_period
  get 'safety_stocks/:id/del' => 'safety_stocks#del', as: :del_safety_stock
end
