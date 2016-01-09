class CreateOfferBoxes < ActiveRecord::Migration
  def change
    create_table :offer_boxes do |t|
      t.integer :offer_id
      t.integer :box_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
