class AddIsTwentyToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :is_twenty, :boolean
    add_column :articles, :is_twentyfive, :boolean
    add_column :articles, :is_forty, :boolean
    add_column :articles, :is_fifty, :boolean
    add_column :articles, :is_litre, :boolean
  end
end
