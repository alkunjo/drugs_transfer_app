module ObatsHelper
	def to_rupiah(fill)
		number_to_currency( fill, unit: "Rp. ", separator: ',', delimeter: '.' )
	end
end
