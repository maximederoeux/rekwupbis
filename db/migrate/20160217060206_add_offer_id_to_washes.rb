class AddOfferIdToWashes < ActiveRecord::Migration
  def change
    add_column :washes, :offer_id, :integer
  end
end
