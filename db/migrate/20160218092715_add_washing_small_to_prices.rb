class AddWashingSmallToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :washing_small, :decimal, precision: 8, scale: 4
  end
end
