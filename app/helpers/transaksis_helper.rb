module TransaksisHelper
	def obat(stok_id)
		stok = Stock.find_by(stock_id: stok_id)
		# logger.debug "#{stok.obat.obat_name}"
		return stok.obat.obat_name
	end

	def buttonSwitch(transaksi)
		if transaksi.present?			
			if transaksi.dtrans.present?
				return link_to("Cek Ketersediaan Obat", cek_availability_transaksis_path(transaksi_id: @transaksi.transaksi_id), class: "btn btn-md btn-primary", remote: true)
			else 
				return link_to("Buat Permintaan Obat", add_ask_transaksis_path(sender_id: current_user.outlet.outlet_id), method: :post, remote: true, class: "btn btn-md btn-success")
			end
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

end