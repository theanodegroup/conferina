class CategoryTypesController < Admin::ApplicationController

	def index
		@category_types = CategoryType.all	
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
		@category_type = CategoryType.new(category_type_params)
		@category_type.by_admin = true
	 	
	    if @category_type.save
			redirect_to category_types_path
		else
			render :new
		end
	    
	end

	def destroy
		@category_type = CategoryType.find(params[:id])
		@category_type.destroy
		 
		redirect_to category_types_path	
	end

	private
  
	def category_type_params
		params.require(:category_type).permit(:category, :avatar)
	end
	
end
