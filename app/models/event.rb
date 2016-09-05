class Event < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	
	has_and_belongs_to_many :users, :join_table => "users_events"
	has_and_belongs_to_many :tags, :join_table => "tags_events"

	has_many :sessions, dependent: :destroy
	has_many :persons, dependent: :destroy
	has_many :locations, dependent: :destroy

	has_one :social, dependent: :destroy
end
