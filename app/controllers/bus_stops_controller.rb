class BusStopsController < ApplicationController
  before_action :set_bus_stop, only: [:show, :edit, :update, :destroy]

  acts_as_token_authentication_handler_for User, :only => [:new, :edit, :create, :update, :destroy]

  require 'json'

  # GET /bus_stops
  # GET /bus_stops.json
  def index
    @bus_stops = BusStop.all
    if params.has_key? :state
      @bus_stops = @bus_stops.where(:state => params[:state]).order(:district)
    end
  end

  # GET /bus_stops/closest
  def closest
    @bus_stop = BusStop.closest(:origin => [params[:lat], params[:lng]])[0]
  end

  # GET /bus_stops/1
  # GET /bus_stops/1.json
  def show
  end

  # GET /bus_stops/new
  def new
    @bus_stop = BusStop.new
  end

  # GET /bus_stops/1/edit
  def edit
  end

  # POST /bus_stops
  # POST /bus_stops.json
  def create
    @bus_stop = BusStop.new(bus_stop_params)

    respond_to do |format|
      if @bus_stop.save
        format.html { redirect_to @bus_stop, notice: 'Bus stop was successfully created.' }
        format.json { render :show, status: :created, location: @bus_stop }
      else
        format.html { render :new }
        format.json { render json: @bus_stop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bus_stops/1
  # PATCH/PUT /bus_stops/1.json
  def update
    respond_to do |format|
      if @bus_stop.update(bus_stop_params)
        format.html { redirect_to @bus_stop, notice: 'Bus stop was successfully updated.' }
        format.json { render :show, status: :ok, location: @bus_stop }
      else
        format.html { render :edit }
        format.json { render json: @bus_stop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bus_stops/1
  # DELETE /bus_stops/1.json
  def destroy
    @bus_stop.destroy
    respond_to do |format|
      format.html { redirect_to bus_stops_url, notice: 'Bus stop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /bus_stops/state_district_data.json
  def state_district_data
    @state_district_hash = BusStop.get_city_district_hash
  end

  # POST /bus_stops/lat_long.json
  def lat_lng
    @location = BusStop.get_lat_lng_from_address params[:address]
    puts @location
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bus_stop
      @bus_stop = BusStop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bus_stop_params
      params.require(:bus_stop).permit(:name, :street, :district, :state, :latitude, :longitude)
    end
end
