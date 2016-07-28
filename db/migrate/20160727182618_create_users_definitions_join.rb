class CreateUsersDefinitionsJoin < ActiveRecord::Migration
  def change
    create_table :users_session_types, :id => false do |t|
    	t.integer "user_id"
    	t.integer "session_type_id"
    end
    
	create_table :users_location_types, :id => false do |t|
    	t.integer "user_id"
    	t.integer "location_type_id"
    end
    
	create_table :users_person_types, :id => false do |t|
    	t.integer "user_id"
    	t.integer "person_type_id"
    end
    
	create_table :users_category_types, :id => false do |t|
    	t.integer "user_id"
    	t.integer "category_type_id"
    end
	
	add_index :users_session_types, ["user_id", "session_type_id"]
    add_index :users_location_types, ["user_id", "location_type_id"]
    add_index :users_person_types, ["user_id", "person_type_id"]
    add_index :users_category_types, ["user_id", "category_type_id"]
  end
end
