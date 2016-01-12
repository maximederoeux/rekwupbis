class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.integer :order_id
      t.date :delivery_date
      t.date :return_date

      t.timestamps null: false
    end
  end
end
