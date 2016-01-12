class AddWeightToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :weight, :decimal
  end
end
