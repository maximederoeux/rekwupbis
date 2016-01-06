class AddBoxIsFullToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :box_is_full, :boolean
  end
end
