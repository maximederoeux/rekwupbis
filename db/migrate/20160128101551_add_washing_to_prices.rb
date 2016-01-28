class AddWashingToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :washing, :decimal, :precision => 8, :scale => 4
  end
end
