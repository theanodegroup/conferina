class Event < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	
	has_and_belongs_to_many :users, :join_table => "users_events"

	has_many :sessions
	has_many :persons
	has_many :locations
end
