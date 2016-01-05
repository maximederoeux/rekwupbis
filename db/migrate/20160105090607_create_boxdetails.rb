class CreateBoxdetails < ActiveRecord::Migration
  def change
    create_table :boxdetails do |t|
      t.integer :box_id
      t.integer :article_id
      t.integer :box_article_quantity

      t.timestamps null: false
    end
  end
end
