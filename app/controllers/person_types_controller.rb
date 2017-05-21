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
		gon.all = current_user.person_types
	end

	def edit
		@person_type = PersonType.find(params[:id])
		gon.all = current_user.person_types
		gon.id = params[:id]
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

	 		if current_user.admin?
		 		User.where("id <> " + current_user.id.to_s).each do |u|
		 			duplicated = false

		 			u.person_types.each do |p|
		 				if p.category.downcase.eql? @person_type.category.downcase
		 					duplicated = true
		 					break
		 				end
		 			end

		 			if !duplicated
		 				new_person = PersonType.new(person_type_params)
		 				if new_person.save
		 					u.person_types << new_person
		 				end
		 			end
		 		end
		 	end

			redirect_to person_types_path
		else
			render :new
		end

	end

	def search
		query = "%#{person_type_params[:category]}%"
		@person_types = current_user.person_types.where('category ILIKE ?', query).order(:category)
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
		params.require(:person_type).permit(:category, :description, :avatar)
	end

end
