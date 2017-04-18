class Indication < ApplicationRecord
	self.primary_key = "indication_id"
	has_many :obats
end