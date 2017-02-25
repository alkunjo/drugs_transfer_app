class DtransController < ApplicationController
  before_action :set_dtran, only: [:show, :edit, :update, :destroy]

  # GET /dtrans
  # GET /dtrans.json
  def index
    @dtrans = Dtran.all
  end

  # GET /dtrans/1
  # GET /dtrans/1.json
  def show
  end

  # GET /dtrans/new
  def new
    @dtran = Dtran.new
  end

  # GET /dtrans/1/edit
  def edit
  end

  # POST /dtrans
  # POST /dtrans.json
  def create
    @dtran = Dtran.new(dtran_params)

    respond_to do |format|
      if @dtran.save
        format.html { redirect_to @dtran, notice: 'Dtran was successfully created.' }
        format.json { render :show, status: :created, location: @dtran }
      else
        format.html { render :new }
        format.json { render json: @dtran.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dtrans/1
  # PATCH/PUT /dtrans/1.json
  def update
    respond_to do |format|
      if @dtran.update(dtran_params)
        format.html { redirect_to @dtran, notice: 'Dtran was successfully updated.' }
        format.json { render :show, status: :ok, location: @dtran }
      else
        format.html { render :edit }
        format.json { render json: @dtran.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dtrans/1
  # DELETE /dtrans/1.json
  def destroy
    @dtran.destroy
    respond_to do |format|
      format.html { redirect_to dtrans_url, notice: 'Dtran was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dtran
      @dtran = Dtran.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dtran_params
      params.require(:dtran).permit(:stock_id, :transaksi_id, :dta_qty, :dtd_qty, :dtt_qty, :dtd_rsn, :dtt_rsn, :belongs_to)
    end
end
