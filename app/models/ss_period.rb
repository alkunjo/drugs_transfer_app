class SsPeriod < ApplicationRecord
	self.primary_key = "ss_period_id"
	has_many :safety_stocks
	has_many :stocks, through: :safety_stocks
	accepts_nested_attributes_for :safety_stocks, :allow_destroy => true

	def bulan
		bulan = ss_period_period.strftime("%B")
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

	def tahun
		return ss_period_period.strftime("%Y")
	end

	def period
		return "#{bulan} #{tahun}"
	end

	def week
		if ss_period_period.strftime('%U').to_i % 4 == 0
			return "4"
		else
			return "#{ss_period_period.strftime('%U').to_i % 4}"
		end
	end

	def week_period
		"Minggu ke-#{week} #{period}"
	end
end
