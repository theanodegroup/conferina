class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :icon_avatar
      t.string :detailed_avatar
      t.string :tags
      t.string :other_time
      t.belongs_to :event, index: true

      t.timestamps null: false
    end
  end
end
