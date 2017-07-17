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

	# def ntf
	# 	if current_user.admin?
 #  		ceknotif = Notification.all.where(readStat_admin: nil).count()
 #  	elsif current_user.pimpinan?
 #  		ceknotif = Notification.where(recipient_id: current_user.outlet_id).where(readStat_manager: nil).count()
 #  	else
 #  		ceknotif = Notification.where(recipient_id: current_user.outlet_id).where(readStat_receiver: nil).count()
 #  	end
	# 	if ceknotif > 0
	# 		return "<i class='fa fa-bell faa-bounce animated'></i>".html_safe
	# 	end
	# end
end