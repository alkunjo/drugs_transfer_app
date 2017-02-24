class Outlet < ApplicationRecord
  self.primary_key = "outlet_id"
  belongs_to :outlet_type
  has_many :users
  has_many :distances
  
 #  validates_presence_of :outlet_name, :outlet_address, :outlet_phone, :outlet_city, :outlet_email, :outlet_fax, :otype_id, message: "Semua field harus diisi!"
	# validates_uniqueness_of :outlet_name, message: "Nama outlet harus unik!"
end
