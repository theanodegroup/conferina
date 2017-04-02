class Tag < ActiveRecord::Base
	has_and_belongs_to_many :sessions, :join_table => "tags_sessions"
	has_and_belongs_to_many :events, :join_table => "tags_events"

	acts_as_votable

	ALL_NAME = 'All'

	# Use the below scope to exclude the "All" tag
	scope :visible, -> { where.not(name: ALL_NAME) }
end
