class Role < ApplicationRecord
	self.primary_key = "role_id"	
	has_many :users

	validates_presence_of :role_name, :role_desc, message: "Semua field harus diisi"
	validates_uniqueness_of :role_name, message: "Nama role harus unik"
end
