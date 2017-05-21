class SearchsController < ApplicationController
  before_action :fetch_tags

  def search
    @favorite_style = Favorite::STYLE_LINK
    @favorite_type = Tag

    tag_ids = params[:tag_ids].try(:map, &:to_i)
    if tag_ids.present? && tag_ids.size > 1 && tag_ids.first == Tag.all_tag.id
      # Ignore the old all tag
      tag_ids = tag_ids[1..-1]
    end

    @selected_tags = Tag.where(id: tag_ids) if tag_ids.present?
    if @selected_tags.nil? || @selected_tags.where(name: Tag::ALL_NAME).present?
      # Either there are no selected tags, or selected tags include all tag
      @selected_tags = Tag.where(name: Tag::ALL_NAME)
      @events = Event.where(is_published: true).order(:start_date)
    else
      @selected_tags_ids = @selected_tags.pluck(:id)
      @events = Event.where(is_published: true).includes(:tags).where( tags: {id: @selected_tags_ids })
    end

    @selected_tags_ids = @selected_tags.pluck(:id) if @selected_tags_ids.nil?

    @tag_id = params[:tag_id].nil? ? "all" : params[:tag_id]

    gon.users = []
    gon.socials = []
    gon.sessions = []
    @events.each do |event|
      # gon_events[index].push(user_name: event.users.first.name)
      gon.users.push(event.users.first.name)
      gon.socials.push(event.social)
      gon.sessions.push(event.sessions.order(:start_time))
    end

    gon.events = @events
    # gon.tag_id = @tag_id # Don't think this is needed
  end

  private
  def fetch_tags
    @tags = Tag.visible.all.order(:name)
  end

  def filter_events
    # Filter events so that only that include all selected tags are listed
    # This basically turns the OR query on the selected tags to an AND query
    # => This code is no longer used as an OR query was preferred, left if needed.
    @events = @events.to_a.select do |event|
      (event.tags.pluck(:id) & @selected_tags_ids) == @selected_tags_ids
    end
  end
end
