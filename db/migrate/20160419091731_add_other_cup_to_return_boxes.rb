class AddOtherCupToReturnBoxes < ActiveRecord::Migration
  def change
    add_column :return_boxes, :other_cup, :boolean
  end
end
