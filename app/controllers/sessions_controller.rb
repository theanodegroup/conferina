class SessionsController < ApplicationController
  before_action :authenticate_user!, :except => :show
  before_action :get_requisites, :except => :show

  include SearchHelper

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

  def show
    @session = Session.find(params[:id])
    gon.session = @session
    gon.location = @session.location
    gon.event_id = @session.event_id
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

      @session.tags.clear
      params[:session][:tags].each do |tag_id|
        if not tag_id.eql? ''
          tag = Tag.visible.find(tag_id)
          @session.tags << tag
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
        if person_id.present?
          person = Person.find(person_id)
          @session.persons << person
        end
      end

      params[:session][:tags].each do |tag_id|
        if tag_id.present?
          tag = Tag.visible.find(tag_id)
          @session.tags << tag
        end
      end

      redirect_to event_data_path(event_id: @session[:event_id], category: 'sessions')
      # render "events/event_data"
    else
      render :new
    end
  end

  def session_publish
    @session = Session.find(params[:id])
    if @session.update(is_published: !@session.is_published)
      redirect_to event_data_path(event_id: @session[:event_id], category: 'sessions')
    end
  end

  def search
    @favorite_style = Favorite::STYLE_STAR
    @event = Event.find(params[:session][:event_id])
		@sessions = @event.sessions
		@sessions = multi_search_query(@sessions, session_params,
		  name: 'ILIKE',
		  start_time: 'ILIKE',
		  end_time: 'ILIKE',
		  description: 'ILIKE',
		  other_time: 'ILIKE')
		if params[:session][:tags].present?
  		@sessions = @sessions.includes(:tags).where(tags: {id: params[:session][:tags].map(&:to_i) })
		end
		@sessions = @sessions.order(:start_time)
		render 'events/event_data/sessions/search'
  end

  def destroy
    @session = Session.find(params[:id])
    @event = @session.event
    # @session.persons.clear
    @session.destroy

    redirect_to event_data_path(event_id: @event[:id], category: 'sessions')
    # render "events/event_data"
  end

  private

  def session_params
    temp_params = params.require(:session).permit(:name, :description, :location_id,
                                                  :start_time, :end_time, :avatar, :avatar_cache,
                                                  :detailed_avatar, :detailed_avatar_cache,
                                                  :other_time, :event_id, :session_type_id,
                                                  :tags, :persons)
    return temp_params unless temp_params[:tags]
    tags = temp_params[:tags].select(&:present?)
    temp_params[:tags] = Tag.find_by(id: tags)
    puts temp_params.inspect
    temp_params
  end

  def get_requisites
    @session_types = current_user.session_types
    @events = current_user.events
    @tags = Tag.visible.all.order(:name)
  end
end
