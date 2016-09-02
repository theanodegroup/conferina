class SearchsController < ApplicationController
	before_action :fetch_tags

	def search
		if params[:tag_id].nil?
			@events = Event.where(is_published: true).order(:name)
			@tag_id = "all"
		else
			if params[:tag_id].eql? "all"
				@events = Event.where(is_published: true).order(:name)
			else
				@events = Tag.find_by(id: params[:tag_id]).events.where(is_published: true).order(:name)
			end
			@tag_id = params[:tag_id]
		end
	end

	private
	def fetch_tags
		@tags = Tag.all.order(:name)	
	end
end
