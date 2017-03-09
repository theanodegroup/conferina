class Location < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	mount_uploader :detailed_avatar, DetailedAvatarUploader

	acts_as_votable

	belongs_to :event
	belongs_to :location_type
	belongs_to :venue

	has_many :sessions
	has_many :notes, as: :notable
	has_many :favorites, as: :favorites
end
