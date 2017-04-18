class BentuksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bentuk, only: [ :edit, :update, :destroy, :del]
  before_action :set_bentuks, only: [:index, :new, :create, :update, :edit, :destroy, :del]
  
  def index
    @bentuk = Bentuk.new
  end

  def new
    @bentuk = Bentuk.new
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
    @bentuk = Bentuk.new(bentuk_params)

    respond_to do |format|
      if @bentuk.save
        return new
      end
    end
  end

  def update
    respond_to do |format|
      if @bentuk.update(bentuk_params)
        return new
      else
        format.js {render 'edit'}
      end
    end
  end

  def destroy
    @bentuk.destroy
    respond_to do |format|
      return new
    end
  end


  private
    def set_bentuk
      @bentuk = Bentuk.find(params[:id])
    end

    def set_bentuks
      @bentuks = Bentuk.all
    end

    def bentuk_params
      params.require(:bentuk).permit(:bentuk_name)
    end
end
