class SsPeriod < ApplicationRecord
	self.primary_key = "ss_period_id"
	has_many :safety_stocks
end
