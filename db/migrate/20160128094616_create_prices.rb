class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :article_id
      t.integer :user_id
      t.decimal :wash, :precision => 8, :scale => 4
      t.decimal :handwash, :precision => 8, :scale => 4
      t.decimal :handling, :precision => 8, :scale => 4
      t.decimal :deposit, :precision => 8, :scale => 4
      t.boolean :regular
      t.boolean :negociated
      t.date :valid_from
      t.date :valid_till
      t.decimal :sell, :precision => 8, :scale => 4

      t.timestamps null: false
    end
  end
end
