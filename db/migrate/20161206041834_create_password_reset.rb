class CreatePasswordReset < ActiveRecord::Migration[5.0]
  def up
    create_table :password_resets do |t|
      t.integer :user_id
      t.string  :token
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :password_resets
  end
end
