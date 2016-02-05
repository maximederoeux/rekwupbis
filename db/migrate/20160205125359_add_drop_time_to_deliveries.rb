class AddDropTimeToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :drop_time, :datetime
    add_column :deliveries, :dropped, :boolean
    add_column :deliveries, :dropped_by, :integer
  end
end
