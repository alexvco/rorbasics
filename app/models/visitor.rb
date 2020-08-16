class Visitor < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A.+@.+\..+\z/ }

  before_create { |_visitor| generate_token(:auth_token) }
end
