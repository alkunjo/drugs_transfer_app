class OutletTypesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_outlet_type, only: [ :edit, :update, :destroy, :del]
  before_action :set_outlet_types, only: [:index, :new, :create, :update, :edit, :destroy, :del]
  
  def index
    @outlet_type = OutletType.new
  end

  def new
    @outlet_type = OutletType.new
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
    @outlet_type = OutletType.new(outlet_type_params)

    respond_to do |format|
      if @outlet_type.save
        return new
      end
    end
  end

  def update
    respond_to do |format|
      if @outlet_type.update(outlet_type_params)
        return new
      else
        format.js {render 'edit'}
      end
    end
  end

  def destroy
    @outlet_type.destroy
    respond_to do |format|
      return new
    end
  end


  private
    def set_outlet_type
      @outlet_type = OutletType.find(params[:id])
    end

    def set_outlet_types
      @outlet_types = OutletType.all
    end

    def outlet_type_params
      params.require(:outlet_type).permit(:otype_name)
    end
end
