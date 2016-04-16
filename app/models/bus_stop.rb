class BusStop < ActiveRecord::Base
  has_many :reaches
  has_many :buses, through: :reaches

  acts_as_mappable :default_units => :kms,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  require 'json'

  def self.get_city_district_hash
     data = File.read('public/state_district.json')
     JSON.parse(data).symbolize_keys 
  end

  def self.get_lat_lng_from_address address
    include Geokit::Geocoders
    location = MultiGeocoder.geocode(address)
    location.hash
  end
end
