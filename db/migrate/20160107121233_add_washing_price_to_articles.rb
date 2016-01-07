class AddWashingPriceToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :washing_price, :decimal
    add_column :articles, :handwash_price, :decimal
    add_column :articles, :tab_price, :decimal
    add_column :articles, :deposit_price, :decimal
    add_column :articles, :sell_price, :decimal
    add_column :articles, :is_washable, :boolean
  end
end
