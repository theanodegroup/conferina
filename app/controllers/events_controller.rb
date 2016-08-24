class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:search_events]
  before_action :get_category_types, only: [:new, :edit]

  def index
    @events = current_user.events.order(:name)
  end

  def show
    @event = Event.find(params[:id])
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
    else
      render :edit
    end
  end

  def create
    @event = Event.new(event_params)
    
    if @event.save
      current_user.events << @event
      @event.social = Social.new

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
    @location_types = current_user.location_types
    @person_types = current_user.person_types
    @session_types = current_user.session_types
    @events = current_user.events

    if params[:event_id].blank?
      @event = current_user.events.first 
    else
      @event = Event.find(params[:event_id]);  
    end

    if not @event.nil? 
      @social = @event.social
      if (not params[:person_search].blank?) && (params[:person_search].eql? 'true')
        @persons = Person.where(params[:sql]).order(:name)
      else
        @persons = @event.persons.order(:name)
      end

      if (not params[:location_search].blank?) && (params[:location_search].eql? 'true')
        @locations = Location.where(params[:sql]).order(:name);
      else
        @locations = @event.locations.order(:name)
      end

      if (not params[:session_search].blank?) && (params[:session_search].eql? 'true')
        @sessions = Session.where(params[:sql]).order(:name);
      else
        @sessions = @event.sessions.order(:name)
      end
    end

    if params[:category].blank?
      @category = 'people'
    else
      @category = params[:category]
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
     
    redirect_to events_path 
  end

  def search_events
    @events = Event.where()
  end

  private
  
  def event_params
    params.require(:event).permit(:name, :description, :category_id, :avatar, :avatar_cache, :timezone, :start_date, :end_date, :coming_soon, :address, :extra_name, :extra_desc, :extra_date_first_name, :extra_date_second_name, :extra_date_first, :extra_date_second, :lat, :lng)
  end

  def get_category_types
    @category_types = CategoryType.where(by_admin: true)
  end
end
