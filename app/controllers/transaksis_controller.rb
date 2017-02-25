class TransaksisController < ApplicationController
  before_action :set_transaksi, only: [:show, :edit, :update, :destroy]

  # GET /transaksis
  # GET /transaksis.json
  def index
    @transaksis = Transaksi.all
  end

  # GET /transaksis/1
  # GET /transaksis/1.json
  def show
  end

  # GET /transaksis/new
  def new
    @transaksi = Transaksi.new
  end

  # GET /transaksis/1/edit
  def edit
  end

  # POST /transaksis
  # POST /transaksis.json
  def create
    @transaksi = Transaksi.new(transaksi_params)

    respond_to do |format|
      if @transaksi.save
        format.html { redirect_to @transaksi, notice: 'Transaksi was successfully created.' }
        format.json { render :show, status: :created, location: @transaksi }
      else
        format.html { render :new }
        format.json { render json: @transaksi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transaksis/1
  # PATCH/PUT /transaksis/1.json
  def update
    respond_to do |format|
      if @transaksi.update(transaksi_params)
        format.html { redirect_to @transaksi, notice: 'Transaksi was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaksi }
      else
        format.html { render :edit }
        format.json { render json: @transaksi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transaksis/1
  # DELETE /transaksis/1.json
  def destroy
    @transaksi.destroy
    respond_to do |format|
      format.html { redirect_to transaksis_url, notice: 'Transaksi was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaksi
      @transaksi = Transaksi.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaksi_params
      params.require(:transaksi).permit(:receiver_id, :sender_id, :trans_status, :asked_at, :dropped_at, :accepted_at)
    end
end
