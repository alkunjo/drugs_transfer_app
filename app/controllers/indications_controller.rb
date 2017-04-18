class IndicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_indication, only: [ :edit, :update, :destroy, :del]
  before_action :set_indications, only: [:index, :new, :create, :update, :edit, :destroy, :del]
  
  def index
    @indication = Indication.new
  end

  def new
    @indication = Indication.new
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
    @indication = Indication.new(indication_params)

    respond_to do |format|
      if @indication.save
        return new
      end
    end
  end

  def update
    respond_to do |format|
      if @indication.update(indication_params)
        return new
      else
        format.js {render 'edit'}
      end
    end
  end

  def destroy
    @indication.destroy
    respond_to do |format|
      return new
    end
  end


  private
    def set_indication
      @indication = Indication.find(params[:id])
    end

    def set_indications
      @indications = Indication.paginate(:page => params[:page], :per_page => 8)
    end

    def indication_params
      params.require(:indication).permit(:indication_name)
    end
end