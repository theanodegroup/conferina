class CreateSocials < ActiveRecord::Migration
  def change
    create_table :socials do |t|
      t.string :website
      t.string :facebook
      t.string :twitter
      t.string :youtube
      t.belongs_to :event, index: true

      t.timestamps null: false
    end
  end
end
