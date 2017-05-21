class LocationTypesController < ApplicationController
	before_action :authenticate_user!

	def index
    @location_types = current_user.location_types.order(:category)
	end

	def show
		@location_type = LocationType.find(params[:id])
	end

	def new
		@location_type = LocationType.new
		gon.all = current_user.location_types
	end

	def edit
		@location_type = LocationType.find(params[:id])
		gon.all = current_user.location_types
		gon.id = params[:id]
	end

	def update
		@location_type = LocationType.find(params[:id])

	  	if @location_type.update(location_type_params)
	  		redirect_to location_types_path
	  	else
	    	render :edit
	  	end
	end

	def create
		@location_type = LocationType.new(location_type_params)
	 	if current_user.admin?
	 		@location_type.by_admin = true
	 	end

    if @location_type.save
	 		current_user.location_types << @location_type

	 		if current_user.admin?
		 		User.where("id <> " + current_user.id.to_s).each do |u|
		 			duplicated = false

		 			u.location_types.each do |loc|
		 				if loc.category.downcase.eql? @location_type.category.downcase
		 					duplicated = true
		 					break
		 				end
		 			end

		 			if !duplicated
		 				new_loc = LocationType.new(location_type_params)
		 				if new_loc.save
		 					u.location_types << new_loc
		 				end
		 			end
		 		end
		 	end

			redirect_to location_types_path
		else
			render :new
		end

	end

	def search
		query = "%#{location_type_params[:category]}%"
		@location_types = current_user.category_types.where('category ILIKE ?', query).order(:category)
	end

	def destroy
		@location_type = LocationType.find(params[:id])
		@location_type.destroy

		redirect_to location_types_path
	end

	private

	def location_type_params
		params.require(:location_type).permit(:category, :avatar)
	end

end
