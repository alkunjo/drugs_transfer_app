class DtransController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaksi, only: [:index, :new, :create, :edit, :update, :destroy]
  #before_action :set_obats, only: [:index, :new]
  autocomplete :obat, :obat_name, full: true
  
  def index
    @transaksi = Transaksi.find(params[:transaksi_id])
    @dtrans = @transaksi.dtrans.present?
    # @dtran = Dtran.new
    @dtran = @transaksi.dtrans.new
    # @dtran = @transaksi.dtrans.find(params[:id])
  end

  def new
    transaksi = Transaksi.find(params[:transaksi_id])
    @dtrans = transaksi.dtrans.present?
    # @dtran = transaksi.dtrans.build

    respond_to do |format|
      format.js {render action: 'new'}
    end
  end

  def create
    dtran = Dtran.new(dtran_params)
    transaksi = Transaksi.find(params[:transaksi_id])
    obat = Obat.find_by_obat_name(dtran.obat_name)
    stok = Stock.find_by(outlet_id: current_user.outlet_id, obat_id: obat.obat_id)
    exist = Dtran.where(transaksi_id: transaksi.transaksi_id, stock_id: stok.stock_id).first
    if exist
    	exist.update_attribute(:dta_qty, (exist.dta_qty + dtran.dta_qty))
	    if exist.save
    		respond_to do |format|
	        format.js {render "save_ask"}
	      end
	    end
    else
	    @dtran = @transaksi.dtrans.new(dta_qty: dtran.dta_qty, stock_id: stok.stock_id, transaksi_id: transaksi.transaksi_id)

      respond_to do |format|
        if @dtran.save
          @dtran = Dtran.new(transaksi_id: @transaksi.transaksi_id)
          return new
	      end
	    end
    end
  end

  def edit
    transaksi = Transaksi.find(params[:transaksi_id])
    dtrans = transaksi.dtrans
    @dtran = transaksi.dtrans.find(params[:id])
    respond_to do |format|
      # logger.debug 'rendering edit.js.erb'
      format.js {render action: 'edit'}
    end
  end

  def update
    transaksi = Transaksi.find(params[:transaksi_id])
    @dtran = transaksi.dtrans.find(params[:id])
    stok = Stock.find_by(obat_id: @dtran.stock.obat.obat_id, outlet_id: current_user.outlet_id)
    beri = dtran_params[:dtd_qty].to_f.nil? ? 0 : dtran_params[:dtd_qty].to_f
    if (stok.stok_qty - beri) < stok.current_ss #jika sisa stok yang diberikan kurang dari current ss
      flash.now[:danger] = "Jumlah beri melebihi safety stock obat"
    elsif beri > @dtran.dta_qty
      flash.now[:danger] = "Jumlah beri melebihi yang diminta"
    else
      @dtran.update(dtran_params)
      if @dtran.dtt_qty.nil?
        @dtran.update_attribute(:dtt_qty, @dtran.dtd_qty)
      end
      flash.now[:success] = "Dropping obat berhasil ditambahkan"
    end
    respond_to do |format|
      format.js { render 'save_drop'}
    end
  end

  def destroy
    @dtran = @transaksi.dtrans.find(params[:id])
    @dtran.destroy
    respond_to do |format|
      @dtran = Dtran.new(transaksi_id: @transaksi.transaksi_id)
      return new
    end
  end

  private
    def set_transaksi
      @transaksi = Transaksi.find(params[:transaksi_id])
    end

    def set_obats
      @obats = Obat.all
    end

    def dtran_params
      params.require(:dtran).permit(:dta_qty, :dtd_qty, :dtd_rsn, :obat_id, :transaksi_id, :obat_name, :dtt_qty, :dtt_rsn)
    end
end
