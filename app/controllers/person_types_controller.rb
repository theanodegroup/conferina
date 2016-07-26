class PersonTypesController < Admin::ApplicationController

	def index
		@person_types = PersonType.all	
	end

	def show
		@person_type = PersonType.find(params[:id])
	end

	def new
		@person_type = PersonType.new	
	end

	def edit
		@person_type = PersonType.find(params[:id])
	end

	def update
		@person_type = PersonType.find(params[:id])
		@person_type.avatar = params[:avatar]
 
	  	if @person_type.update(person_type_params)
	  		redirect_to person_types_path
	  	else
	    	render :edit
	  	end
	end

	def create
		@person_type = PersonType.new(person_type_params)
		@person_type.avatar = params[:avatar]
	 	
	    if @person_type.save
			redirect_to person_types_path
		else
			render :new
		end
	    
	end

	def destroy
		@person_type = PersonType.find(params[:id])
		@person_type.destroy
		 
		redirect_to person_types_path	
	end

	private
  
	def person_type_params
		params.require(:person_type).permit(:category, :avatar)
	end
	
end
