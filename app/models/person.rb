class Person < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	mount_uploader :detailed_avatar, DetailedAvatarUploader

	acts_as_votable

	belongs_to :person_type
	belongs_to :event
	belongs_to :user

	has_and_belongs_to_many :sessions, :join_table => "persons_sessions"

	has_many :notes, as: :notable
	has_many :favorites, as: :favorites

	def similar_persons
		# @todo: Inefficent in serveral ways (possible duplicated work resolved by uniq)
		tag_ids = self.tags.pluck(:id).uniq # Get this person's tags
		events = Event.includes(:tags).where(tags: { id: tag_ids }).uniq # Find events for those tags
		events.map(&:persons).flatten.uniq # Get the list of person's for those events
	end

	def tags
		self.event.tags
	end
end
