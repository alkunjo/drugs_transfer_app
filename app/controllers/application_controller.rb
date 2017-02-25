class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configured_permitted_parameters, if: :devise_controller?

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

  protected

  def configured_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :email, :password, :password_confirmation, :remember_me])
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:user_name, :email, :password, :remember_me)
    end
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_username, :email, :password, :password_confirmation, :current_password])
  end
  
  def after_sign_in_path_for(resource)
    return dashboard_index_path
  end
  def after_sign_out_path_for(resource)
    return new_user_session_path
  end

  def search_params
    params[:q]
  end
   
  def clear_search_index
    if params[:search_cancel]
      params.delete(:search_cancel)
      if(!search_params.nil?)
        search_params.each do |key, param|
          search_params[key] = nil
        end
      end
    end
  end


end
