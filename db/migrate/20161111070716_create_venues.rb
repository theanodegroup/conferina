class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.string :map_address
      t.string :avatar
      t.string :detailed_avatar
      t.string :phone
      t.text :description
      t.string :subtitle
      t.decimal :lat, precision: 17, scale: 14
      t.decimal :lng, precision: 17, scale: 14
      t.belongs_to :user, index: true
      t.belongs_to :location_type, index: true

      t.timestamps null: false
    end
  end
end
