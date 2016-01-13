class AddReadyTimeToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :ready_time, :datetime
    add_column :deliveries, :ready_by, :integer
    add_column :deliveries, :gone_time, :datetime
    add_column :deliveries, :sent_by, :integer
  end
end
