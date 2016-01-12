class AddOfferIdToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :offer_id, :integer
  end
end
