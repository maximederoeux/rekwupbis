class AddOtherCupToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :other_cup, :boolean
  end
end
