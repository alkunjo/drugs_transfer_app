class Obat < ApplicationRecord
	self.primary_key = "obat_id"
	has_many :stocks
	has_many :safety_stocks, through: :stocks
	has_many :outlets, through: :stocks
	belongs_to :bentuk
	belongs_to :kemasan
	belongs_to :indication
end
