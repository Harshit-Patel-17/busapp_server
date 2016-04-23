class BusesController < ApplicationController
  before_action :set_bus, only: [:show, :latlng, :edit, :update, :destroy]

  acts_as_token_authentication_handler_for User, :only => [:new, :edit, :create, :update, :destroy]

  # GET /buses
  # GET /buses.json
  def index
    @buses = Bus.all.compact
    if params.has_key? :src and params.has_key? :dst
      src_id = params[:src].to_i
      dst_id = params[:dst].to_i
      buses_to_delete = []
      @buses.each do |bus|
        bus_stop_ids = bus.reaches.pluck(:bus_stop_id)
        buses_to_delete.push(bus) if !(bus_stop_ids.include? src_id and bus_stop_ids.include? dst_id)
      end
      buses_to_delete.each do |bus|
        @buses.delete(bus)
      end
    end
  end

  # GET /buses/1
  # GET /buses/1.json
  def show
  end

  #GET /buses/1/latlng.json
  def latlng
  end

  # GET /buses/user_id/1.json
  def show_by_user_id
    begin
      set_bus_by_user_id
    rescue
      render json: { error: "Bus not found" }
    end
  end

  # GET /buses/new
  def new
    @bus = Bus.new
  end

  # GET /buses/1/edit
  def edit
  end

  # POST /buses
  # POST /buses.json
  def create
    @bus, status = Bus.addNewBus(params)

    respond_to do |format|
      if status == true
        format.html { redirect_to @bus, notice: 'Bus was successfully created.' }
        format.json { render :show, status: :created, location: @bus }
      else
        format.html { render :new }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buses/1
  # PATCH/PUT /buses/1.json
  def update
    @bus, status = Bus.updateBus(@bus, params)
    respond_to do |format|
      if status == true
        format.html { redirect_to @bus, notice: 'Bus was successfully updated.' }
        format.json { render :show, status: :ok, location: @bus }
      else
        format.html { render :edit }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buses/1
  # DELETE /buses/1.json
  def destroy
    @bus.destroy
    respond_to do |format|
      format.html { redirect_to buses_url, notice: 'Bus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bus
      @bus = Bus.find(params[:id])
      @route = @bus.reaches.collect{|reach| reach.bus_stop.attributes.merge(reach.attributes.extract!("stop_num"))}
      @conductor = @bus.user.attributes.extract!("id", "first_name", "last_name")
    end

    def set_bus_by_user_id
      @bus = Bus.find_by_user_id(params[:user_id])
      @route = @bus.reaches.collect{|reach| reach.bus_stop.attributes.merge(reach.attributes.extract!("stop_num"))}
      @conductor = @bus.user.attributes.extract!("id", "first_name", "last_name")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bus_params
      params.require(:bus).permit(:bus_num, :registration_num, :status, :latitude, :longitude, :capacity, :seat_avail, :ac_nonac, :user_id, :bus_stop_id)
    end
end
