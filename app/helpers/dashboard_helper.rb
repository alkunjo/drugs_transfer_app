module DashboardHelper
	def random_color(jml)
		color = Array.new
		for	i in 1..jml
			warna = "##{'%06x' % (rand * 0xffffff)}"
			color.push(warna)
		end
		return color
	end

	def dashboard
		if current_user.admin?
			render 'dashboard_admin'
		elsif current_user.pengadaan?
			render 'dashboard_ask'
		elsif current_user.gudang?
			render 'dashboard_drop'
		end
	end
end