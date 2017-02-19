class DistancesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_distance, only: [:show, :edit, :update, :destroy, :del]
  before_action :set_distances, only: [:index, :new, :create, :update, :edit, :destroy, :del]
  before_action :set_outlets, only: [:index, :new, :create, :update, :edit, :destroy, :del]

  def index
    @distance = Distance.new
  end

  def new
    @distance = Distance.new
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
    @distance = Distance.new(distance_params)

    respond_to do |format|
      if @distance.save
        return new
      end
    end
  end

  def update
    respond_to do |format|
      if @distance.update(distance_params)
        return new
      else
        format.js {render 'edit'}
      end
    end
  end

  def destroy
    @distance.destroy
    respond_to do |format|
      return new
    end
  end

  private
    def set_distance
      @distance = Distance.where(origin_id: params[:origin_id]).where(destination_id: params[:destination_id])
    end

    def set_distances
      if current_user.admin?
        @distances = Distance.paginate(:page => params[:page], :per_page => 10).where('origin_id != destination_id')
      else
        @distances = Distance.paginate(:page => params[:page], :per_page => 10).where(origin_id: current_user.outlet.outlet_id)
      end
    end

    def set_outlets
      @outlets = Outlet.all
    end

    def distance_params
      params.require(:distance).permit(:origin_id, :destination_id, :distance, :outlet_name, :outlet_id)
    end
end
