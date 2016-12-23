class BlogPostsAndPagesAddHeaderImage < ActiveRecord::Migration[5.0]
  def up
    add_column :pages, :header_image, :string
    add_column :blog_posts, :header_image, :string
  end
  
  def down
    remove_column :pages, :header_image
    remove_column :blog_posts, :header_image
  end
end
