module DistancesHelper
	def origin(id)
		origin = Outlet.where(outlet_id: id).first
		return origin.outlet_name
	end

	def destination(id)
		destination = Outlet.where(outlet_id: id).first
		return destination.outlet_name
	end
end