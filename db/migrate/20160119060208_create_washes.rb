class CreateWashes < ActiveRecord::Migration
  def change
    create_table :washes do |t|
      t.integer :return_box_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :washer

      t.timestamps null: false
    end
  end
end
