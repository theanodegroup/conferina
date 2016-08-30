class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :fetch_tags

  protected

  def configure_permitted_parameters
	# Only add some parameters
	# devise_parameter_sanitizer.for(:accept_invitation).concat [:name]
	# # Override accepted parameters
	# devise_parameter_sanitizer.for(:accept_invitation) do |u|
	#   u.permit(:name, :password, :password_confirmation, :invitation_token)
	# end
	devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name, :password, :password_confirmation, :invitation_token])
  end

  def fetch_tags
    @tags = Tag.all.order(:name)	
  end
end
