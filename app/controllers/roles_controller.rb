class RolesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_role, only: [ :edit, :update, :destroy, :del]
  before_action :set_roles, only: [:index, :new, :create, :update, :edit, :destroy, :del]
  
  def index
    @role = Role.new
  end

  def new
    @role = Role.new
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
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        return new
      end
    end
  end

  def update
    respond_to do |format|
      if @role.update(role_params)
        return new
      else
        format.js {render 'edit'}
      end
    end
  end

  def destroy
    @role.destroy
    respond_to do |format|
      return new
    end
  end

  private
    def set_role
      @role = Role.find(params[:id])
    end

    def set_roles
      @roles = Role.all
    end

    def role_params
      params.require(:role).permit(:role_name, :role_desc)
    end
end
