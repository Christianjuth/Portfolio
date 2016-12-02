class CreateMessages < ActiveRecord::Migration[5.0]
  def up
    create_table :messages do |t|
      t.string :name
      t.string :email
      t.string :fun_fact
      t.string :message
      t.boolean :unread
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :messages
  end
end
