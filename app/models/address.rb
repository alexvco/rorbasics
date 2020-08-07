class Address < ApplicationRecord
  belongs_to :user
  PER_PAGE = 5
end
