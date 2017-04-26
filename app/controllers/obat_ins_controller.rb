class ObatInsController < ApplicationController
	before_action :authenticate_user!
	if @transaksi.present?
		before_action :set_transaksi, only: [:index, :edit, :accept]
	end
	
	before_action :set_obats, only: [:index]

	def index
		# if params[:obat_in].present?
		# 	@transaksi = Transaksi.find(params[:obat_in])
		# 	@dtrans = @transaksi.dtrans
		# end
	end

	def edit
		# @transaksi = Transaksi.find(params[:obat_in])
		@dtran = Dtran.find(params[:id])
		respond_to do |format|
			format.js {render "edit"}
		end
	end

	def update
		@dtran = Dtran.find(params[:id])
		@tran = Transaksi.find(@dtran.transaksi_id)
		@dtrans = @tran.dtrans

		if @dtran.update_column(:dtt_qty, params[:dtran][:dtt_qty])
			respond_to do |format|
				format.js {render "trans"}
			end
		end
	end

	def kirim
		@tran = Transaksi.find(params[:obat_in])
		@dtrans = @tran.dtrans

		@dtrans.each do	|dtran|
			if dtran.dtt_qty.nil?
				if dtran.dtd_qty.nil?
					dtran.dtt_qty = 0	
				else
					dtran.dtt_qty = dtran.dtd_qty
				end
			end
		end

		respond_to do |format|
			format.js {render 'trans'}
		end
	end

	def valter # same as validate_accept in transaction controller
		@tran = Transaksi.find(params[:id])
		@tran.update_attributes(:trans_status => 3, :accepted_at => Time.now.strftime("%Y-%m-%d %H:%M:%S"))
		if @tran
      penerima = Outlet.find(@tran.receiver_id)
      @tran.create_activity action: 'validate_accept', owner: current_user, recipient: penerima
      @dtrans = @tran.dtrans
      @dtrans.each do |dtran|
        @stok = Stock.where(outlet_id: @tran.receiver_id, obat_id: dtran.stock.obat_id).first
        trima = dtran.dtt_qty.present? ? dtran.dtt_qty : 0        
        stok = @stok.stok_qty + trima
        @stok.update_attributes(:stok_qty => stok, :updated_at => Time.now.strftime("%Y-%m-%d %H:%M:%S"))
      end
    end
    flash[:success] = "Stok berhasil ditambahkan"
    redirect_to stocks_url
	end

	private
	def set_transaksi
		@transaksi = Transaksi.find(params[:id])
	end

	def set_obats
		@obats = Obat.where(outlet_id: current_user.outlet_id)
	end

	def obat_in_params
		params.require(:obat_in).permit(:transaksi_id, :obat_in, :dtt_qty, :dtd_qty)
	end

	def dtran_params
		params.require(:dtran).permit(:transaksi_id, :dtt_qty, :dtd_qty)
	end

end
