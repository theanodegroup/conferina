class Venue < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	mount_uploader :detailed_avatar, DetailedAvatarUploader
	
	belongs_to :user
	belongs_to :location_type
	has_many :locations
end