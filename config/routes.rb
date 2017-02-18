Rails.application.routes.draw do
  resources :obats
  # match "*path" => redirect("/"), via: :all
  resources :outlets
  resources :roles
  resources :outlet_types

  root to: "dashboard#index"  

  devise_for :users
	scope "/admin" do
		resources :users
	end

  get 'obats/:id/del' => 'obats#del', as: :del_obat
end
