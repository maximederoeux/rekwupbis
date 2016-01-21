class AddWashToReturnBoxes < ActiveRecord::Migration
  def change
    add_column :return_boxes, :wash, :boolean
  end
end
