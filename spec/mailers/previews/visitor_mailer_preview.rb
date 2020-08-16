# Preview all emails at http://localhost:3000/rails/mailers/visitor_mailer
class VisitorMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/visitor_mailer/password_reset
  def password_reset
    VisitorMailer.password_reset
  end

end
