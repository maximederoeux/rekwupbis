class AddUnforeseenReturnToReturnBoxes < ActiveRecord::Migration
  def change
    add_column :return_boxes, :unforeseen_return, :boolean
  end
end
