class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :subtitle
      t.text :description
      t.string :avatar
      t.string :detailed_avatar
      t.string :website
      t.string :youtube
      t.string :facebook
      t.string :twitter
      t.string :phone
      t.string :email
      t.string :tags
      t.belongs_to :event, index: true
      t.belongs_to :person_type, index: true

      t.timestamps null: false
    end
  end
end
