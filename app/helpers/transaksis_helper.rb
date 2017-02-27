module TransaksisHelper
	def obat(stok_id)
		stok = Stock.find_by(stock_id: stok_id)
		logger.debug "#{stok.obat.obat_name}"
		return stok.obat.obat_name
	end

	def buttonSwitch(transaksi)
		if transaksi.dtrans.present?
			return link_to("Cek Ketersediaan Obat", cek_availability_transaksis_path(transaksi_id: @transaksi.transaksi_id), class: "btn btn-md btn-primary", remote: true)
		else 
			return link_to("Buat Permintaan Obat", add_ask_transaksis_path(sender_id: current_user.outlet.outlet_id), method: :post, remote: true, class: "btn btn-md btn-success")
		end
	end
end
