class User < ApplicationRecord
  has_many :blogs
  has_many :images, as: :imageable, class_name: 'Image', dependent: :destroy
end
