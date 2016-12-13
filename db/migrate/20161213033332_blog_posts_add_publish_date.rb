class BlogPostsAddPublishDate < ActiveRecord::Migration[5.0]
  def up
    add_column :blog_posts, :publish_date, :date
  end
  
  def down
    remove_column :blog_posts, :publish_date
  end
end