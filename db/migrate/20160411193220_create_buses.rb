class CreateBuses < ActiveRecord::Migration
  def change
    create_table :buses do |t|
      t.string :bus_num
      t.string :registration_num
      t.string :status
      t.integer :latitude
      t.integer :longitude
      t.integer :capacity
      t.integer :seat_avail  #Has three values 0, 1, 2 to indicate that there are seats available, seats not available and no place to stand in bus
      t.string :ac_nonac

      t.timestamps null: false
    end
  end
end
