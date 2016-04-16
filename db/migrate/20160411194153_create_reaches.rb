class CreateReaches < ActiveRecord::Migration
  def change
    create_table :reaches do |t|
      t.references :bus, index: true
      t.references :bus_stop, index: true
      t.integer :stop_num
      t.timestamps null: false
    end
    add_foreign_key :reaches, :buses
    add_foreign_key :reaches, :bus_stops
  end
end
