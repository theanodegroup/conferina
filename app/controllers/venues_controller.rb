class VenuesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_requisites

  def index
  	if params[:sql].present?
    	@venues = current_user.venues.where(params[:sql]).order(:name)
  	else
    	@venues = current_user.venues.order(:name)
  	end
  end

  def new
    @venue = Venue.new
  end

  def edit
    @venue = Venue.find(params[:id])
  end

  def update
    @venue = Venue.find(params[:id])
 
    if @venue.update(venue_params)
      redirect_to venues_path
    else
      render :new
    end
  end

  def create
    @venue = current_user.venues.create(venue_params)
 
    if @venue.present?
      redirect_to venues_path
    else
      render :new
    end
  end

  def search
    sql = ''
    if not params[:venue][:name].eql? ''
      sql = sql + "name ILIKE '%" + params[:venue][:name] + "%' OR "
    end

    if not params[:venue][:address].eql? ''
      sql = sql + "address ILIKE '%" + params[:venue][:address] + "%' OR "
    end   

    if not params[:venue][:city].eql? ''
      sql = sql + "city ILIKE '%" + params[:venue][:city] + "%' OR "
    end

    if not params[:venue][:state].eql? ''
      sql = sql + "state ILIKE '%" + params[:venue][:state] + "%' OR "
    end

    if not params[:venue][:country].eql? ''
      sql = sql + "country ILIKE '%" + params[:venue][:country] + "%' OR "
    end

    if not params[:venue][:zip].eql? ''
      sql = sql + "zip ILIKE '%" + params[:venue][:zip] + "%' OR "
    end

    if not params[:venue][:phone].eql? ''
      sql = sql + "phone ILIKE '%" + params[:venue][:phone] + "%' OR "
    end

    if not params[:venue][:description].eql? ''
      sql = sql + "description ILIKE '%" + params[:venue][:description] + "%' OR "
    end

    if not params[:venue][:subtitle].eql? ''
      sql = sql + "subtitle ILIKE '%" + params[:venue][:subtitle] + "%' OR "
    end

    if sql.eql? ''
      sql = 'TRUE'
    else
      sql = sql + 'FALSE'
    end  
    redirect_to venues_path(sql: sql) 
  end

  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy
    
    redirect_to venues_path 
  end

  private
  
  def venue_params
    params.require(:venue).permit(:name, :address, :city, :state, :country, :zip, :map_address, :avatar, :avatar_cache, :detailed_avatar, :detailed_avatar_cache, :phone, :description, :subtitle, :lat, :lng, :location_type_id)
  end

  def get_requisites
    @location_types = current_user.location_types
  end
end
