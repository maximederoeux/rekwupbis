class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :article_name
      t.integer :article_content
      t.string :article_type
      t.string :article_category
      t.integer :quantity_bigbox
      t.integer :quantity_smallbox
      t.integer :quantity_pile

      t.timestamps null: false
    end
  end
end
