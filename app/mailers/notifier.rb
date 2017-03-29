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

    error_message = nil

    puts "@changes: #{@changes.inspect}"

    if @changes.empty?
      error_message = "Event Updated. Subscriptions not sent: No Changes"
    else
      @tracked_changes_definitions = [
        # Field Display name           Field Name     Field value
        ['Description',                :description,  @event.description],
        ['Call For Papers Due Date',   :call_for,     @event.call_for],
        ['Paper Accepted Notify Date', :notification, @event.notification],
        ['Paper Submission Deadline',  :submission,   @event.submission],
        ['Category',                   :category,     @event.category.category],
        ['Start Date',                 :start_date,   @event.start_date],
        ['End Date',                   :end_date,     @event.end_date],
        ['Address',                    :address,      @event.address],
      ]
      tracked_fields = @tracked_changes_definitions.map{ |definition| definition[1] }

      if (tracked_fields & @changes.keys).empty?
        error_message = "Event Updated. Subscriptions not sent: No tracked changes"
      end

      if @event.is_published?
        # Don't let users see who this is mailed to
        subscribers = @event.votes_for.up.by_type(User).voters

        if subscribers.empty?
          error_message = "Event Updated. Subscriptions not sent: No subscribers"
        end

        subscribers.each do |user|
          @user = user
          mail(
            to: mail_to(user),
            bcc: mail_bcc,
            subject: 'Conferina event has been updated'
          )
        end
      else
        error_message = "Event Updated. Subscriptions not sent: Not published"
      end
    end

    puts error_message unless error_message.nil?
    true # Don't rollback
  end


end
