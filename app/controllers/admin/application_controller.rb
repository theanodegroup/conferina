
module Admin
  class ApplicationController < ActionController::Base
    layout 'application'

    protect_from_forgery with: :exception

    before_action :authenticate_user!
    before_action :authenticate_admin

    def authenticate_admin
      return if current_user && current_user.admin?
      redirect_to new_user_session_path, alert: 'Not authorized.'
    end

  end
end