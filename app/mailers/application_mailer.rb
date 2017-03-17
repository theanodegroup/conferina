class ApplicationMailer < ActionMailer::Base
  default from: "\"Conferina\" <notifications@conferina.com>"
  layout 'mailer'

  protected

  def mail_to(user)
    # @todo: Support multiple users
    "\"#{user.name}\" <#{user.email}>"
  end

  def mail_bcc
    []
  end
end
