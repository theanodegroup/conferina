class AddRelationshipToLocation < ActiveRecord::Migration
  def change
  	add_column :locations, :venue_id, :integer
  end
end
