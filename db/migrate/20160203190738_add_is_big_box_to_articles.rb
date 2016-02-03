class AddIsBigBoxToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :is_big_box, :boolean
    add_column :articles, :is_small_box, :boolean
    add_column :articles, :is_top, :boolean
  end
end
