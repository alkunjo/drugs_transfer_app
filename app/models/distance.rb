class Distance < ApplicationRecord
	self.primary_key = ["origin_id", "destination_id"]
	belongs_to :outlets, foreign_key: "origin_id"
	belongs_to :outlets, foreign_key: "destination_id"
	attr_accessor :outlet_name
end
