class AddIsCoronaToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :is_corona, :boolean
  end
end
