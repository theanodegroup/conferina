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

  def search
    sql = ''
    if not params[:person][:name].eql? ''
      sql = sql + "name ILIKE '%" + params[:person][:name] + "%' OR "
    end

    if not params[:person][:subtitle].eql? ''
      sql = sql + "subtitle ILIKE '%" + params[:person][:subtitle] + "%' OR "
    end

    if not params[:person][:description].eql? ''
      sql = sql + "description ILIKE '%" + params[:person][:description] + "%' OR "
    end

    if not params[:person][:website].eql? ''
      sql = sql + "website ILIKE '%" + params[:person][:website] + "%' OR "
    end

    if not params[:person][:youtube].eql? ''
      sql = sql + "youtube ILIKE '%" + params[:person][:youtube] + "%' OR "
    end

    if not params[:person][:facebook].eql? ''
      sql = sql + "facebook ILIKE '%" + params[:person][:facebook] + "%' OR "
    end

    if not params[:person][:twitter].eql? ''
      sql = sql + "twitter ILIKE '%" + params[:person][:twitter] + "%' OR "
    end

    if not params[:person][:phone].eql? ''
      sql = sql + "phone ILIKE '%" + params[:person][:phone] + "%' OR "
    end

    if not params[:person][:email].eql? ''
      sql = sql + "email ILIKE '%" + params[:person][:email] + "%' OR "
    end

    if not params[:person][:tags].eql? ''
      sql = sql + "tags ILIKE '%" + params[:person][:tags] + "%' OR "
    end

    if sql.eql? ''
      sql = 'TRUE'
    else
      sql = sql + 'FALSE'
    end  

    redirect_to event_data_path(event_id: params[:person][:event_id], category: 'people', person_search: 'true', sql: sql) 
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
    params.require(:person).permit(:name, :description, :subtitle, :avatar, :avatar_cache, :detailed_avatar, :detailed_avatar_cache, :website, :youtube, :facebook, :twitter, :email, :phone, :tags, :event_id, :person_type_id)
  end

  def get_requisites
    @person_types = current_user.person_types
    @events = current_user.events
  end
end
