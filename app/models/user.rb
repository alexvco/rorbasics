class User < ApplicationRecord
  has_many :addresses
  has_many :blogs
  has_many :images, as: :imageable, class_name: 'Image', dependent: :destroy

  accepts_nested_attributes_for :addresses, allow_destroy: true

  def author?
    type == "Author"
  end

  def member?
    type == "Member"
  end
end
