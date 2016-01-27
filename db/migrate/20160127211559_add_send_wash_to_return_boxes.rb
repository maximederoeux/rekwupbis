class AddSendWashToReturnBoxes < ActiveRecord::Migration
  def change
    add_column :return_boxes, :send_wash, :boolean
  end
end
