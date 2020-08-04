class Blog < ApplicationRecord
  belongs_to :author, foreign_key: :user_id, class_name: 'Author'
  has_many :images, as: :imageable, class_name: 'Image', dependent: :destroy
  has_and_belongs_to_many :categories, join_table: :blogs_categories

  enum status: { Private: 0, Paid: 1, Public: 2 }
end
