class AddMixedToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :mixed, :boolean
  end
end
