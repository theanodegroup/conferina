class AddAvatarsToDefinitions < ActiveRecord::Migration
  def change
  	add_column :session_types, :avatar, :string
  	add_column :location_types, :avatar, :string
  	add_column :person_types, :avatar, :string
  	add_column :category_types, :avatar, :string
  end

  
end
