class CreateSortings < ActiveRecord::Migration
  def change
    create_table :sortings do |t|
      t.integer :return_box_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :starter
      t.integer :ender

      t.timestamps null: false
    end
  end
end
