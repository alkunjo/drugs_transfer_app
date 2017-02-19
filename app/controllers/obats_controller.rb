class ObatsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_obat, only: [:show, :edit, :update, :destroy, :del]
  before_action :set_obats, only: [:index, :new, :create, :update, :edit, :destroy, :del]

  def index
    @obat = Obat.new
  end

  def show
    respond_to do |format|
      format.js {render 'show'}
    end
  end

  def new
    @obat = Obat.new
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
    @obat = Obat.new(obat_params)

    respond_to do |format|
      if @obat.save
        return new
      end
    end
  end

  def update
    respond_to do |format|
      if @obat.update(obat_params)
        return new
      else
        format.js {render 'edit'}
      end
    end
  end

  def destroy
    @obat.destroy
    respond_to do |format|
      return new
    end
  end

  private
    def set_obat
      @obat = Obat.find(params[:id])
    end

    def set_obats
      @obats = Obat.paginate(:page => params[:page], :per_page => 10)     
    end

    def obat_params
      params.require(:obat).permit(:obat_name, :obat_hpp)
    end
end
