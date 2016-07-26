class LocationType < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
end
