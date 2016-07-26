class CreateSessionTypes < ActiveRecord::Migration
  def change
    create_table :session_types do |t|
      t.string :category
      
      t.timestamps null: false
    end
  end
end
