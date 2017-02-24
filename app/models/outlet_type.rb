class OutletType < ApplicationRecord
	self.primary_key = "otype_id"	
	has_many :outlets

	# validates_presence_of :otype_name, message: "Tipe outlet harus diisi"
	# validates_uniqueness_of :otype_name, message: "Tipe outlet harus unik"
end
