class SatuansController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_satuan, only: [:show, :edit, :update, :destroy, :del]
  before_action :set_satuans, only: [:index, :new, :create, :update, :edit, :destroy, :del]

  def index
    @satuan = Satuan.new
  end

  def show
    respond_to do |format|
      format.js {render 'show'}
    end
  end

  def new
    @satuan = Satuan.new
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
    @satuan = Satuan.new(satuan_params)

    respond_to do |format|
      if @satuan.save
        return new
      end
    end
  end

  def update
    respond_to do |format|
      if @satuan.update(satuan_params)
        return new
      else
        format.js {render 'edit'}
      end
    end
  end

  def destroy
    @satuan.destroy
    respond_to do |format|
      return new
    end
  end

  private
    def set_satuan
      @satuan = Satuan.find(params[:id])
    end

    def set_satuans
      @satuans = Satuan.paginate(:page => params[:page], :per_page => 10)
    end

    def satuan_params
      params.require(:satuan).permit(:satuan_code, :satuan_ukuran, :satuan_isi)
    end
end
