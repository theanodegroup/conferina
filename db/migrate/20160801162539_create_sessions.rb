class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :name
      t.text :description
      t.string :start_time
      t.string :end_time
      t.string :avatar
      t.string :detailed_avatar
      t.string :other_time
      t.belongs_to :event, index: true
      t.belongs_to :session_type, index: true
      t.belongs_to :location, index: true

      t.timestamps null: false
    end
  end
end
