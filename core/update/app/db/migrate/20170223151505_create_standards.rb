class CreateStandards < ActiveRecord::Migration[5.0]
  def up
    create_table :standards do |t|
      t.string  :title
      t.integer :height
      t.integer :width
      t.string  :description
      t.string  :screenshot
      t.string  :source
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :standards
  end
end
