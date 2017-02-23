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
		end
	end

	def active?(link_path)
		current_page?(link_path) ? "active" : ""
	end

end