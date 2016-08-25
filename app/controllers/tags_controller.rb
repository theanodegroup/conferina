class TagsController < ApplicationController
	before_action :authenticate_user!

	def index
		# @tags = Tag.all.order(:name)

		if (not params[:tag_search].blank?) && (params[:tag_search].eql? 'true')
	      @tags = Tag.where(params[:sql]).order(:name)
	    else
	      @tags = Tag.all.order(:name)
	    end	
	end

	def new
		@tag = Tag.new
	end

	def edit
		@tag = Tag.find(params[:id])
	end

	def update
		@tag = Tag.find(params[:id])

 		if current_user.admin?
		  	if @tag.update(tag_params)
		  		redirect_to tags_path
		  	else
		    	render :edit
		  	end
		end
	end

	def create
		@tag = Tag.new(tag_params)
	 	
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
		@tag = Tag.find(params[:id])
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
