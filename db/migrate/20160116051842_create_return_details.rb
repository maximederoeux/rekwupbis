class CreateReturnDetails < ActiveRecord::Migration
  def change
    create_table :return_details do |t|
      t.integer :return_box_id
      t.integer :box_id
      t.integer :dirty
      t.integer :sealed
      t.integer :clean

      t.timestamps null: false
    end
  end
end
