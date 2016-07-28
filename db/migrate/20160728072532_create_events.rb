class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :avatar
      t.string :timezone
      t.date :start_date
      t.date :end_date
      t.boolean :coming_soon
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :extra_name
      t.text :extra_desc
      t.string :extra_date_first_name
      t.string :extra_date_second_name
      t.date :extra_date_first
      t.date :extra_date_second

      t.timestamps null: false
    end
  end
end
