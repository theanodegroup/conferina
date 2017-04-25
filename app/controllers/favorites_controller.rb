class FavoritesController < ApplicationController

  def toggle
    # @tod: Fix excessive number of instance vars required to make this work

    # Toggles an item between favorite and unfavorite
    favoritable_id = favoritable_toggle_params[:favoritable_id].to_i
    favoritable_type = favoritable_toggle_params[:favoritable_type].try(:constantize)
    @favorite_button_id = favoritable_toggle_params[:favorite_button_id]
    @favorite_style = favoritable_toggle_params[:favorite_style]

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

  def update
    @favorite_ids = params[:favorite_ids].try(:keys).try(:map, &:to_i) # Nontrivial to whitelist
    @favoritable_type = favoritable_update_params[:favoritable_type].try(:constantize)
    @favorite_style = favoritable_update_params[:favorite_style]

    case @favorite_style
    when Favorite::STYLE_LINK
      favorite_term = 'subscriptions'
    when Favorite::STYLE_STAR
      favorite_term = 'favorites'
    else
      favorite_term = 'favorites'
    end

    puts "TEST: #{@favoritable_type.inspect} #{!@favorite_ids.inspect}"
    puts "TEST: #{@favoritable_type.present?} #{!@favorite_ids.nil?}"

    # Only favorite if id and type present
    if @favoritable_type.present? && !@favorite_ids.nil? # [] is allowed for favorite ids => none
      # Remove old favorites
      @not_favorites = @favoritable_type.where.not(id: @favorite_ids)
      @not_favorites.find_each do |not_favorite|
        not_favorite.unliked_by(current_user) # Unfavorite
      end

      # Add new favorites
      @favorites = @favoritable_type.where(id: @favorite_ids)
      @favorites.each do |favorite|
        favorite.liked_by(current_user) # Favorite
      end

      flash[:notice] = "#{favorite_term} Updated"
    else
      flash[:notice] = "No change to #{favorite_term}s"
    end

  end

  private
    def favoritable_toggle_params
      params.permit(:favoritable_id, :favoritable_type, :user_id, :favorite_button_id, :favorite_style, :authenticity_token)
    end
    def favoritable_update_params
      params.permit(:favoritable_type, :user_id, :favorite_button_id, :favorite_style, :authenticity_token)
    end
end
