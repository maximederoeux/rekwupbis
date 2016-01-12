class AddIsReadyToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :is_ready, :boolean
    add_column :deliveries, :is_gone, :boolean
  end
end
