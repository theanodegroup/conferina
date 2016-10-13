class AddDescriptionToSessionTypes < ActiveRecord::Migration
  def change
  	add_column :session_types, :description, :text
  	add_column :sessions, :is_published, :boolean, :default => false
  end
end
