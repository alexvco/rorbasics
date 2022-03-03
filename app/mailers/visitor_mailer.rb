class VisitorMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.visitor_mailer.password_reset.subject
  #
  def password_reset(visitor)
    # this is so that we can use @visitor in app/views/visitor_mailer/password_reset.html.erb
    @visitor = visitor

    mail(
      from: "hello@example.com",
      to: [visitor.email, "another@gmail.com"],
      cc: "a@gmail.com",
      bcc: "b@gmail.com",
      subject: "Password Reset Instructions",
      reply_to: "c@gmail.com"
    )
  end
end
