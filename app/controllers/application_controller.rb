class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  helper_method :view_notes_path_builder

  def authenticate_admin!
    return if current_user && current_user.admin?
    redirect_to new_user_session_path, alert: 'Not authorized.'
  end

  protected

  def configure_permitted_parameters
	# Only add some parameters
	# devise_parameter_sanitizer.for(:accept_invitation).concat [:name]
	# # Override accepted parameters
	# devise_parameter_sanitizer.for(:accept_invitation) do |u|
	#   u.permit(:name, :password, :password_confirmation, :invitation_token)
	# end
	devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name, :password, :password_confirmation, :invitation_token])
	# devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
  end

  def view_notes_path_builder(notable)
    view_notes_path(notable_id: notable.id, notable_type: notable.class)
  end
end
