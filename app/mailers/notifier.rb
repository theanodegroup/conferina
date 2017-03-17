class Notifier < ApplicationMailer
  default from: "\"Conferina\" <no-reply notifications@conferina.com>"

  def feedback_received(feedback)
    @feedback = feedback
    @user = feedback.user

    mail(
      to: mail_to(User.admin.find_by(email: 'dayo@anode.com.au')),
      bcc: mail_bcc,
      subject: 'Your exported notes'
    )
  end
end
