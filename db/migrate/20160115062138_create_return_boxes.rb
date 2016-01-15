class CreateReturnBoxes < ActiveRecord::Migration
  def change
    create_table :return_boxes do |t|
      t.integer :delivery_id
      t.datetime :return_time
      t.boolean :is_back
      t.integer :receptionist
      t.datetime :ctrl_time
      t.integer :ctrler
      t.boolean :is_controlled

      t.timestamps null: false
    end
  end
end
