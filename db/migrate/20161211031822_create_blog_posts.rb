class CreateBlogPosts < ActiveRecord::Migration[5.0]
  def up
    create_table :blog_posts do |t|
      t.string  :title
      t.string  :content
      t.boolean :comments
      t.boolean :publish
      t.timestamps null: false
    end
  end

  def down
    drop_table :blog_posts
  end
end
