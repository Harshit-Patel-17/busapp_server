class Bus < ActiveRecord::Base
  has_many :reaches
  has_many :bus_stops, through: :reaches
end
