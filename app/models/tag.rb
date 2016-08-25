class Tag < ActiveRecord::Base
	has_and_belongs_to_many :sessions, :join_table => "tags_sessions"
	has_and_belongs_to_many :events, :join_table => "tags_events"
end
