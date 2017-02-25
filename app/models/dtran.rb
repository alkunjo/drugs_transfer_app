class Dtran < ApplicationRecord
	belongs_to :transaksi, optional: true
	accepts_nested_attributes_for :transaksi
end
