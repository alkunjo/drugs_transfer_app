module ApplicationHelper
	def current_path
		if controller_name == "outlets" 
			return "Master Outlet"
		elsif controller_name == "outlet_types" 
			return "Master Tipe Outlet"
		elsif controller_name == "distances" 
			return "Master Jarak Antar Outlet"
		elsif controller_name == "users" 
			return "Master Pengguna"
		elsif controller_name == "roles"
			return "Master Peran Pengguna"
		elsif controller_name == "obats" 
			return "Master Obat"
		elsif controller_name == "stocks" 
			return "Master Stok Obat"
		elsif controller_name == "safety_stocks" 
			return "Perhitungan Safety Stock Obat"
		elsif controller_name == "ss_periods"
			return "Master Periode Safety Stock"
		elsif controller_name == "transaksis"
			if current_page?(controller: 'transaksis', action: 'ask')
				return "Transaksi Permintaan Obat"
			elsif current_page?(controller: 'transaksis', action: 'drop')
				return "Transaksi Dropping Obat"
			elsif current_page?(controller: 'transaksis', action: 'accept')
				return "Transaksi Penerimaan Obat"
			elsif current_page?(controller: 'transaksis', action: 'report_ask')
				return "Laporan Bulanan Permintaan Obat"
			elsif current_page?(controller: 'transaksis', action: 'report_drop')
				return "Laporan Bulanan Dropping Obat"
			elsif current_page?(controller: 'transaksis', action: 'report_accept')
				return "Laporan Bulanan Penerimaan Obat"
			end
		end
	end

	def active?(link_path)
		current_page?(link_path) ? "active" : ""
	end

end