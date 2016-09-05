class CreateTagsEventsJoin < ActiveRecord::Migration
  def change
    create_table :tags_events, :id => false do |t|
    	t.integer "tag_id"
    	t.integer "event_id"
    end

    add_index :tags_events, ["tag_id", "event_id"]
  end
end
