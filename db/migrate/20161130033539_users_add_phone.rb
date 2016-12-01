class UsersAddPhone < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :phone_number, :string
    add_column :users, :phone_verification_code, :string
    add_column :users, :phone_number_verified, :boolean
  end
  
  def down
    remove_column :users, :phone_number
    remove_column :users, :phone_verification_code
    remove_column :users, :phone_number_verified
  end
end
