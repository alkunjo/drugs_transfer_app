class Stock < ApplicationRecord
	self.primary_key = "stock_id"
	belongs_to :obat, dependent: :destroy
	belongs_to :outlet
	# has_many :safety_stocks
	has_many :ss_periods, through: :safety_stocks
	has_many :dtrans
	has_many :transaksis, through: :dtrans
	# accepts_nested_attributes_for :safety_stocks, :allow_destroy => true
	attr_accessor :outlet_name, :obat_name
end
