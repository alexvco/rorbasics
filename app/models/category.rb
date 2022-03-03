class Category < ApplicationRecord
  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :blogs, join_table: :blogs_categories
  # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  before_save :squish_name
  before_destroy :destroy_its_blogs

  def squish_name
    self.name = name.squish
  end

  def destroy_its_blogs
    blog_ids = blogs.pluck(:id)
    Blog.where(id: blog_ids)&.destroy_all
    blogs.destroy_all # this only deletes the join table records ("blogs") and not from the blogs table,
    # hence the workaround in previoius line to also delete the blogs
  end
end
