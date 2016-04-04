json.lat_lng do |json|
  json.extract! @location, :street_address, :city, :state, :zip, :lat, :lng, :country_code, :success
end

