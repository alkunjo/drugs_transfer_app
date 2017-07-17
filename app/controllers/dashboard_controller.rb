class DashboardController < ApplicationController
	before_action :authenticate_user!
	include DashboardHelper
	include NotificationsHelper
	autocomplete :outlet, :outlet_name, full: true	
	autocomplete :obat, :obat_name, full: true
	before_action :set_obats, only: [:index]
  before_action :set_outlets, only: [:index]
	
	def index
		@obats = Obat.all
		transaksi
		data_safety_stok
		data_transaksi
		indikasi
		kemasan
		bentuk
		# notif
	end

	def data_safety_stok
		obat_name = params[:obat_name].present? ? params[:obat_name] : 'A VOGEL AESCULLUS 50ML'
		@obat = Obat.find_by(obat_name: obat_name)

		sql = "SELECT CONCAT(MONTHNAME(ss_period_period),' ',YEAR(ss_period_period)), 
		safety_stock_qty FROM safety_stocks ss join ss_periods sp on ss.ss_period_id = sp.ss_period_id 
		join stocks s on ss.stock_id = s.stock_id join obats o on o.obat_id = s.obat_id join 
		outlets ot on s.outlet_id = ot.outlet_id WHERE o.obat_name= '#{obat_name}' and ot.outlet_name = 'KF No. 25 Darmo'"
		@safety_stocks = ActiveRecord::Base.connection.execute(sql)
		logger.debug "#{@safety_stocks}"
		@color26 = random_color(26)
		if params[:obat_name].present?
			respond_to do |format|
	      format.js {render 'stok_aman'}
	    end
	  end
	end

	# use this to call all necessary data like indications, kemasans and bentuks
	def data_transaksi
		if current_user.admin?
			@transaksis = Transaksi.all
		elsif current_user.pengadaan?
			@transaksis = Transaksi.where(sender_id: current_user.outlet_id)
		else
			@transaksis = Transaksi.where(sender_id: current_user.outlet_id).or(Transaksi.where(receiver_id: current_user.outlet_id))
		end
	end

	def notif
		if current_user.present?
			if current_user.admin?
	  		@notifications = Notification.all.reverse
	  	else
	  		@notifications = Notification.where(recipient_id: current_user.outlet_id).reverse
	  	end
		end
	end

	def indikasi
		if current_user.admin?
			sql = "select indication_name, sum(dta_qty) as banyak from dtrans dt 
			join transaksis t on dt.transaksi_id = t.transaksi_id 
			join stocks s on dt.stock_id = s.stock_id 
			join obats o on s.obat_id = o.obat_id 
			join indications i on o.indication_id = i.indication_id 
			group by indication_name"
		else	
			sql = "select indication_name, sum(dta_qty) as banyak from dtrans dt 
			join transaksis t on dt.transaksi_id = t.transaksi_id 
			join stocks s on dt.stock_id = s.stock_id 
			join obats o on s.obat_id = o.obat_id 
			join indications i on o.indication_id = i.indication_id 
			where t.sender_id = #{current_user.outlet_id} or t.receiver_id = #{current_user.outlet_id} 
			group by indication_name"
		end
		@indikasis = ActiveRecord::Base.connection.execute(sql)
	end

	def kemasan
		if current_user.admin?
			sql = "select kemasan_name, sum(dta_qty) as banyak from dtrans dt 
			join transaksis t on dt.transaksi_id = t.transaksi_id 
			join stocks s on dt.stock_id = s.stock_id 
			join obats o on s.obat_id = o.obat_id 
			join kemasans k on o.kemasan_id = k.kemasan_id 
			group by kemasan_name"
		else
			sql = "select kemasan_name, sum(dta_qty) as banyak from dtrans dt 
			join transaksis t on dt.transaksi_id = t.transaksi_id 
			join stocks s on dt.stock_id = s.stock_id 
			join obats o on s.obat_id = o.obat_id 
			join kemasans k on o.kemasan_id = k.kemasan_id 
			where t.sender_id = #{current_user.outlet_id} or t.receiver_id = #{current_user.outlet_id} 
			group by kemasan_name"
		end
		@kemasans = ActiveRecord::Base.connection.execute(sql)
	end

	def bentuk
		if current_user.admin?
			sql = "select bentuk_name, sum(dta_qty) as banyak from dtrans dt 
			join transaksis t on dt.transaksi_id = t.transaksi_id 
			join stocks s on dt.stock_id = s.stock_id 
			join obats o on s.obat_id = o.obat_id 
			join bentuks b on o.bentuk_id = b.bentuk_id 
			group by bentuk_name"
		else
			sql = "select bentuk_name, sum(dta_qty) as banyak from dtrans dt 
			join transaksis t on dt.transaksi_id = t.transaksi_id 
			join stocks s on dt.stock_id = s.stock_id 
			join obats o on s.obat_id = o.obat_id 
			join bentuks b on o.bentuk_id = b.bentuk_id 
			where t.sender_id = #{current_user.outlet_id} or t.receiver_id = #{current_user.outlet_id} 
			group by bentuk_name"
		end
		@bentuks = ActiveRecord::Base.connection.execute(sql)
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
		# logger.debug "#{@transaksi_ask}"
		if current_user.admin?
			@trans_nil_count = Transaksi.where(trans_status: nil).count()
			@trans_ask_count = Transaksi.where(trans_status: [1,2,3]).count()
			@trans_drop_count = Transaksi.where(trans_status: [2,3]).count()
			@trans_acc_count = Transaksi.where(trans_status: 3).count()
		else
			@trans_nil_count = Transaksi.where(trans_status: nil).where(sender_id: current_user.outlet_id).count()
			@trans_ask_count = Transaksi.where(trans_status: [1,2,3]).where(sender_id: current_user.outlet_id).count()
			@trans_drop_count = Transaksi.where(trans_status: [2,3]).where(receiver_id: current_user.outlet_id).count()
			@trans_acc_count = Transaksi.where(trans_status: 3).where(sender_id: current_user.outlet_id).count()
		end
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