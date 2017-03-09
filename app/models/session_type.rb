class SessionType < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader

	has_and_belongs_to_many :users, :join_table => "users_session_types"

	has_many :sessions
end
