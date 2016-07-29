class SessionTypesController < ApplicationController
	before_action :authenticate_user!

	def index
		@session_types = current_user.session_types	
	end

	def show
		@session_type = SessionType.find(params[:id])
	end

	def new
		@session_type = SessionType.new	
	end

	def edit
		@session_type = SessionType.find(params[:id])
	end

	def update
		@session_type = SessionType.find(params[:id])
 
	  	if @session_type.update(session_type_params)
	  		redirect_to session_types_path
	  	else
	    	render :edit
	  	end
	end

	def create
		@session_type = SessionType.new(session_type_params)
		if current_user.admin?
			@session_type.by_admin = true
	 	end

	    if @session_type.save
	 		current_user.session_types << @session_type
			redirect_to session_types_path	
		else
			render :new
		end
	    
	end

	def destroy
		# if current_user.admin?
		# 	session_type = SessionType.find(params[:id])
		# 	session_type.by_admin = false
		# 	session_type.save
		# end
		# current_user.session_types.delete(params[:id])
		@session_type = SessionType.find(params[:id])
		@session_type.destroy
		 
		redirect_to session_types_path	
	end

	private
  
	def session_type_params
		params.require(:session_type).permit(:category, :avatar)
	end
	
end
