class AddIsShotToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :is_shot, :boolean
  end
end
