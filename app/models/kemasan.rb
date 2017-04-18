class Kemasan < ApplicationRecord
	self.primary_key = "kemasan_id"
	has_many :obats
end