class AddEmptyBoxToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :empty_box, :boolean
  end
end
