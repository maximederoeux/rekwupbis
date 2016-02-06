class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
