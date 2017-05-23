class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_requisites

  include SearchHelper

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
    @favorite_style = Favorite::STYLE_STAR
    @event = Event.find(params[:location][:event_id])
		@locations = @event.locations
		@locations = multi_search_query(@locations, location_params,
		  name: 'ILIKE',
		  address: 'ILIKE',
		  city: 'ILIKE',
		  state: 'ILIKE',
		  country: 'ILIKE',
		  zip: 'ILIKE',
		  phone: 'ILIKE',
		  description: 'ILIKE').order(:name)
		render 'events/event_data/locations/search'
  end

  def destroy
    @location = Location.find(params[:id])
    @event = @location.event
    @location.sessions.each do |session|
      session.location_id = nil
      session.save
    end
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
