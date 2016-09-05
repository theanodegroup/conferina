class PersonTypesController < ApplicationController
	before_action :authenticate_user!

	def index
		if (not params[:person_type_search].blank?) && (params[:person_type_search].eql? 'true')
	      @person_types = current_user.person_types.where(params[:sql]).order(:category)
	    else
	      @person_types = current_user.person_types.order(:category)
	    end	
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

	def search
		sql = ''
		if not params[:person_type][:category].eql? ''
	      sql = "category ILIKE " + "'%" + params[:person_type][:category] + "%'"
	    else
	      sql = 'TRUE'
	    end

	    redirect_to person_types_path(person_type_search: true, sql: sql)
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
