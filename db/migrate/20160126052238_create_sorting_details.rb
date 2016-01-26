class CreateSortingDetails < ActiveRecord::Migration
  def change
    create_table :sorting_details do |t|
      t.integer :sorting_id
      t.integer :article_id
      t.integer :box_qtty
      t.integer :pile_qtty
      t.integer :unit_qtty
      t.boolean :clean
      t.boolean :very_dirty
      t.boolean :broken
      t.boolean :handling

      t.timestamps null: false
    end
  end
end
