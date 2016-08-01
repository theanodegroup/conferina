class Person < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	
	belongs_to :person_type
	belongs_to :event
end
