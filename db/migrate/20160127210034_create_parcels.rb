class CreateParcels < ActiveRecord::Migration
  def change
    create_table :parcels do |t|
      t.integer :return_box_id
      t.integer :box_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
