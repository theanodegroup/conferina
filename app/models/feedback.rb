class Feedback < ActiveRecord::Base
  belongs_to :user

  SUBJECT_MIN_LENGTH = 3
  CONTENT_MIN_LENGTH = 10
  SUBJECT_MAX_LENGTH = 100
  CONTENT_MAX_LENGTH = 5000

  validates :subject, :content, :email, presence: true
  validates_length_of :subject, minimum: SUBJECT_MIN_LENGTH, maximum: SUBJECT_MAX_LENGTH
  validates_length_of :content, minimum: CONTENT_MIN_LENGTH, maximum: CONTENT_MAX_LENGTH

  after_create :send_feedback_email

  def user_email
    self.email.present? ? self.email : self.user.try(:email)
  end

  def send_feedback_email
    Notifier.feedback_received(self).deliver_now
  end

end
