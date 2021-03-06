class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:search_events, :show]
  before_action :get_category_types, only: [:index, :new, :edit, :search_events]

  include SearchHelper

  def index
    @events = current_user.events.order(:name)
  end

  def show
    @event = Event.find(params[:id])
    if !@event.is_published?
      if current_user.nil?
        flash[:error] = "This event is not published yet."
        redirect_to root_path and return
      else
        authenticate_user!

        if current_user != @event.users.first
          redirect_to root_path and return
        end
      end
    end
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to events_path

      @event.tags.clear
      params[:event][:tags].each do |tag_id|
        if not tag_id.eql? ''
          tag = Tag.visible.find(tag_id)
          @event.tags << tag
        end
      end
    else
      render :edit
    end
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      current_user.events << @event
      @event.social = Social.new

      params[:event][:tags].each do |tag_id|
        if not tag_id.eql? ''
          tag = Tag.visible.find(tag_id)
          @event.tags << tag
        end
      end

      venues = current_user.venues
      venues.each do |v|
        @loc = @event.locations.create(name: v.name, address: v.address, city: v.city, state: v.state, country: v.country, zip: v.zip, map_address: v.map_address, avatar: v.avatar, detailed_avatar: v.detailed_avatar, phone: v.phone, description: v.description, subtitle: v.subtitle, lat: v.lat, lng: v.lng, location_type_id: v.location_type_id)
        v.locations << @loc
      end

      redirect_to events_path
    else
      render :new
    end

  end

  def publishable
    @event = Event.find(params[:id])
    if @event.update(is_published: !@event.is_published)
      redirect_to events_path
    end
  end

  def event_data
    @favorite_style = Favorite::STYLE_STAR
    @location_types = current_user.location_types
    @person_types = current_user.person_types
    @session_types = current_user.session_types
    @events = current_user.events

    if params[:event_id].blank? || (params[:event_id].eql? 'undefined')
      @event = current_user.events.first
    else
      @event = Event.find(params[:event_id]);
    end

    if not @event.nil?
      @social = @event.social
      @persons = @event.persons.order(:name)
      @locations = @event.locations.order(:name)
      @sessions = @event.sessions.order(:start_time)
    end

    if params[:category].blank?
      @category = 'people'
    else
      @category = params[:category]
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.tags.clear
    @event.destroy

    redirect_to events_path
  end

  def search_events
		@events = current_user.events
		@events = multi_search_query(@events, event_params,
		  name: 'ILIKE',
		  category_id: '=',
		  start_date: '=',
		  end_date: '=',
		  address: 'ILIKE').order(:name)
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :category_id, :avatar, :avatar_cache,
                                  :timezone, :start_date, :end_date, :coming_soon, :address,
                                  :call_for, :extra_desc, :submission, :notification, :lat, :lng,
                                  :tags => [])
  end

  def get_category_types
    @category_types = CategoryType.where(by_admin: true)
    @tags = Tag.visible.all.order(:name)
  end
end
