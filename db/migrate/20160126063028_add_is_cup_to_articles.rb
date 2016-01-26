class AddIsCupToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :is_cup, :boolean
  end
end
