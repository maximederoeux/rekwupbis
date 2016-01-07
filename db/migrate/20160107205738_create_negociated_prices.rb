class CreateNegociatedPrices < ActiveRecord::Migration
  def change
    create_table :negociated_prices do |t|
      t.integer :article_id
      t.integer :client_id
      t.decimal :washing_price
      t.decimal :handwash_price
      t.decimal :tab_price
      t.decimal :deposit_price

      t.timestamps null: false
    end
  end
end
