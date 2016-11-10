class CreatePortfolioEntries < ActiveRecord::Migration
  def up
    create_table :portfolio_entries do |t|
      t.string :title
      t.string :font
      t.string :blurb
      t.string :description
      t.string :color
      t.string :github
      t.string :website
      t.datetime :date
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :portfolio_entries
  end
end