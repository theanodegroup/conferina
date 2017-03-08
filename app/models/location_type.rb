class LocationType < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader

	acts_as_votable

	has_and_belongs_to_many :users, :join_table => "users_location_types"
end
