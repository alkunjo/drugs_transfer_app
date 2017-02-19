class OutletsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_outlet, only: [:show, :edit, :update, :destroy, :del]
  before_action :set_outlets, only: [:index, :new, :create, :update, :edit, :destroy, :del]
  before_action :set_otypes, only: [:new, :create, :edit, :update, :index]

  def index
    @outlet = Outlet.new
  end

  def show
    respond_to do |format|
      format.js {render 'show'}
    end
  end

  def new
    @outlet = Outlet.new
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
    @outlet = Outlet.new(outlet_params)

    respond_to do |format|
      if @outlet.save
        return new
      end
    end
  end

  def update
    respond_to do |format|
      if @outlet.update(outlet_params)
        return new
      else
        format.js {render 'edit'}
      end
    end
  end

  def destroy
    @outlet.destroy
    respond_to do |format|
      return new
    end
  end

  private
    def set_outlet
      @outlet = Outlet.find(params[:id])
    end

    def set_outlets
      @outlets = Outlet.paginate(:page => params[:page], :per_page => 6)
    end

    def set_otypes
      @otypes = OutletType.all
    end

    def outlet_params
      params.require(:outlet).permit(:outlet_name, :outlet_address, :outlet_phone, :outlet_city, :outlet_email, :outlet_fax, :otype_id)
    end
end
