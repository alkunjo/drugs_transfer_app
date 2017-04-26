class Dtran < ApplicationRecord
  belongs_to :transaksi, optional: true
  belongs_to :stock

  attr_accessor :obat_name

  def enough?
  	obat_id = self.stock.obat.obat_id
    stok = Stock.find_by(obat_id: self.stock.obat.obat_id, outlet_id: self.transaksi.receiver_id)
    if (stok.stok_qty - self.dta_qty) < stok.current_ss
      return false
    else
      return true
    end
  end

  def stok
    stok = Stock.find_by(obat_id: self.stock.obat.obat_id, outlet_id: self.transaksi.receiver_id)
  	return stok.stok_qty
  end
end
