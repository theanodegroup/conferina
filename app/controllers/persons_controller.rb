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
    # @same_person = Event.find_by_id(@person[:event_id]).persons.where(email: params[:person][:email])

    # if @same_person.count != 0
    #   flash[:error] = "You can't update this person since " + params[:person][:email] + " has already been invited in this event!"
    #   redirect_to new_person_path(id: @person[:event_id])
    # else

      if @person.update(person_params)
        invitee = User.find_by(invited_by_id: current_user.id, email: @person[:email])
        # if not invitee.nil?
        #   invitee.people << @person
        # else
        #   User.invite!({:email => params[:person][:email], :role => 0}, current_user)
        #   User.find_by(invited_by_id: current_user.id, email: @person[:email]).people << @person
        # end

        redirect_to event_data_path(event_id: @person[:event_id], category: 'people')
      else
        redirect_to edit_person_path(id: @person[:id])
      end
    # end
  end

  def create
    @person = Person.new(person_params)
    # @event = Event.find_by_id(@person[:event_id])
    @same_person = Event.find_by_id(@person[:event_id]).persons.where(email: @person[:email])

    if @same_person.count != 0
      flash[:error] = "You can't invite this person again since " + @person[:email] + " has already been invited in this event!"
      redirect_to new_person_path(id: @person[:event_id])
    else
      if @person.save
        account_sid = ENV['TWILIO_LIVE_SID']
        auth_token = ENV['TWILIO_LIVE_AUTH_TOKEN']

        @client = Twilio::REST::Client.new(account_sid, auth_token) 


        invitee = User.find_by(invited_by_id: current_user.id, email: @person[:email])
        if not invitee.nil?
          invitee.people << @person

          puts '---- Twilio Start -----'
          result = @client.account.messages.create(
            :messaging_service_sid => ENV['MESSAGING_SERVICE_SID'],
            :to => '+8615698864471',
            :body => 'You are invited to another event.'
            )
          puts result
        else
          User.invite!({:email => params[:person][:email], :role => 0}, current_user)
          User.find_by(invited_by_id: current_user.id, email: @person[:email]).people << @person
          flash[:success] = "Invitation has sent to " + @person[:email]

          puts '---- Twilio Start -----'
          @client.account.messages.create({
            :messaging_service_sid => ENV['MESSAGING_SERVICE_SID'],
            :to => '+8615698864471',
            :body => 'You are invited to an event event.'
            })
        end
        redirect_to event_data_path(event_id: @person[:event_id], category: 'people')
        # render "events/event_data"
      else
        redirect_to new_person_path(id: @person[:event_id])
      end
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
    @user = @person.user
    @person.destroy
    
    if @user.people.count == 0
      @user.destroy
    end

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

# http://andrewfomera.com/posts/twilio-two-way-messaging
