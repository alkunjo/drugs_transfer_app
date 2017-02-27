class Distance < ApplicationRecord
	self.primary_key = ["origin_id", "destination_id"]
	belongs_to :origin, foreign_key: "origin_id", class_name: "Outlet"
	belongs_to :destination, foreign_key: "destination_id", class_name: "Outlet"
	attr_accessor :outlet_name
end
