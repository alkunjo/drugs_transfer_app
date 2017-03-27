class DashboardController < ApplicationController
	include DashboardHelper
	before_action :authenticate_user!
	autocomplete :outlet, :outlet_name, full: true	
	autocomplete :obat, :obat_name, full: true
	before_action :set_obats, only: [:index]
  before_action :set_outlets, only: [:index]
	
	def index
		@obats = Obat.all
		# @transaksi_ask = Transaksi.select("count(transaksi_id) as jumlah").group("trans_status")
		transaksi
		data_safety_stok
	end

	def coba
		if current_user.admin?
			@transaksis = Transaksi.all
		elsif current_user.pengadaan?
			@transaksis = Transaksi.where(sender_id: current_user.outlet_id)
		else
			@transaksis = Transaksi.where(sender_id: current_user.outlet_id).or(where(receiver_id: current_user.outlet_id))
		end
	end

	def data_safety_stok
		@obat_name = params[:obat_name].nil? ? 'ACARBOSE 50MG' : params[:obat_name]
		sql = "
			SELECT outlets.outlet_name, stocks.current_ss
			FROM outlets JOIN stocks ON outlets.outlet_id = stocks.outlet_id
			JOIN obats ON stocks.obat_id = obats.obat_id
			WHERE obats.obat_name = '#{@obat_name}'"
		@safety_stocks = ActiveRecord::Base.connection.execute(sql)
		@color26 = random_color(26)
		if params[:obat_name].present?
			respond_to do |format|
	      format.js {render 'stok_aman'}
	    end
	  end
	end

	def transaksi
		sql_ask = "
		SELECT 
			CASE trans_status 
		    	WHEN 1 THEN 'Permintaan Tervalidasi' 
		        WHEN 2 THEN 'Dropping Tervalidasi' 
		        WHEN 3 THEN 'Dropping Diterima' 
		        ELSE 'Belum Tervalidasi' 
		    END AS 'status', count(*) as jml
		FROM transaksis
		GROUP BY status"
		@transaksi_ask = ActiveRecord::Base.connection.execute(sql_ask)
		@trans_ask_count = Transaksi.where(trans_status: 1).count()
		@trans_drop_count = Transaksi.where(trans_status: 2).count()
		@trans_acc_count = Transaksi.where(trans_status: 3).count()
	end

	def ss_on_obat
		
	end

	def permintaan
	end

	def dropping		
	end

	def penerimaan		
	end

	private
		def dashboard_params
      params.require(:transaksi).permit(:obat_name, :obat_id, :outlet_name, :outlet_id)
    end

    def set_obats
      @obats = Obat.all      
    end

    def set_outlets
      @outlets = Outlet.all
    end
end