json.bus_stop do |json|
  json.extract! @bus_stop, :id, :name, :street, :district, :state, :latitude, :longitude, :created_at, :updated_at
end
