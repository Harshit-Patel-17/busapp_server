json.array!(@buses) do |bus|
  json.extract! bus, :id, :bus_num, :registration_num, :status, :latitude, :longitude, :capacity, :seat_avail, :ac_nonac
  json.url bus_url(bus, format: :json)
end
