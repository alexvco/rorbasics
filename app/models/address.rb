class Address < ApplicationRecord
  belongs_to :user
  PER_PAGE = 5

  accepts_nested_attributes_for :user, reject_if: :email_is_blank, allow_destroy: true
  # NOTE: reject_if silently ignores any new record hashes if they fail to pass your criteria,
  # meaning no errors will be raised and User will not be created but Address will

  before_validation :find_or_create_user, on: :create

  def email_is_blank(attributes)
    attributes["email"].blank?
  end

  def find_or_create_user
    self.user = User.find_or_create_by(email: user.email)
  end
end
