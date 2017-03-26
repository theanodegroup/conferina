class Notifier < ApplicationMailer

  def feedback_received(feedback)
    @feedback = feedback
    @user = feedback.user

    mail(
      to: mail_to(User.admin.find_by(email: 'dayo@anode.com.au')),
      bcc: mail_bcc,
      subject: 'New Conferina feedback received'
    )
  end

  def event_updated(event)
    @event = event
    @changes = event.changes

    # Don't let users see who this is mailed to
    subscribers = @event.votes_for.up.by_type(User).voters
    subscribers.each do |user|
      @user = user
      mail(
        to: mail_to(user),
        bcc: mail_bcc,
        subject: 'Conferina event has been updated'
      )
    end

  end

end
