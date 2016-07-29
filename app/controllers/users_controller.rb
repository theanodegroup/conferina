class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => :show

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])

    session_types = user.session_types
    location_types = user.location_types
    person_types = user.person_types
    category_types = user.category_types

    session_types.each do |item|
      SessionType.find_by_id(item.id).destroy
    end

    location_types.each do |item|
      LocationType.find_by_id(item.id).destroy
    end

    person_types.each do |item|
      PersonType.find_by_id(item.id).destroy
    end

    category_types.each do |item|
      CategoryType.find_by_id(item.id).destroy
    end

    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def secure_params
    params.require(:user).permit(:role)
  end

end
