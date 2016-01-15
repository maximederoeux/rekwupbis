class AddReturnDateToReturnBoxes < ActiveRecord::Migration
  def change
    add_column :return_boxes, :return_date, :date
  end
end
