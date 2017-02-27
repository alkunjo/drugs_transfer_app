class Dtran < ApplicationRecord
  belongs_to :transaksi, optional: true
  belongs_to :stock

  attr_accessor :obat_name

  def enough?
  	trans = Transaksi.where(transaksi_id: self.transaksi_id).first
  	stok = Stock.where(obat_id: self.obat_id, outlet_id: trans.receiver_id).first
  	obat = Obat.where(obat_id: self.obat_id).first
  	if (stok.stok_qty - self.dta_qty) < obat.obat_minStock
  		return false
  	else
  		return true
  	end
  end

  def stok
  	trans = Transaksi.where(transaksi_id: self.transaksi_id).first
  	stok = Stock.where(obat_id: self.obat_id, outlet_id: trans.receiver_id).first
  	return stok.stok_qty
  end

  def enoughs?
  end
end
