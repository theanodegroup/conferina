class Person < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	mount_uploader :detailed_avatar, DetailedAvatarUploader

	belongs_to :person_type
	belongs_to :event
	belongs_to :user

	has_and_belongs_to_many :sessions, :join_table => "persons_sessions"

	has_many :notes, as: :notable
end
