class Bus < ActiveRecord::Base
  has_many :reaches
  has_many :bus_stops, through: :reaches

  def self.addNewBus(params)
    bus_params = params["bus"].except("route").symbolize_keys
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
    bus_params = params["bus"].except("route").symbolize_keys
    route_params = params["bus"]["route"]
    if(!bus.update(bus_params))
      return bus, false
    end
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
