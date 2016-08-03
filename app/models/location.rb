class Location < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	belongs_to :event
	belongs_to :location_type
	has_many :sessions
end
