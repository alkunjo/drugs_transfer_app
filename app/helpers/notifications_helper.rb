module NotificationsHelper
	def notify(notification)
		owner = User.find_by(user_id: notification.owner_id)
		recipient = Outlet.find_by(outlet_id: notification.recipient_id)
		
		transaksi = Transaksi.find_by(transaksi_id: notification.transaksi_id)
		bpba = "Nomor BPBA: B#{transaksi.sender_id}#{transaksi.receiver_id}#{transaksi.asked_at.strftime('%d%m%Y')}"

		message = if notification.key_message == "asked"
			" meminta obat dengan <b>#{bpba}</b> kepada outlet "
		elsif notification.key_message == "dropped"
			" memberikan obat berdasarkan <b>#{bpba}</b> kepada outlet "
		elsif notification.key_message == "accepted"
			" menerima obat berdasarkan <b>#{bpba}</b> dari outlet "
		end
		complete_message = "<b> #{owner.user_fullname} </b>"+ message + "<b> #{recipient.outlet_name} </b>"
		return complete_message.html_safe
	end

	def make_link(notification)
		complete_message = notify(notification)
		transaksi = Transaksi.find_by(transaksi_id: notification.transaksi_id)
		sign = ""
		style = 'font-size: 12px; color: #000'
		span = ""
		if notification.key_message == "asked"
			sign = "<i class='fa fa-arrow-circle-up fa-fw'></i>&nbsp;"
			span = "<span class='pull-right text-muted-small'>
								<em>#{transaksi.asked_at.strftime("%d %B %Y")}</em>
							</span>"
		elsif notification.key_message == "dropped"
			sign = "<i class='fa fa-arrow-circle-down fa-fw'></i>&nbsp;"
			span = "<span class='pull-right text-muted-small'>
								<em>#{transaksi.dropped_at.strftime("%d %B %Y")}</em>
							</span>"
		elsif notification.key_message == "accepted"
			sign = "<i class='fa fa-compress fa-fw'></i>&nbsp;"
			span = "<span class='pull-right text-muted-small'>
								<em>#{transaksi.accepted_at.strftime("%d %B %Y")}</em>
							</span>"
		end

		if current_user.admin?
			return link_to(adminRead_notification_path(notification), remote: true, style: style) do
				(sign+complete_message+span).html_safe
			end
		elsif current_user.pimpinan?
			return link_to(pimpinanRead_notification_path(notification), remote: true, style: style) do 
				(sign+complete_message+span).html_safe
			end 
		else	
			return link_to(otherRead_notification_path(notification), remote: true, style: style) do
				(sign+complete_message+span).html_safe
			end
		end
	end

	def ntf
		if current_user.admin?
  		ceknotif = Notification.all.where(readStat_admin: nil).count()
  	elsif current_user.pimpinan?
  		ceknotif = Notification.where(recipient_id: current_user.outlet_id).where(readStat_manager: nil).count()
  	else
  		ceknotif = Notification.where(recipient_id: current_user.outlet_id).where(readStat_receiver: nil).count()
  	end
		if ceknotif > 0
			return "<i class='fa fa-bell faa-horizontal animated'></i>".html_safe
		else
			return "<i class='fa fa-bell'></i>".html_safe
		end
	end

	def counterNotif
		if current_user.admin?
  		ceknotif = Notification.all.where(readStat_admin: nil).count()
  	elsif current_user.pimpinan?
  		ceknotif = Notification.where(recipient_id: current_user.outlet_id).where(readStat_manager: nil).count()
  	else
  		ceknotif = Notification.where(recipient_id: current_user.outlet_id).where(readStat_receiver: nil).count()
  	end
  	return ceknotif
	end

	def notifExist
		if current_user.admin?
  		ceknotif = Notification.all.count()
  	else
  		ceknotif = Notification.where(recipient_id: current_user.outlet_id).count()
  	end
		if ceknotif > 0
			return true
		else
			return false
		end
	end

end