class AddLocationInfoToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :lat, :decimal, precision: 17, scale: 14
  	add_column :events, :lng, :decimal, precision: 17, scale: 14
  end
end
