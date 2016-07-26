class CreateLocationTypes < ActiveRecord::Migration
  def change
    create_table :location_types do |t|
      t.string :category
      
      t.timestamps null: false
    end
  end
end
