class SsPeriodsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_ss_period, only: [ :edit, :update, :destroy, :del]
  before_action :set_ss_periods, only: [:index, :new, :create, :update, :edit, :destroy, :del]
  
  def index
    @ss_period = SsPeriod.new
  end

  def new
    @ss_period = SsPeriod.new
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
    @ss_period = SsPeriod.new(ss_period_params)

    respond_to do |format|
      if @ss_period.save
        return new
      end
    end
  end

  def update
    respond_to do |format|
      if @ss_period.update(ss_period_params)
        return new
      else
        format.js {render 'edit'}
      end
    end
  end

  def destroy
    @ss_period.destroy
    respond_to do |format|
      return new
    end
  end

  private
    def set_ss_period
      @ss_period = SsPeriod.find(params[:id])
    end

    def set_ss_periods
      @ss_periods = SsPeriod.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ss_period_params
      params.require(:ss_period).permit(:ss_period_period)
    end
end
