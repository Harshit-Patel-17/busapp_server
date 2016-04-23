json.bus do |json|
  json.extract! @bus, :id, :bus_num, :registration_num, :status, :latitude, :longitude, :capacity, :seat_avail, :ac_nonac, :created_at, :updated_at, :bus_stop_id
  json.route @route
  json.conductor @conductor
end
