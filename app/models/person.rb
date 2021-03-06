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

	def similar_persons(user)
		# All user events + published events from other users
		# @todo: Inefficent in serveral ways (possible duplicated work resolved by uniq)
		tag_ids = self.tags.pluck(:id) # Get this person's tags
		events = user.events.includes_tag_ids(tag_ids).uniq # Find user events for those tags
		events = (events + Event.includes_tag_ids(tag_ids).uniq).uniq # Find published events for those tags
		similar_persons = events.map(&:persons).flatten.uniq # Get the list of person's for those events
		similar_persons - [self] # Don't include this person
	end

	def tags
		self.event.tags
	end
end
