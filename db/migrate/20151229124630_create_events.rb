class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_name
      t.date :event_start_date
      t.date :event_end_date
      t.integer :expected_pax
      t.integer :last_pax
      t.string :post_code
      t.string :city
      t.string :country
      t.text :comment
      t.boolean :cuptwenty
      t.boolean :cuptwentyfive
      t.boolean :cupforty
      t.boolean :cupfifty
      t.boolean :cuplitre
      t.boolean :cupwine
      t.boolean :cupcava
      t.boolean :cupshot

      t.timestamps null: false
    end
  end
end
