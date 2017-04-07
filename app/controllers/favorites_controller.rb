class FavoritesController < ApplicationController

  def toggle
    # @tod: Fix excessive number of instance vars required to make this work

    # Toggles an item between favorite and unfavorite
    favoritable_id = favoritable_params[:favoritable_id].to_i
    favoritable_type = favoritable_params[:favoritable_type].try(:constantize)
    @favorite_button_id = favoritable_params[:favorite_button_id]
    @favorite_style = favoritable_params[:favorite_style]

    case @favorite_style
    when Favorite::STYLE_LINK
      favorite_term = 'subscribed to'
    when Favorite::STYLE_STAR
      favorite_term = 'favorited'
    else
      favorite_term = 'favorited'
    end

    # Only favorite if id and type present
    if favoritable_type.present? && favoritable_id.present?
      @notable = favoritable_type.find_by(id: favoritable_id)

      if current_user.voted_for?(@notable)
        flash[:notice] = "You un#{favorite_term} #{@notable.name}"
        @notable.unliked_by(current_user) # Unfavorite
      else
        flash[:notice] = "You #{favorite_term} #{@notable.name}"
        @notable.liked_by(current_user) # Favorite
      end
    end

    respond_to do |format|
      format.js
    end

  end

  private
    def favoritable_params
      params.permit(:favoritable_id, :favoritable_type, :user_id, :favorite_button_id, :favorite_style, :authenticity_token)
    end
end
