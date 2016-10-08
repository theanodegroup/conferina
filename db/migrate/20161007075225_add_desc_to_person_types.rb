class AddDescToPersonTypes < ActiveRecord::Migration
  def change
  	add_column :person_types, :description, :text
  end
end
