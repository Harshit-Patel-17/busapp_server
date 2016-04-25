class Bus < ActiveRecord::Base
  has_many :reaches, :dependent => :delete_all
  has_many :bus_stops, through: :reaches
  belongs_to :user

  validates :bus_num, uniqueness: true
  validates :registration_num, uniqueness: true
  validates :user_id, uniqueness: true  

  def self.addNewBus(params)
    bus_params = params["bus"].except("route", "conductor").symbolize_keys
    bus_params[:user_id] = params["bus"]["conductor"]["id"]
    route_params = params["bus"]["route"]
    bus = Bus.new(bus_params)
    if(!bus.save)
      return bus, false
    end
    if(!updateRoute(bus, route_params))
      bus.delete
      return bus, false
    end
    return bus, true
  end

  def self.updateBus(bus, params)
    bus_params = params["bus"].except("route", "conductor").symbolize_keys
    bus_params[:user_id] = params["bus"]["conductor"]["id"] if params["bus"].has_key? "conductor"
    if(!bus.update(bus_params))
      return bus, false
    end
    if(!params["bus"].has_key? "route")
      return bus, true
    end
    route_params = params["bus"]["route"] if params["bus"].has_key? "route"
    bus.reaches.delete_all
    if(!updateRoute(bus, route_params))
      bus.delete
      return bus, false
    end
    return bus, true
  end

  private
    def self.updateRoute(bus, route_params)
      route_params.each do |bus_stop|
        reach = Reach.new({"bus_id" => bus.id, "bus_stop_id" => bus_stop["id"], "stop_num" => bus_stop["stop_num"]})
        if(!reach.save)
          bus.reaches.delete_all
          return false
        end
      end
      return true 
    end
end
