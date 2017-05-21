class SessionTypesController < ApplicationController
	before_action :authenticate_user!

	def index
    @session_types = current_user.session_types.order(:category)
	end

	def show
		@session_type = SessionType.find(params[:id])
	end

	def new
		@session_type = SessionType.new
		gon.all = current_user.session_types
	end

	def edit
		@session_type = SessionType.find(params[:id])
		gon.all = current_user.session_types
		gon.id = params[:id]
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

	 		if current_user.admin?
		 		User.where("id <> " + current_user.id.to_s).each do |u|
		 			duplicated = false

		 			u.session_types.each do |s|
		 				if s.category.downcase.eql? @session_type.category.downcase
		 					duplicated = true
		 					break
		 				end
		 			end

		 			if !duplicated
		 				new_s = SessionType.new(session_type_params)
		 				if new_s.save
		 					u.session_types << new_s
		 				end
		 			end
		 		end
		 	end

			redirect_to session_types_path
		else
			render :new
		end

	end

	def search
		query = "%#{session_type_params[:category]}%"
		@session_types = current_user.session_types.where('category ILIKE ?', query).order(:category)
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
		params.require(:session_type).permit(:category, :description, :avatar)
	end

end
