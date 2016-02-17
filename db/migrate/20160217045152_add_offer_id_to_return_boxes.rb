class AddOfferIdToReturnBoxes < ActiveRecord::Migration
  def change
    add_column :return_boxes, :offer_id, :integer
  end
end
