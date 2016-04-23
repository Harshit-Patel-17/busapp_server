json.bus do |json|
  json.extract! @bus, :id, :latitude, :longitude
end

