class SessionTypesController < Admin::ApplicationController

	def index
		@session_types = SessionType.all	
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
		@session_type.avatar = params[:avatar]
 
	  	if @session_type.update(session_type_params)
	  		redirect_to session_types_path
	  	else
	    	render :edit
	  	end
	end

	def create
		@session_type = SessionType.new(session_type_params)
		@session_type.avatar = params[:avatar]

	    if @session_type.save
			redirect_to session_types_path	
		else
			render :new
		end
	    
	end

	def destroy
		@session_type = SessionType.find(params[:id])
		@session_type.destroy
		 
		redirect_to session_types_path	
	end

	private
  
	def session_type_params
		params.require(:session_type).permit(:category, :avatar)
	end
	
end
