class InvitationsController < Devise::InvitationsController
  before_action :authenticate_user!

  private

  # this is called when creating invitation
  # should return an instance of resource class
  # def invite_resource(&block)
  #   resource_class.invite!({:email => params[:email], :role => 0}, current_user, &block)
  # end

  # this is called when accepting invitation
  # should return an instance of resource class
  def accept_resource
    resource = resource_class.accept_invitation!(update_resource_params)
    resource
  end
end