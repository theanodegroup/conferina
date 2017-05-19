class User < ActiveRecord::Base
  enum role: [:user, :organizer, :admin]
  after_initialize :set_default_role, :if => :new_record?

	acts_as_voter

  def set_default_role
    self.role ||= :organizer
  end

  def delete_data
    errors = []
    destroy_associations = [:events, :venues, :votes, :people,
                            :person_types, :category_types, :location_types, :users_events]
    destroy_associations.each do |association_name|
      begin
        puts self.try(association_name).inspect
        self.try(association_name).try(:destroy_all)
      rescue StandardError => e
        errors.push "#{e.class}: #{e.message}"
      end
    end

    # Clean up any orphaned records as destory_all seems to only delete the association
    # @todo: Find a better way to handle this
    klasses = [Event, SessionType, LocationType, PersonType, CategoryType]
    klasses.each do |klass|
      klass.find_each { |obj| obj.delete if obj.users.first.nil? }
    end

    errors.empty? ? nil : "Errors: #{errors.join('. ')}"
  end

  def unpublish_events
    errors = []
    begin
      self.events.update_all(is_published: false)
    rescue StandardError => e
      errors.push "#{e.class}: #{e.message}"
    end

    errors.empty? ? nil : "Errors: #{errors.join('. ')}"
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include DeviseInvitable::Inviter

  has_many :invitations, :class_name => self.to_s, :as => :invited_by

  has_many :people, dependent: :destroy
  has_many :venues, dependent: :destroy
  has_many :favorites
  has_many :notes

  has_and_belongs_to_many :session_types, :join_table => "users_session_types"
  has_and_belongs_to_many :location_types, :join_table => "users_location_types"
  has_and_belongs_to_many :person_types, :join_table => "users_person_types"
  has_and_belongs_to_many :category_types, :join_table => "users_category_types"
  has_and_belongs_to_many :events, :join_table => "users_events"
end
