class Person < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	
	belongs_to :person_type
	belongs_to :event

	has_and_belongs_to_many :sessions, :join_table => "persons_sessions"
end
