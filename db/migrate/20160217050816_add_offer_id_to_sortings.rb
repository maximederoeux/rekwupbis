class AddOfferIdToSortings < ActiveRecord::Migration
  def change
    add_column :sortings, :offer_id, :integer
  end
end
