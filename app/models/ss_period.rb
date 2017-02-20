class SsPeriod < ApplicationRecord
	self.primary_key = "ss_period_id"
	has_many :safety_stocks
	attr_accessor :ss_month, :ss_year
end
