class SearchsController < ApplicationController
	before_action :fetch_tags

	def search
		@events = Event.all.order(:name)	
	end

	private
	def fetch_tags
		@tags = Tag.all.order(:name)	
	end
end
