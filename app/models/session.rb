class Session < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	mount_uploader :detailed_avatar, DetailedAvatarUploader

	belongs_to :event
	belongs_to :session_type
	belongs_to :location

	has_and_belongs_to_many :persons, :join_table => "persons_sessions"
	has_and_belongs_to_many :tags, :join_table => "tags_sessions"

	has_many :notes, as: :notable
	has_many :favorites, as: :favorites
end
