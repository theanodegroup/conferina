class Session < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	
	belongs_to :event
	belongs_to :session_type
end
