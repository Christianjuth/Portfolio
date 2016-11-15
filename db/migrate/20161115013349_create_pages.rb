class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.string  :title
      t.string  :content
      t.boolean :comments
      t.timestamps null: false
    end
  end

  def down
    drop_table :pages
  end
end
