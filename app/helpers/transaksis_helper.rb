module TransaksisHelper
	def to_rupiah(fill)
		number_to_currency( fill, unit: "Rp. ", separator: ',', delimeter: '.' )
	end

	def total_minta(cek)
		total = 0
		cek.dtrans.each do |dtran|
			hargaObat = Obat.find(dtran.obat_id).obat_hpp * dtran.dta_qty
			total = total + hargaObat
		end
		return total
	end

	def total_dropping(cek)
		total = 0
		cek.dtrans.each do |dtran|
			hargaObat = Obat.find(dtran.obat_id).obat_hpp * dtran.dtd_qty
			total = total + hargaObat
		end
		return total
	end

	def total_terima(cek)
		total = 0
		cek.dtrans.each do |dtran|
			hargaObat = Obat.find(dtran.obat_id).obat_hpp * dtran.dtt_qty
			total = total + hargaObat
		end
		return total
	end

	def apotek(cek)
		apotek = Outlet.find(cek.receiver_id).outlet_name
		return apotek
	end

	def bulan(bulan)
		if bulan == 'January'
			return 'Januari'
		elsif bulan == 'February'
			return 'Februari'
		elsif bulan == 'March'
			return 'Maret'
		elsif bulan == 'April'
			return 'April'
		elsif bulan == 'May'
			return 'Mei'
		elsif bulan == 'June'
			return 'Juni'
		elsif bulan == 'July'
			return 'Juli'
		elsif bulan == 'August'
			return 'Agustus'
		elsif bulan == 'September'
			return 'September'
		elsif bulan == 'October'
			return 'Oktober'
		elsif bulan == 'November'
			return 'November'
		else
			return 'December'
		end
	end
end
