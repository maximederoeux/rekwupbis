class AddEmptyToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :empty, :boolean
  end
end
