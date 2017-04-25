class TagsController < ApplicationController
	before_action :authenticate_user!

  def show_favorites_modal
  end

	def index
		# @tags = Tag.visible.all.order(:name)

		if !params[:tag_search].blank? && params[:tag_search].eql?('true')
			@tags = Tag.visible.where(params[:sql]).order(:name)
		else
			@tags = Tag.visible.all.order(:name)
		end
	end

	def new
		@tag = Tag.visible.new
	end

	def edit
		@tag = Tag.visible.find(params[:id])
	end

	def update
		@tag = Tag.visible.find(params[:id])

 		if current_user.admin?
		  	if @tag.update(tag_params)
		  		redirect_to tags_path
		  	else
		    	render :edit
		  	end
		end
	end

	def create
		@tag = Tag.visible.new(tag_params)

	 	if current_user.admin?
 		    if @tag.save
				redirect_to tags_path
			else
				render :new
			end
	 	end
	end

	def search
		sql = ''
		if not params[:tag][:name].eql? ''
	      sql = "name ILIKE " + "'%" + params[:tag][:name] + "%'"
	    else
	      sql = 'TRUE'
	    end

	    redirect_to tags_path(tag_search: true, sql: sql)
	end

	def destroy
		@tag = Tag.visible.find(params[:id])
		@tag.events.clear
		@tag.sessions.clear
		@tag.destroy

		redirect_to tags_path
	end

	private

	def tag_params
		params.require(:tag).permit(:name)
	end
end
