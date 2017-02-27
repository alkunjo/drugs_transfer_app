class SafetyStocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_safety_stock, only: [:del, :destroy]
  before_action :set_safety_stocks, only: [:index, :create, :destroy, :new]
  before_action :set_ss_periods, only: [:index, :create, :destroy, :new]
  
  def index
    @safety_stock = SafetyStock.new
  end

  def new
    @safety_stock = SafetyStock.new
    respond_to do |format|
      format.js {render 'new'}
    end
  end

  def del    
  end

  def create
    @safety_stock = SafetyStock.new(safety_stock_params)
    respond_to do |format|
      if @safety_stock.save
        return new
      end
    end
  end

  def destroy
    respond_to do |format|
      if @safety_stock.destroy
        return new
      end
    end
  end

  def import
    ss_period = SsPeriod.where(ss_period_id: params[:ss_period][:ss_period_id]).first
    ss_period_id = ss_period.ss_period_id.to_i
    logger.debug "Periode #{ss_period_id}"
    SafetyStock.import(params[:file], ss_period_id)
    redirect_to safety_stocks_path, notice: "Safety Stock berhasil diimport."
  end


  private
    def set_safety_stock
      @safety_stock = SafetyStock.find(params[:id])
    end

    def set_safety_stocks
      @safety_stocks = SafetyStock.paginate(:page => params[:page], :per_page => 10)
    end

    def set_ss_periods
      @ss_periods = SsPeriod.all
    end

    def safety_stock_params
      params.require(:safety_stock).permit(:ss_period_id, :stock_id, :safety_stock_qty)
    end
end
