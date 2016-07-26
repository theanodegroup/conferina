class SessionType < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
end
