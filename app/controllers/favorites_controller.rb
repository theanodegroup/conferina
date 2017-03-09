class FavoritesController < ApplicationController

  def toggle
    # @tod: Fix excessive number of instance vars required to make this work

    # Toggles an item between favorite and unfavorite
    favoritable_id = favoritable_params[:favoritable_id].to_i
    favoritable_type = favoritable_params[:favoritable_type].try(:constantize)
    @favorite_button_id = favoritable_params[:favorite_button_id]


    # Only favorite if id and type present
    if favoritable_type.present? && favoritable_id.present?
      @favoritable = favoritable_type.find_by(id: favoritable_id)

      if current_user.voted_for?(@favoritable)
        flash[:notice] = "You unfavorited #{@favoritable.name}"
        @favoritable.unliked_by(current_user) # Unfavorite
      else
        flash[:notice] = "You favorited #{@favoritable.name}"
        @favoritable.liked_by(current_user) # Favorite
      end
    end

    respond_to do |format|
      format.js
    end

  end

  private
    def favoritable_params
      params.permit(:favoritable_id, :favoritable_type, :user_id, :favorite_button_id)
    end
end
