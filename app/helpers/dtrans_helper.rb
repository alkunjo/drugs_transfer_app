module DtransHelper
	def obat(stok_id)
		stok = Stock.find_by(stock_id: stok_id)
		return stok.obat.obat_name
	end
end