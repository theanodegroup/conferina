class SearchsController < ApplicationController
	before_action :fetch_tags

	def search
		if params[:tag_id].nil?
			@events = Event.where(is_published: true).order(:start_date)
			@tag_id = "all"
		else
			if params[:tag_id].eql? "all"
				@events = Event.where(is_published: true).order(:start_date)
			else
				@events = Tag.find_by(id: params[:tag_id]).events.where(is_published: true).order(:start_date)
			end
			@tag_id = params[:tag_id]
		end

		gon.users = []
		gon.socials = []
		gon.sessions = []
		@events.each do |event|
			# gon_events[index].push(user_name: event.users.first.name)
			gon.users.push(event.users.first.name)
			gon.socials.push(event.social)
			gon.sessions.push(event.sessions.order(:start_time))
		end

		gon.events = @events
		gon.tag_id = @tag_id
  end

	private
	def fetch_tags
		@tags = Tag.all.order(:name)
	end
end
