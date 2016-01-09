class CreateOfferArticles < ActiveRecord::Migration
  def change
    create_table :offer_articles do |t|
      t.integer :offer_id
      t.integer :article_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
