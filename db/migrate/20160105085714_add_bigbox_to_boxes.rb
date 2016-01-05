class AddBigboxToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :bigbox, :boolean
    add_column :boxes, :smallbox, :boolean
  end
end
