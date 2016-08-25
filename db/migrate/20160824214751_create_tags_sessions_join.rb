class CreateTagsSessionsJoin < ActiveRecord::Migration
  def change
    create_table :tags_sessions, :id => false do |t|
    	t.integer "tag_id"
    	t.integer "session_id"
    end

    add_index :tags_sessions, ["tag_id", "session_id"]
  end
end
