class AddKptBoxToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :kpt_box, :boolean
  end
end
