class CreatePersonsSessionsJoin < ActiveRecord::Migration
  def change
    create_table :persons_sessions, :id => false do |t|
    	t.integer "person_id"
    	t.integer "session_id"
    end

    add_index :persons_sessions, ["person_id", "session_id"]
  end
end
