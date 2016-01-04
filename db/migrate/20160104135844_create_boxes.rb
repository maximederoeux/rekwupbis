class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :box_name
      t.boolean :box_regular
      t.string :box_type
      t.integer :box_detail_id

      t.timestamps null: false
    end
  end
end
