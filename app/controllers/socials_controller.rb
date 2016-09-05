class SocialsController < ApplicationController
	before_action :authenticate_user!

	def update
		@social = Social.find(params[:id])
		@social.update(social_params)
		redirect_to event_data_path(event_id: @social[:event_id], category: 'social')
	end

	private
  
	def social_params
		params.require(:social).permit(:website, :facebook, :twitter, :youtube, :event_id)
	end
	
end
