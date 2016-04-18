class AddIsOtherToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :is_other, :boolean
  end
end
