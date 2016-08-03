class SessionsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_requisites

  def index
  end

  def new
    @event = Event.find(params[:id])
    @session = Session.new
  end

  def edit
    @session = Session.find(params[:id])
    @event = Event.find_by_id(@session[:event_id])
  end

  def update
    @session = Session.find(params[:id])

    if @session.update(session_params)
      @session.persons.clear
      params[:session][:persons].each do |person_id|
        if not person_id.eql? ''
          person = Person.find(person_id)
          @session.persons << person
        end
      end

      redirect_to event_data_path(event_id: @session[:event_id], category: 'sessions')
    else
      render :new
    end
  end

  def create
    @session = Session.new(session_params)
    
    if @session.save
      params[:session][:persons].each do |person_id|
        if not person_id.eql? ''
          person = Person.find(person_id)
          @session.persons << person
        end
      end

      redirect_to event_data_path(event_id: @session[:event_id], category: 'sessions')
      # render "events/event_data"
    else
      render :new
    end
  end

  def destroy
    @session = Session.find(params[:id])
    @event = @session.event
    @session.persons.clear
    @session.destroy
    
    redirect_to event_data_path(event_id: @event[:id], category: 'sessions')
    # render "events/event_data" 
  end

  private
  
  def session_params
    params.require(:session).permit(:name, :description, :persons, :location_id, :start_time, :end_time, :avatar, :avatar_cache, :detailed_avatar, :detailed_avatar_cache, :tags, :other_time, :event_id, :session_type_id)
  end

  def get_requisites
    @session_types = current_user.session_types
    @events = current_user.events
  end
end
