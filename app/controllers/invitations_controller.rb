class InvitationsController < Devise::InvitationsController
  before_action :authenticate_user!

  def edit
     super
  end

  private

  # this is called when creating invitation
  # should return an instance of resource class
  # def invite_resource(&block)
  #   resource_class.invite!({:email => params[:email], :role => 0}, current_user, &block)
  # end

  # this is called when accepting invitation
  # should return an instance of resource class

  # Temp commented out until determining if it's needed
  # def accept_resource
  #   resource = resource_class.accept_invitation!(update_resource_params)
  #   resource
  # end

  # Invite a Resource (or User) that Has Already Signed Up without Invitation
  # https://github.com/scambra/devise_invitable/wiki/Invite-a-Resource-(or-User)-that-Has-Already-Signed-Up-without-Invitation
  def invite_resource(&block)
    @user = User.find_by(email: invite_params[:email])
    # @user is an instance or nil
    if @user && @user.email != current_user.email
      # invite! instance method returns a Mail::Message instance
      @user.invite!(current_user)
      # return the user instance to match expected return type
      @user
    else
      # invite! class method returns invitable var, which is a User instance
      resource_class.invite!(invite_params, current_inviter, &block)
    end
  end

  private

  def configure_permitted_params
    devise_parameter_sanitizer.for(:accept_invitation) << [:name, :email, :invitation_relation]
  end
end