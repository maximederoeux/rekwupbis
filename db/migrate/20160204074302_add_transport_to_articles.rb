class AddTransportToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :transport, :boolean
  end
end
