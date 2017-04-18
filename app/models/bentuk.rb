class Bentuk < ApplicationRecord
	self.primary_key = "bentuk_id"
	has_many :obats
end