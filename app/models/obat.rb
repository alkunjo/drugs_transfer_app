class Obat < ApplicationRecord
	self.primary_key = "obat_id"
	has_many :stocks
end
