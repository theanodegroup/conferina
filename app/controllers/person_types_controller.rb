class PersonTypesController < ApplicationController
	before_action :authenticate_user!

	def index
		@person_types = current_user.person_types.order(:category)	
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
 
	  	if @person_type.update(person_type_params)
	  		redirect_to person_types_path
	  	else
	    	render :edit
	  	end
	end

	def create
		@person_type = PersonType.new(person_type_params)
		if current_user.admin?
			@person_type.by_admin = true
	 	end

	    if @person_type.save
	 		current_user.person_types << @person_type
			redirect_to person_types_path
		else
			render :new
		end
	    
	end

	def destroy
		# if current_user.admin?
		# 	person_type = PersonType.find(params[:id])
		# 	person_type.by_admin = false
		# 	person_type.save
		# end
		# current_user.person_types.delete(params[:id])
		@person_type = PersonType.find(params[:id])
		@person_type.destroy
		 
		redirect_to person_types_path	
	end

	private
  
	def person_type_params
		params.require(:person_type).permit(:category, :avatar)
	end
	
end
