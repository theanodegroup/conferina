class PersonsController < ApplicationController
  def index
  end

  def new
    @event = Event.find(params[:id])
    @person_types = current_user.person_types
    @person = Person.new
  end

  def edit
  end

  def update
  end

  def create
  end

  def destroy
  end
end
