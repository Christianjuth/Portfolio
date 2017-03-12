class CreateUsers < ActiveRecord::Migration
  def up
  	create_table :users do |t|
  		t.string :username
  		t.string :email
  		t.string :hash_salt
  		t.string :hashed_password
  		t.timestamps null: false
  	end
  end

  def down
  	drop_table :users
  end
end
