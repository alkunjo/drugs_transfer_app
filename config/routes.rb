Rails.application.routes.draw do
  resources :satuans
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
  get 'satuans/:id/del' => 'satuans#del', as: :del_satuan
  get 'users/:id/del' => 'users#del', as: :del_user
end
