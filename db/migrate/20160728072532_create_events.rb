class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.integer :category_id
      t.string :avatar
      t.string :timezone
      t.date :start_date
      t.date :end_date
      t.boolean :coming_soon
      t.string :address
      t.date :call_for
      t.text :extra_desc
      t.date :submission
      t.date :notification
      t.boolean :is_published, :default => false

      t.timestamps null: false
    end
  end
end
