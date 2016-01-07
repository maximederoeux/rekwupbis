class AddNegociatedPriceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :negociated_price, :boolean
  end
end
