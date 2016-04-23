json.buses do |json|
  json.array!(@buses) do |bus|
    json.extract! bus, :id, :bus_num, :registration_num, :status, :latitude, :longitude, :capacity, :seat_avail, :ac_nonac, :bus_stop_id
    json.url bus_url(bus, format: :json)
  end
end
