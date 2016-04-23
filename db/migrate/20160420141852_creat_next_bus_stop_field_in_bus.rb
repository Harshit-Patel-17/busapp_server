class CreatNextBusStopFieldInBus < ActiveRecord::Migration
  def change
    add_reference :buses, :bus_stop, index: true
    add_foreign_key :buses, :bus_stops
  end
end
