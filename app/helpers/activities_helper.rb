module ActivitiesHelper
	
	def call_activity(activity)
		if activity.key == 'transaksi.create'
			msg = buat(activity)
		elsif activity.key == 'transaksi.validate_ask'
			msg = minta(activity)
		elsif activity.key == 'transaksi.validate_drop'
			msg = drop(activity)
		elsif activity.key == 'transaksi.validate_accept'
			msg = terima(activity)
		else
			msg = ubah(activity)
		end		
		return msg
	end

	def buat(activity)
		sender = User.find(activity.owner).user_name
		osender = Outlet.find(activity.trackable.sender_id).outlet_name
		oreceiver = Outlet.find(activity.trackable.receiver_id).outlet_name
		return sender+' dari Apotek '+osender+' telah membuat permintaan obat ke Apotek '+ oreceiver
	end

	def minta(activity)
		sender = User.find(activity.owner).user_name
		osender = Outlet.find(activity.trackable.sender_id).outlet_name
		oreceiver = Outlet.find(activity.trackable.receiver_id).outlet_name
		return sender+' dari Apotek '+osender+' telah memvalidasi permintaan obat ke Apotek '+ oreceiver
	end

	def drop(activity)
		sender = User.find(activity.owner).user_name
		osender = Outlet.find(activity.trackable.receiver_id).outlet_name
		oreceiver = Outlet.find(activity.trackable.sender_id).outlet_name
		return sender+' dari Apotek '+osender+' telah memvalidasi dropping obat dari Apotek '+ oreceiver
	end

	def terima(activity)
		sender = User.find(activity.owner).user_name
		osender = Outlet.find(activity.trackable.sender_id).outlet_name
		oreceiver = Outlet.find(activity.trackable.receiver_id).outlet_name
		return sender+' dari Apotek '+osender+' telah menerima dropping obat dari Apotek '+ oreceiver
	end

	def ubah(activity)
		sender = User.find(activity.owner).user_name
		osender = Outlet.find(activity.trackable.sender_id).outlet_name
		oreceiver = Outlet.find(activity.trackable.receiver_id).outlet_name
		return sender+' dari Apotek '+osender+' telah merubah permintaan obat ke Apotek '+ oreceiver
	end

	def sender_name(activity)
  	sender = User.find(activity.owner).user_name
  	osender = Outlet.find(activity.trackable.sender_id).outlet_name
  	return sender+" dari Apotek "+osender
  end

  def acceptor_name(activity)
  	acc = Outlet.find(activity.trackable.receiver_id).outlet_name
  	return acc
  end
end
