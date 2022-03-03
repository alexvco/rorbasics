class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # putting this method here allows you to use this method for more than 1 model (Visitor, User, etc...)
  # and passing column allows you to generate token for more than 1 attribute (auth_token, reset_token, etc...)
  # Remember this is an INSTANCE method that could be shared between different models
  def generate_token(column)
    loop do
      self[column] = SecureRandom.urlsafe_base64(128)
      break unless self.class.exists?(column => self[column])
    end
  end
end
