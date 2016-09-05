class CategoryTypesController < ApplicationController
	before_action :authenticate_user!

	def index
		if (not params[:category_type_search].blank?) && (params[:category_type_search].eql? 'true')
	      @category_types = current_user.category_types.where(params[:sql]).order(:category)
	    else
	      @category_types = current_user.category_types.order(:category)
	    end	
	end

	def show
		@category_type = CategoryType.find(params[:id])
	end

	def new
		@category_type = CategoryType.new	
	end

	def edit
		@category_type = CategoryType.find(params[:id])
	end

	def update
		@category_type = CategoryType.find(params[:id])
 
	  	if @category_type.update(category_type_params)
	  		redirect_to category_types_path
	  	else
	    	render :edit
	  	end
	end

	def create
		category_type = CategoryType.new(category_type_params)
		if current_user.admin?
			category_type.by_admin = true
	 	end
	 	
	    if category_type.save
	 		current_user.category_types << category_type
			redirect_to category_types_path
		else
			render :new
		end
	    
	end

	def search
		sql = ''
		if not params[:category_type][:category].eql? ''
	      sql = "category ILIKE " + "'%" + params[:category_type][:category] + "%'"
	    else
	      sql = 'TRUE'
	    end

	    redirect_to category_types_path(category_type_search: true, sql: sql)
	end

	def destroy
		# if current_user.admin?
		# 	category_type = CategoryType.find(params[:id])
		# 	category_type.by_admin = false
		# 	category_type.save
		# end
		# current_user.category_types.delete(params[:id])
		@category_type = LocationType.find(params[:id])
		@category_type.destroy
		 
		redirect_to category_types_path	
	end

	private
  
	def category_type_params
		params.require(:category_type).permit(:category, :avatar)
	end
	
end
