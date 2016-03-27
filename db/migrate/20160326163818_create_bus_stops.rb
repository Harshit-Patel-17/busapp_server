class CreateBusStops < ActiveRecord::Migration
  def change
    create_table :bus_stops do |t|
      t.string :name
      t.string :street
      t.string :district
      t.string :state
      t.decimal :latitude, :precision => 13, :scale => 10
      t.decimal :longitude, :precision => 13, :scale => 10

      t.timestamps null: false
    end
  end
end
