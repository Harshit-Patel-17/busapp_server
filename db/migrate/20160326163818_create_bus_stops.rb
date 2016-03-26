class CreateBusStops < ActiveRecord::Migration
  def change
    create_table :bus_stops do |t|
      t.string :name
      t.string :street
      t.string :district
      t.string :state
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps null: false
    end
  end
end
