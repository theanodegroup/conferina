class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_requisites

  def index
  end

  def new
    @event = Event.find(params[:id])
    @location = Location.new
  end

  def edit
    @location = Location.find(params[:id])
    @event = Event.find_by_id(@location[:event_id])
  end

  def update
    @location = Location.find(params[:id])
 
    if @location.update(location_params)
      redirect_to event_data_path(event_id: @location[:event_id], category: 'locations')
    else
      render :new
    end
  end

  def create
    @location = Location.new(location_params)
 
    if @location.save
      redirect_to event_data_path(event_id: @location[:event_id], category: 'locations')
      # render "events/event_data"
    else
      render :new
    end
  end

  def search
    sql = ''
    if not params[:location][:name].eql? ''
      sql = sql + "name ILIKE '%" + params[:location][:name] + "%' OR "
    end

    if not params[:location][:address].eql? ''
      sql = sql + "address ILIKE '%" + params[:location][:address] + "%' OR "
    end

    if not params[:location][:address].eql? ''
      sql = sql + "map_address ILIKE '%" + params[:location][:address] + "%' OR "
    end    

    if not params[:location][:city].eql? ''
      sql = sql + "city ILIKE '%" + params[:location][:city] + "%' OR "
    end

    if not params[:location][:city].eql? ''
      sql = sql + "map_address ILIKE '%" + params[:location][:city] + "%' OR "
    end

    if not params[:location][:state].eql? ''
      sql = sql + "state ILIKE '%" + params[:location][:state] + "%' OR "
    end

    if not params[:location][:state].eql? ''
      sql = sql + "map_address ILIKE '%" + params[:location][:state] + "%' OR "
    end

    if not params[:location][:country].eql? ''
      sql = sql + "country ILIKE '%" + params[:location][:country] + "%' OR "
    end

    if not params[:location][:country].eql? ''
      sql = sql + "map_address ILIKE '%" + params[:location][:country] + "%' OR "
    end

    if not params[:location][:zip].eql? ''
      sql = sql + "zip ILIKE '%" + params[:location][:zip] + "%' OR "
    end

    if not params[:location][:phone].eql? ''
      sql = sql + "phone ILIKE '%" + params[:location][:phone] + "%' OR "
    end

    if not params[:location][:description].eql? ''
      sql = sql + "description ILIKE '%" + params[:location][:description] + "%' OR "
    end

    if not params[:location][:subtitle].eql? ''
      sql = sql + "subtitle ILIKE '%" + params[:location][:subtitle] + "%' OR "
    end

    if sql.eql? ''
      sql = 'TRUE'
    else
      sql = sql + 'FALSE'
    end  
    redirect_to event_data_path(event_id: params[:location][:event_id], category: 'locations', location_search: 'true', sql: sql) 
  end

  def destroy
    @location = Location.find(params[:id])
    @event = @location.event
    @location.destroy
    
    redirect_to event_data_path(event_id: @event[:id], category: 'locations')
    # render "events/event_data" 
  end

  private
  
  def location_params
    params.require(:location).permit(:name, :address, :city, :state, :country, :zip, :map_address, :avatar, :avatar_cache, :detailed_avatar, :detailed_avatar_cache, :phone, :description, :subtitle, :lat, :lng, :event_id, :location_type_id)
  end

  def get_requisites
    @location_types = current_user.location_types
    @events = current_user.events
  end
end
