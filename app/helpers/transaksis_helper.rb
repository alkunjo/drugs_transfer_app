module TransaksisHelper
	def obat(stok_id)
		stok = Stock.find_by(stock_id: stok_id)
		# logger.debug "#{stok.obat.obat_name}"
		return stok.obat.obat_name
	end

	def buttonSwitch(transaksi)
		if transaksi.present? and transaksi.dtrans.present? and (controller.action_name == 'add_ask' or controller.action_name == 'create' or controller.action_name == 'destroy')
			return link_to("Cek Ketersediaan Obat", cek_availability_transaksis_path(transaksi_id: @transaksi.transaksi_id), class: "btn btn-md btn-primary", remote: true)
		else
			return link_to("Buat Permintaan Obat", add_ask_transaksis_path(sender_id: current_user.outlet.outlet_id), method: :post, remote: true, class: "btn btn-md btn-success")
		end
	end

	def avail
		flash.map do |key, value|
			content_tag :div, "<button class='close' data-dismiss='alert' aria-label='close'>&times;</button>#{value}", id: :key, class: "alert alert-#{key}"
		end
	end

	def bootstrap_class_for flash_type
    { success: "alert-success", danger: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

	def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in", style: 'color:#000') do 
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message 
      end)
    end
    nil
  end

  def to_rupiah(fill)
		number_to_currency( fill, unit: "Rp. ", separator: ',', delimeter: '.' )
	end

	def total_minta(cek)
		total = 0
		cek.dtrans.each do |dtran|
			hargaObat = Obat.find(dtran.stock.obat_id).obat_hpp * dtran.dta_qty
			total = total + hargaObat
		end
		return total
	end

	def total_dropping(cek)
		total = 0
		cek.dtrans.each do |dtran|
			hargaObat = Obat.find(dtran.stock.obat_id).obat_hpp * dtran.dtd_qty
			total = total + hargaObat
		end
		return total
	end

	def total_terima(cek)
		total = 0
		cek.dtrans.each do |dtran|
			hargaObat = Obat.find(dtran.stock.obat_id).obat_hpp * dtran.dtt_qty
			total = total + hargaObat
		end
		return total
	end

	def apotek(cek)
		apotek = Outlet.find(cek.receiver_id).outlet_name
		return apotek
	end

	def bulan(bulan)
		if bulan == 'January'
			return 'Januari'
		elsif bulan == 'February'
			return 'Februari'
		elsif bulan == 'March'
			return 'Maret'
		elsif bulan == 'April'
			return 'April'
		elsif bulan == 'May'
			return 'Mei'
		elsif bulan == 'June'
			return 'Juni'
		elsif bulan == 'July'
			return 'Juli'
		elsif bulan == 'August'
			return 'Agustus'
		elsif bulan == 'September'
			return 'September'
		elsif bulan == 'October'
			return 'Oktober'
		elsif bulan == 'November'
			return 'November'
		else
			return 'December'
		end
	end

end