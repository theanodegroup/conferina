class Event < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader

	has_and_belongs_to_many :users, :join_table => "users_events"
	has_and_belongs_to_many :tags, :join_table => "tags_events"

	has_many :sessions, dependent: :destroy
	has_many :persons, dependent: :destroy
	has_many :locations, dependent: :destroy

	has_one :social, dependent: :destroy

	belongs_to :category, :class_name => 'CategoryType'

	after_update :send_notification_after_change

	def send_notification_after_change
		Notifier.event_updated(self).deliver_now
	end


	def self.includes_tag_ids(tag_ids)
		includes(:tags).where(tags: { id: tag_ids })
	end
end
