json.bus do |json|
  json.extract! @bus, :id, :bus_num, :registration_num, :status, :latitude, :longitude, :capacity, :seat_avail, :ac_nonac, :created_at, :updated_at
  json.route @route
  json.conductor @conductor
end
