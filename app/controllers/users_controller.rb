class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :del]
  before_action :set_users, only: [:index, :new, :create, :update, :edit, :destroy, :del]
  before_action :set_outlets, only: [:index, :new, :create, :update, :edit, :destroy, :del]
  before_action :set_roles, only: [:index, :new, :create, :update, :edit, :destroy, :del]
  def index
    @user = User.new
  end

  def show
    respond_to do |format|
      format.js {render 'show'}
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.js {render 'new'}
    end
  end

  def edit
  end

  def del
    respond_to do |format| 
      format.js {render 'del'}
    end
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        return new
      end
    end
  end

  def update
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    success = if need_password?(@user, user_params)
                @user.update(user_params)
              else
                @user.update_without_password(user_params)
              end

    respond_to do |format|
      if success
        return new
      else
        format.js { render 'edit' }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      return new
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_users
      @users = User.paginate(:page => params[:page], :per_page => 6)
    end

    def user_params
      params.require(:user).permit(:user_name, :user_fullname, :user_address, :user_phone, :role_id, :outlet_id, :role_name, :outlet_name, :email, :password, :password_confirmation)
    end

    def set_roles
      @roles = Role.all
    end

    def set_outlets
      @outlets = Outlet.all
    end

    def need_password?(user, params)
      params[:password].present?
    end
end
