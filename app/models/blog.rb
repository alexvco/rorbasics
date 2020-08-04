class Blog < ApplicationRecord
  belongs_to :author, foreign_key: :user_id, class_name: 'Author'
  has_many :images, as: :imageable, class_name: 'Image', dependent: :destroy
  has_and_belongs_to_many :categories, join_table: :blogs_categories

  enum status: { Private: 0, Paid: 1, Public: 2 }

  # delegate allows you to do this: Blog.first.author_first_name or without the prefix option: Blog.first.first_name
  # instead of Blog.first.author.first_name, do not be fooled it does not solve any n + 1
  # (it makes 2 db queries, 1 for the blog and 1 for the author as opposed to a join)
  # it is identical to: def author_first_name; author.first_name; end
  # the allow_nil: true option is to return Blog.first.author_first_name nil as opposed to an error when author is nil
  # more on delegate here: https://apidock.com/rails/Module/delegate
  delegate :first_name, to: :author, prefix: :author, allow_nil: true
end
