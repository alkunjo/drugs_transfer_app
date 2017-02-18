module ApplicationHelper
	def current_path
		if controller_name == "outlets"
			return "Master Outlet"
		elsif controller_name == "users"
			return "Master Pengguna"
		elsif controller_name == "roles"
			return "Master Role"
		elsif controller_name == "outlet_types"
			return "Master Tipe Outlet"
		elsif controller_name == "obats" || controller_name == "stocks"
			return "Master Kelompok Obat"
		end
	end

	def active?(link_path)
		current_page?(link_path) ? "active" : ""
	end

end