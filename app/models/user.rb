class User < ActiveRecord::Base
  enum role: [:user, :organizer, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :organizer
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :session_types, :join_table => "users_session_types"
  has_and_belongs_to_many :location_types, :join_table => "users_location_types"
  has_and_belongs_to_many :person_types, :join_table => "users_person_types"
  has_and_belongs_to_many :category_types, :join_table => "users_category_types"
end
