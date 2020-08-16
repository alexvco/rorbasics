class Visitor < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A.+@.+\..+\z/ }

  before_create { |_visitor| generate_token(:auth_token) }

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = DateTime.now
    save!
    VisitorMailer.password_reset(self).deliver
  end
end
