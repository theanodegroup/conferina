class PersonsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_requisites

  def index
  end

  def new
    @event = Event.find(params[:id])
    @person = Person.new
  end

  def edit
    @person = Person.find(params[:id])
    @event = Event.find_by_id(@person[:event_id])
  end

  def update
    @person = Person.find(params[:id])
    # @event = Event.find_by_id(@person[:event_id])
 
    if @person.update(person_params)
      redirect_to event_data_path(event_id: @person[:event_id], category: 'people')
    else
      render :new
    end
  end

  def create
    @person = Person.new(person_params)
    # @event = Event.find_by_id(@person[:event_id])
 
    if @person.save
      redirect_to event_data_path(event_id: @person[:event_id], category: 'people')
      # render "events/event_data"
    else
      render :new
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @event = @person.event
    @person.destroy
    
    redirect_to event_data_path(event_id: @event[:id], category: 'people')
    # render "events/event_data" 
  end

  private
  
  def person_params
    params.require(:person).permit(:name, :description, :subtitle, :avatar, :avatar_cache, :detailed_avatar, :website, :youtube, :facebook, :twitter, :email, :phone, :tags, :event_id, :person_type_id)
  end

  def get_requisites
    @person_types = current_user.person_types
    @events = current_user.events
  end
end
