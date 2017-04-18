class KemasansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_kemasan, only: [ :edit, :update, :destroy, :del]
  before_action :set_kemasans, only: [:index, :new, :create, :update, :edit, :destroy, :del]
  
  def index
    @kemasan = Kemasan.new
  end

  def new
    @kemasan = Kemasan.new
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
    @kemasan = Kemasan.new(kemasan_params)

    respond_to do |format|
      if @kemasan.save
        return new
      end
    end
  end

  def update
    respond_to do |format|
      if @kemasan.update(kemasan_params)
        return new
      else
        format.js {render 'edit'}
      end
    end
  end

  def destroy
    @kemasan.destroy
    respond_to do |format|
      return new
    end
  end

  private
    def set_kemasan
      @kemasan = Kemasan.find(params[:id])
    end

    def set_kemasans
      @kemasans = Kemasan.all
    end

    def kemasan_params
      params.require(:kemasan).permit(:kemasan_name)
    end
end
