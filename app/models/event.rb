class Event < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader

	acts_as_votable

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

	def subscribers
		(self.event_subscribers + self.tag_subscribers).uniq
	end

	def tag_subscribers
		# Include both subscribers to each tag as well as any subscribers who subscribed to the "All" Tag
		(self.tags.map(&:subscribers).flatten + Tag.all_tag.votes_for.up.by_type(User).voters)
	end

	def event_subscribers
		votes_for.up.by_type(User).voters
	end
end
