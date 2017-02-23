module SafetyStocksHelper
	def bulan(date)
		bulan = date.strftime("%B")
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
			return 'Desember'
		end
	end

	def tahun(date)
		return date.strftime("%Y")
	end

	def period(date)
		return "#{bulan(date)} #{tahun(date)}"
	end

	def week(date)
		if date.strftime('%U').to_i % 4 == 0
			return "4"
		else
			return "#{date.strftime('%U').to_i % 4}"
		end
	end
end
