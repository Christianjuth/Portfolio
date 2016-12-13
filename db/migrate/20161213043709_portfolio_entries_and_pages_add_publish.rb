class PortfolioEntriesAndPagesAddPublish < ActiveRecord::Migration[5.0]
  def up
    add_column :pages, :publish, :boolean
    add_column :portfolio_entries, :publish, :boolean
  end
  
  def down
    remove_column :pages, :publish
    remove_column :portfolio_entries, :publish
  end
end
