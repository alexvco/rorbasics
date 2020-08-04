class CreateJoinTableCategoriesBlogs < ActiveRecord::Migration[6.0]
  def change
    create_join_table :categories, :blogs do |t|
      # although you generated the migration CategoriesBlogs the table created was named blogs_categories
      t.index :category_id
      t.index :blog_id
    end
  end
end
