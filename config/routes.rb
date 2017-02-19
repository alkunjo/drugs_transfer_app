Rails.application.routes.draw do
  resources :ss_periods
  resources :stocks do
    get :autocomplete_obat_obat_name, on: :collection
    get :autocomplete_outlet_outlet_name, on: :collection
  end

  resources :distances
  resources :obats
  resources :outlets
  resources :roles
  resources :outlet_types

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
end
