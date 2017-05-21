class VenuesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_requisites

  include SearchHelper

  def index
  	@venues = current_user.venues.order(:name)
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
  	@venues = current_user.venues
		@venues = multi_search_query(@venues, venue_params,
		  name: 'ILIKE',
		  address: 'ILIKE',
		  city: 'ILIKE',
		  state: 'ILIKE',
		  country: 'ILIKE',
		  zip: 'ILIKE',
		  phone: 'ILIKE',
		  description: 'ILIKE',
		  subtitle: 'ILIKE').order(:name)
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
