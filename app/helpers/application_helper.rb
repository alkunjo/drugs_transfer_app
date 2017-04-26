module ApplicationHelper
	def current_path
		if controller_name == "outlets" 
			return '<a class="navbar-brand" href="#">Master Outlet</a>'.html_safe
		elsif controller_name == "outlet_types" 
			return '<a class="navbar-brand" href="#">Master Tipe Outlet</a>'.html_safe
		elsif controller_name == "distances" 
			return '<a class="navbar-brand" href="#">Master Jarak Antar Outlet</a>'.html_safe
		elsif controller_name == "users" 
			return '<a class="navbar-brand" href="#">Master Pengguna</a>'.html_safe
		elsif controller_name == "roles"
			return '<a class="navbar-brand" href="#">Master Peran Pengguna</a>'.html_safe
		elsif controller_name == "obats" 
			return '<a class="navbar-brand" href="#">Master Obat &nbsp;&nbsp;|</a> <a class="navbar-brand" href="/stocks">Master Stok Obat</a>'.html_safe
		elsif controller_name == "stocks" 
			return '<a class="navbar-brand" href="#">Master Stok Obat &nbsp;&nbsp;|</a> <a class="navbar-brand" href="/obats">Master Obat</a>'.html_safe
		elsif controller_name == "safety_stocks" 
			return '<a class="navbar-brand" href="#">Perhitungan Safety Stock Obat</a>'.html_safe
		elsif controller_name == "ss_periods"
			return '<a class="navbar-brand" href="#">Master Periode</a>'.html_safe
		elsif controller_name == "transaksis"
			if current_page?(controller: 'transaksis', action: 'ask')
				return '<a class="navbar-brand" href="#">Transaksi Permintaan Obat</a>'.html_safe
			elsif current_page?(controller: 'transaksis', action: 'drop')
				return '<a class="navbar-brand" href="#">Transaksi Dropping Obat</a>'.html_safe
			elsif current_page?(controller: 'transaksis', action: 'accept')
				return '<a class="navbar-brand" href="#">Transaksi Penerimaan Obat</a>'.html_safe
			elsif current_page?(controller: 'transaksis', action: 'report_ask')
				return '<a class="navbar-brand" href="#">Laporan Bulanan Permintaan Obat</a>'.html_safe
			elsif current_page?(controller: 'transaksis', action: 'report_drop')
				return '<a class="navbar-brand" href="#">Laporan Bulanan Dropping Obat</a>'.html_safe
			elsif current_page?(controller: 'transaksis', action: 'report_accept')
				return '<a class="navbar-brand" href="#">Laporan Bulanan Penerimaan Obat</a>'.html_safe
			end
		elsif controller_name == "dashboard"
			if current_user.admin? or current_user.pimpinan?
				return '<a class="navbar-brand" href="#">Halaman Dashboard Administrator</a>'.html_safe
			elsif current_user.pengadaan?
				return '<a class="navbar-brand" href="#">Halaman Dashboard PIC Pengadaan</a>'.html_safe
			elsif current_user.gudang?
				return '<a class="navbar-brand" href="#">Halaman Dashboard PIC Gudang</a>'.html_safe
			end
		end
	end

	def active?(link_path)
		current_page?(link_path) ? "active" : ""
	end

end