class Stock < ApplicationRecord
	self.primary_key = "stock_id"
	belongs_to :obat, dependent: :destroy
	belongs_to :outlet
	attr_accessor :outlet_name, :obat_name
end
