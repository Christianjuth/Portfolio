class CreateApiVerifications < ActiveRecord::Migration
  def up
    create_table :api_verifications do |t|
      t.string :name
      t.string :key
      t.string :secret
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :api_verifications
  end
end